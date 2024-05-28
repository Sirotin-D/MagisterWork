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
    
    func getLocalizedValue() -> LocalizedStringKey? {
        var localizedValue: LocalizedStringKey?
        switch self {
        case .ApplePie:
            localizedValue = FoodLocalizedKeys.ApplePie
        case .BabyBackRibs:
            localizedValue = FoodLocalizedKeys.BabyBackRibs
        case .Baklava:
            localizedValue = FoodLocalizedKeys.Baklava
        case .BeefCarpaccio:
            localizedValue = FoodLocalizedKeys.BeefCarpaccio
        case .BeefTartare:
            localizedValue = FoodLocalizedKeys.BeefTartare
        case .BeetSalad:
            localizedValue = FoodLocalizedKeys.BeetSalad
        case .Beignets:
            localizedValue = FoodLocalizedKeys.Beignets
        case .Bibimbap:
            localizedValue = FoodLocalizedKeys.Bibimbap
        case .BreadPudding:
            localizedValue = FoodLocalizedKeys.BreadPudding
        case .BreakfastBurrito:
            localizedValue = FoodLocalizedKeys.BreakfastBurrito
        case .Bruschetta:
            localizedValue = FoodLocalizedKeys.Bruschetta
        case .CaesarSalad:
            localizedValue = FoodLocalizedKeys.CaesarSalad
        case .Cannoli:
            localizedValue = FoodLocalizedKeys.Cannoli
        case .CapreseSalad:
            localizedValue = FoodLocalizedKeys.CapreseSalad
        case .CarrotCake:
            localizedValue = FoodLocalizedKeys.CarrotCake
        case .Ceviche:
            localizedValue = FoodLocalizedKeys.Ceviche
        case .Cheesecake:
            localizedValue = FoodLocalizedKeys.Cheesecake
        case .CheesePlate:
            localizedValue = FoodLocalizedKeys.CheesePlate
        case .ChickenCurry:
            localizedValue = FoodLocalizedKeys.ChickenCurry
        case .ChickenQuesadilla:
            localizedValue = FoodLocalizedKeys.ChickenQuesadilla
        case .ChickenWings:
            localizedValue = FoodLocalizedKeys.ChickenWings
        case .ChocolateCake:
            localizedValue = FoodLocalizedKeys.ChocolateCake
        case .ChocolateMousse:
            localizedValue = FoodLocalizedKeys.ChocolateMousse
        case .Churros:
            localizedValue = FoodLocalizedKeys.Churros
        case .ClamChowder:
            localizedValue = FoodLocalizedKeys.ClamChowder
        case .ClubSandwich:
            localizedValue = FoodLocalizedKeys.ClubSandwich
        case .CrabCakes:
            localizedValue = FoodLocalizedKeys.CrabCakes
        case .CremeBrulee:
            localizedValue = FoodLocalizedKeys.CremeBrulee
        case .CroqueMadame:
            localizedValue = FoodLocalizedKeys.CroqueMadame
        case .CupCakes:
            localizedValue = FoodLocalizedKeys.CupCakes
        case .DeviledEggs:
            localizedValue = FoodLocalizedKeys.DeviledEggs
        case .Donuts:
            localizedValue = FoodLocalizedKeys.Donuts
        case .Dumplings:
            localizedValue = FoodLocalizedKeys.Dumplings
        case .Edamame:
            localizedValue = FoodLocalizedKeys.Edamame
        case .EggsBenedict:
            localizedValue = FoodLocalizedKeys.EggsBenedict
        case .Escargots:
            localizedValue = FoodLocalizedKeys.Escargots
        case .Falafel:
            localizedValue = FoodLocalizedKeys.Falafel
        case .FiletMignon:
            localizedValue = FoodLocalizedKeys.FiletMignon
        case .FishAndChips:
            localizedValue = FoodLocalizedKeys.FishAndChips
        case .FoieGras:
            localizedValue = FoodLocalizedKeys.FoieGras
        case .FrenchFries:
            localizedValue = FoodLocalizedKeys.FrenchFries
        case .FrenchOnionSoup:
            localizedValue = FoodLocalizedKeys.FrenchOnionSoup
        case .FrenchToast:
            localizedValue = FoodLocalizedKeys.FrenchToast
        case .FriedCalamari:
            localizedValue = FoodLocalizedKeys.FriedCalamari
        case .FriedRice:
            localizedValue = FoodLocalizedKeys.FriedRice
        case .FrozenYogurt:
            localizedValue = FoodLocalizedKeys.FrozenYogurt
        case .GarlicBread:
            localizedValue = FoodLocalizedKeys.GarlicBread
        case .Gnocchi:
            localizedValue = FoodLocalizedKeys.Gnocchi
        case .GreekSalad:
            localizedValue = FoodLocalizedKeys.GreekSalad
        case .GrilledCheeseSandwich:
            localizedValue = FoodLocalizedKeys.GrilledCheeseSandwich
        case .GrilledSalmon:
            localizedValue = FoodLocalizedKeys.GrilledSalmon
        case .Guacamole:
            localizedValue = FoodLocalizedKeys.Guacamole
        case .Gyoza:
            localizedValue = FoodLocalizedKeys.Gyoza
        case .Hamburger:
            localizedValue = FoodLocalizedKeys.Hamburger
        case .HotAndSourSoup:
            localizedValue = FoodLocalizedKeys.HotAndSourSoup
        case .HotDog:
            localizedValue = FoodLocalizedKeys.HotDog
        case .HuevosRancheros:
            localizedValue = FoodLocalizedKeys.HuevosRancheros
        case .Hummus:
            localizedValue = FoodLocalizedKeys.Hummus
        case .IceCream:
            localizedValue = FoodLocalizedKeys.IceCream
        case .Lasagna:
            localizedValue = FoodLocalizedKeys.Lasagna
        case .LobsterBisque:
            localizedValue = FoodLocalizedKeys.LobsterBisque
        case .LobsterRollSandwich:
            localizedValue = FoodLocalizedKeys.LobsterRollSandwich
        case .MacaroniAndCheese:
            localizedValue = FoodLocalizedKeys.MacaroniAndCheese
        case .Macarons:
            localizedValue = FoodLocalizedKeys.Macarons
        case .MisoSoup:
            localizedValue = FoodLocalizedKeys.MisoSoup
        case .Mussels:
            localizedValue = FoodLocalizedKeys.Mussels
        case .Nachos:
            localizedValue = FoodLocalizedKeys.Nachos
        case .Omelette:
            localizedValue = FoodLocalizedKeys.Omelette
        case .OnionRings:
            localizedValue = FoodLocalizedKeys.OnionRings
        case .Oysters:
            localizedValue = FoodLocalizedKeys.Oysters
        case .PadThai:
            localizedValue = FoodLocalizedKeys.PadThai
        case .Paella:
            localizedValue = FoodLocalizedKeys.Paella
        case .Pancakes:
            localizedValue = FoodLocalizedKeys.Pancakes
        case .PannaCotta:
            localizedValue = FoodLocalizedKeys.PannaCotta
        case .PekingDuck:
            localizedValue = FoodLocalizedKeys.PekingDuck
        case .Pho:
            localizedValue = FoodLocalizedKeys.Pho
        case .Pizza:
            localizedValue = FoodLocalizedKeys.Pizza
        case .PorkChop:
            localizedValue = FoodLocalizedKeys.PorkChop
        case .Poutine:
            localizedValue = FoodLocalizedKeys.Poutine
        case .PrimeRib:
            localizedValue = FoodLocalizedKeys.PrimeRib
        case .PulledPorkSandwich:
            localizedValue = FoodLocalizedKeys.PulledPorkSandwich
        case .Ramen:
            localizedValue = FoodLocalizedKeys.Ramen
        case .Ravioli:
            localizedValue = FoodLocalizedKeys.Ravioli
        case .RedVelvetCake:
            localizedValue = FoodLocalizedKeys.RedVelvetCake
        case .Risotto:
            localizedValue = FoodLocalizedKeys.Risotto
        case .Samosa:
            localizedValue = FoodLocalizedKeys.Samosa
        case .Sashimi:
            localizedValue = FoodLocalizedKeys.Sashimi
        case .Scallops:
            localizedValue = FoodLocalizedKeys.Scallops
        case .SeaweedSalad:
            localizedValue = FoodLocalizedKeys.SeaweedSalad
        case .ShrimpAndGrits:
            localizedValue = FoodLocalizedKeys.ShrimpAndGrits
        case .SpaghettiBolognese:
            localizedValue = FoodLocalizedKeys.SpaghettiBolognese
        case .SpaghettiCarbonara:
            localizedValue = FoodLocalizedKeys.SpaghettiCarbonara
        case .SpringRolls:
            localizedValue = FoodLocalizedKeys.SpringRolls
        case .Steak:
            localizedValue = FoodLocalizedKeys.Steak
        case .StrawberryShortCake:
            localizedValue = FoodLocalizedKeys.StrawberryShortCake
        case .Sushi:
            localizedValue = FoodLocalizedKeys.Sushi
        case .Tacos:
            localizedValue = FoodLocalizedKeys.Tacos
        case .Takoyaki:
            localizedValue = FoodLocalizedKeys.Takoyaki
        case .Tiramisu:
            localizedValue = FoodLocalizedKeys.Tiramisu
        case .TunaTartare:
            localizedValue = FoodLocalizedKeys.TunaTartare
        case .Waffles:
            localizedValue = FoodLocalizedKeys.Waffles
        }
        
        return localizedValue
    }
}
