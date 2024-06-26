using CrossNavigation as service from '../../srv/CrossNavigation-service';

annotate service.Cup with @(
    UI.Facets          : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Cups',
            ID    : 'Cups',
            Target: '@UI.FieldGroup#Cups',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Liquids',
            ID    : 'Liquids',
            Target: 'has_Liquid/@UI.LineItem#Liquids',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Alcohol',
            ID : 'Alcohol',
            Target : 'has_Alcohol/@UI.LineItem#Alcohol',
        },
    ],
    UI.FieldGroup #Cups: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ID,
                Label: 'ID',
            },
            {
                $Type: 'UI.DataField',
                Value: Name,
                Label: 'Name',
            },
        ],
    }
);

annotate service.Cup with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: ID,
        Label: 'ID',
    },
    {
        $Type: 'UI.DataField',
        Value: Name,
        Label: 'Name',
    },
]);

annotate service.LiquidInCup with {
    to_Liquid @Common.Text: {
        $value                : to_Liquid.Name,
        ![@UI.TextArrangement]: #TextOnly,
    }
};

annotate service.LiquidInCup with @(UI.LineItem #Liquids: [
    {
        $Type: 'UI.DataField',
        Value: ID,
        Label: 'ID',
    },
    {
        $Type: 'UI.DataField',
        Value: to_Liquid_ID,
        Label: 'Liquid (to ui5)',
    }
]);

annotate service.LiquidInCup with {
    to_Liquid @Common.SemanticObject: 'ui5freestyle'
};

annotate service.Cup with @(UI.HeaderInfo: {
    Title         : {
        $Type: 'UI.DataField',
        Value: Name,
    },
    TypeName      : '',
    TypeNamePlural: '',
});

annotate service.LiquidInCup with {
    to_Liquid @Common.SemanticObjectMapping: [{
        $Type                 : 'Common.SemanticObjectMappingType',
        LocalProperty         : to_Liquid_ID,
        SemanticObjectProperty: 'ID',
    }, ]
};

annotate service.Liquid with @(Communication.Contact #contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
});
annotate service.AlcoholInCup with @(
    UI.LineItem #Alcohol : [
        {
            $Type : 'UI.DataField',
            Value : ID,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : to_Alcohol_ID,
            Label : 'Alcohol (to elements)',
        },]
);
annotate service.AlcoholInCup with {
    to_Alcohol @Common.Text : {
            $value : to_Alcohol.Name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.AlcoholInCup with {
    to_Alcohol @Common.SemanticObject : 'fiorielementsnavto'
};
annotate service.AlcoholInCup with {
    to_Alcohol @Common.SemanticObjectMapping : [
        {
            $Type : 'Common.SemanticObjectMappingType',
            LocalProperty : to_Alcohol_ID,
            SemanticObjectProperty : 'ID',
        },
    ]
};
