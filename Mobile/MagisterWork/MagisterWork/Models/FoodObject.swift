//
//  FoodObject.swift
//

import SwiftUI

enum FoodObject: String, CaseIterable {
    case ApplePie = "Apple pie"
    case BabyBackRibs = "Baby back ribs"
    case Baklava = "Baklava"
    case BeefCarpaccio = "Beef carpaccio"
    case BeefTartare = "Beef tartare"
    case BeetSalad = "Beet salad"
    case Beignets = "Beignets"
    case Bibimbap = "Bibimbap"
    case BreadPudding = "Bread pudding"
    case BreakfastBurrito = "Breakfast burrito"
    case Bruschetta = "Bruschetta"
    case CaesarSalad = "Caesar salad"
    case Cannoli = "Cannoli"
    case CapreseSalad = "Caprese salad"
    case CarrotCake = "Carrot cake"
    case Ceviche = "Ceviche"
    case Cheesecake = "Cheesecake"
    case CheesePlate = "Cheese plate"
    case ChickenCurry = "Chicken curry"
    case ChickenQuesadilla = "Chicken quesadilla"
    case ChickenWings = "Chicken wings"
    case ChocolateCake = "Chocolate cake"
    case ChocolateMousse = "Chocolate mousse"
    case Churros = "Churros"
    case ClamChowder = "Clam chowder"
    case ClubSandwich = "Club sandwich"
    case CrabCakes = "Crab cakes"
    case CremeBrulee = "Creme brulee"
    case CroqueMadame = "Croque madame"
    case CupCakes = "Cup cakes"
    case DeviledEggs = "Deviled eggs"
    case Donuts = "Donuts"
    case Dumplings = "Dumplings"
    case Edamame = "Edamame"
    case EggsBenedict = "Eggs benedict"
    case Escargots = "Escargots"
    case Falafel = "Falafel"
    case FiletMignon = "Filet mignon"
    case FishAndChips = "Fish and chips"
    case FoieGras = "Foie gras"
    case FrenchFries = "French fries"
    case FrenchOnionSoup = "French onion soup"
    case FrenchToast = "French toast"
    case FriedCalamari = "Fried calamari"
    case FriedRice = "Fried rice"
    case FrozenYogurt = "Frozen yogurt"
    case GarlicBread = "Garlic bread"
    case Gnocchi = "Gnocchi"
    case GreekSalad = "Greek salad"
    case GrilledCheeseSandwich = "Grilled cheese sandwich"
    case GrilledSalmon = "Grilled salmon"
    case Guacamole = "Guacamole"
    case Gyoza = "Gyoza"
    case Hamburger = "Hamburger"
    case HotAndSourSoup = "Hot and sour soup"
    case HotDog = "Hot dog"
    case HuevosRancheros = "Huevos rancheros"
    case Hummus = "Hummus"
    case IceCream = "Ice cream"
    case Lasagna = "Lasagna"
    case LobsterBisque = "Lobster bisque"
    case LobsterRollSandwich = "Lobster roll sandwich"
    case MacaroniAndCheese = "Macaroni and cheese"
    case Macarons = "Macarons"
    case MisoSoup = "Miso soup"
    case Mussels = "Mussels"
    case Nachos = "Nachos"
    case Omelette = "Omelette"
    case OnionRings = "Onion rings"
    case Oysters = "Oysters"
    case PadThai = "Pad thai"
    case Paella = "Paella"
    case Pancakes = "Pancakes"
    case PannaCotta = "Panna cotta"
    case PekingDuck = "Peking duck"
    case Pho = "Pho"
    case Pizza = "Pizza"
    case PorkChop = "Pork chop"
    case Poutine = "Poutine"
    case PrimeRib = "Prime rib"
    case PulledPorkSandwich = "Pulled pork sandwich"
    case Ramen = "Ramen"
    case Ravioli = "Ravioli"
    case RedVelvetCake = "Red velvet cake"
    case Risotto = "Risotto"
    case Samosa = "Samosa"
    case Sashimi = "Sashimi"
    case Scallops = "Scallops"
    case SeaweedSalad = "Seaweed salad"
    case ShrimpAndGrits = "Shrimp and grits"
    case SpaghettiBolognese = "Spaghetti bolognese"
    case SpaghettiCarbonara = "Spaghetti carbonara"
    case SpringRolls = "Spring rolls"
    case Steak = "Steak"
    case StrawberryShortCake = "Strawberry shortcake"
    case Sushi = "Sushi"
    case Tacos = "Tacos"
    case Takoyaki = "Takoyaki"
    case Tiramisu = "Tiramisu"
    case TunaTartare = "Tuna tartare"
    case Waffles = "Waffles"
    
    func getValue() -> String {
        self.rawValue
    }
    
    func getFoodImage() -> UIImage? {
        let foodName = self.getValue()
        let words = foodName.split(separator: " ")
        let capitalizedWords = words.map { $0.capitalized }
        let result = capitalizedWords.joined()
        let formattedFoodName = result + "Image"
        return UIImage(named: formattedFoodName)
    }
}

extension FoodObject {
    static func getMockFoodName() -> String {
        self.ApplePie.getValue()
    }
}
