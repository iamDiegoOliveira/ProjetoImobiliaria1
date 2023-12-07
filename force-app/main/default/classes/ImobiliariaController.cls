public class ImobiliariaController {

//Definições das variáveis 


public integer quartos {get; set;}
public integer banheiros {get; set;}
public integer sala {get; set;}
public integer cozinha {get; set;}
public integer quintal {get; set;}
public integer copa {get; set;}
public integer suite {get; set;}
public integer vagasGaragem {get; set;}
public integer valor {get; set;}
public String tipoImovel {get; set;}


//Método Picklist
public List<SelectOption> getMinhasOpcoes(){
    
    //mapear o campo de lista de seleção/picklist que desejo listar
    Schema.DescribeFieldResult describeResult = Imoveis__c.TipoImovel__c.getDescribe();
    
    //listar as opcões válidas dentro do meu campo
    List<Schema.PicklistEntry> entries = describeResult.getPickListValues();
    
    //Cria variável de retorno do tipo de lista para o objeto SelectOption
    List<SelectOption> optionsToReturn = new List<SelectOption>();
    
    //Adiciona as opções do campo listadas
    for(Schema.PicklistEntry pEntry : entries){
        
        //se a opção esta ativa
        //Ou pode aplicar o filtro que quiser, caso não queira mostrar todas as opções
        if(pEntry.isActive()){
            
            //Adiciona o nome e o valor na variável retorno
            optionsToReturn.add(new SelectOption(pEntry.getvalue(), pEntry.getLabel()));
            
        }
        
        
    }
    //Retorna a lista de selectOption criamos na variável de retorno
    return optionsToReturn;
}


//Método salvar
public void salvarImoveis(){
    
    Imoveis__c objImoveis = new Imoveis__c();
    
    objImoveis.Quarto__c = quartos;
    objImoveis.Banheiro__c = banheiros;
    objImoveis.Sala__c = sala;
    objImoveis.Quintal__c = quintal;
    objImoveis.Cozinha__c = cozinha;
    objImoveis.Copa__c = copa;
    objImoveis.Suite__c = suite;
    objImoveis.Garagem__c = vagasGaragem;
    objImoveis.Valor__c = valor;
    objImoveis.TipoImovel__c = tipoImovel;    
    
    
    //Se tipoImovel for diferente de Nenhum e Nulo, insira o objImoveis
    try{
        if (objImoveis.TipoImovel__c != 'Nenhum' && objImoveis.TipoImovel__c != null) {

            //Mensagem de Sucesso, essa mensagem aparecerá na forcePage através do Código <apex:pageMessages id="Showmessage"></apex:pageMessage> que se encontra na forcePage
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Imóvel cadastrado com sucesso!'));
            
            //Insere o Objeto
            insert objImoveis;

            quartos = null;
            banheiros = null;
            sala = null;
            quintal = null;
            cozinha = null;
            copa = null;
            suite = null;
            vagasGaragem = null;
            valor = null;
            tipoImovel = null;
            
            

        } else {
            //Mensagem de Erro
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'O campo Tipo do Imóvel deverá ser preenchido'));
        }

        }catch(DmlException e){  

        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Por favor verifique todos os campos antes de salvar'));
    }
    
}
}