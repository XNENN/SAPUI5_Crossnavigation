using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

namespace db;

entity Cup {
    ID         : UUID @Core.Computed;
    Name       : String;
    has_Liquid : Composition of many Liquid
                     on has_Liquid.in_Cup = $self;
}

entity Liquid {
    ID     : UUID @Core.Computed;
    Name   : String;
    in_Cup : Association to Cup;
}
