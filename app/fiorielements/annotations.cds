using CrossNavigation as service from '../../srv/CrossNavigation-service';

annotate service.Cup with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Cups',
            ID : 'Cups',
            Target : '@UI.FieldGroup#Cups',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Liquids',
            ID : 'Liquids',
            Target : 'has_Liquid/@UI.LineItem#Liquids',
        },
    ],
    UI.FieldGroup #Cups : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },{
                $Type : 'UI.DataField',
                Value : Name,
                Label : 'Name',
            },],
    }
);
annotate service.Cup with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : Name,
            Label : 'Name',
        },
    ]
);
annotate service.LiquidInCup with {
    to_Liquid @Common.Text : {
            $value : to_Liquid.Name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};

annotate service.LiquidInCup with @(
    UI.LineItem #Liquids : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },{
            $Type : 'UI.DataField',
            Value : to_Liquid_ID,
            Label : 'Liquid',
        },]
);
annotate service.LiquidInCup with {
    to_Liquid @Common.SemanticObject : 'ui5freestyle'
};

annotate service.LiquidInCup with {
    to_Liquid @Common.SemanticObjectMapping : [
        {
            $Type : 'Common.SemanticObjectMappingType',
            LocalProperty : to_Liquid_ID,
            SemanticObjectProperty : 'ID',
        },
    ]
};
