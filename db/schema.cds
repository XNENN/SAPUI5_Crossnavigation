using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

namespace db;

entity Cup {
    key ID         : UUID @Core.Computed;
        Name       : String;
        has_Liquid : Association to many LiquidInCup
                         on has_Liquid.to_Cup = $self;
        has_Alcohol: Association to many AlcoholInCup
                         on has_Alcohol.to_Cup = $self;
}

entity Liquid {
    key ID     : UUID @Core.Computed;
        Name   : String;
        in_Cup : Association to many LiquidInCup
                     on in_Cup.to_Liquid = $self;
}

entity Alcohol {
    key ID     : UUID @Core.Computed;
        Name   : String;
        in_Cup : Association to many AlcoholInCup
                     on in_Cup.to_Alcohol = $self;
}

entity LiquidInCup {
    key ID        : UUID @Core.Computed;
        to_Cup    : Association to Cup;
        to_Liquid : Association to Liquid;
}

entity AlcoholInCup {
    key ID        : UUID @Core.Computed;
        to_Cup    : Association to Cup;
        to_Alcohol : Association to Alcohol;
}