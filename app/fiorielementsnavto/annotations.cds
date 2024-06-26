using CrossNavigation as service from '../../srv/CrossNavigation-service';

annotate service.Alcohol with @(
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
annotate service.Alcohol with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Alcohol',
            ID : 'Alcohol',
            Target : '@UI.FieldGroup#Alcohol',
        },
    ],
    UI.FieldGroup #Alcohol : {
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
annotate service.Alcohol with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : Name,
        },
        TypeName : '',
        TypeNamePlural : '',
    }
);
