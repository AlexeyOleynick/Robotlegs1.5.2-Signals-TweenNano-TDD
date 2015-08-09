package alexey.oleynick.model {
import alexey.oleynick.model.service.IImageService;

import flash.display.Bitmap;

public class ServiceImageModel implements IImageModel {

    private var imageService:IImageService;

    public function ServiceImageModel(imageService:IImageService) {
        this.imageService = imageService;
    }

    public function getRandomBitmap():Bitmap {
        var availableImageIds:Vector.<int> = imageService.availableIds;
        var randomArrayIndex:int = Math.floor(Math.random() * availableImageIds.length);
        var randomImageId:int = availableImageIds[randomArrayIndex];
        var image:Bitmap = imageService.getImageById(randomImageId);
        return image;
    }
}
}
