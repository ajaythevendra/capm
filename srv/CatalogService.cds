using { anubhav.db.master,  anubhav.db.transaction} from '../db/datamodel';


service CatalogService @(path: 'CatalogService') {

    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    //entity ProductTexts as projection on master.prodtext;
    entity BPset as projection on master.businesspartner;

    entity POs @(
        title: '{i18n>poHeader}'
    )
     as projection on transaction.purchaseorder{
        *,
        round(GROSS_AMOUNT, 2) as GROSS_AMOUNT: Decimal (15,2),
        Items: redirected to POItems
     }actions{
        function largestOrder() returns array of POs;
        action boost();
     }
    
    entity POItems @( title : '{i18n>poItems}' )
    as projection on transaction.poitems{
        *,
        PARENT_KEY: redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }
    

}