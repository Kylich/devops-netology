# Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."

## Задача 1. 
Давайте потренируемся читать исходный код AWS провайдера, который можно склонировать от сюда: 
[https://github.com/hashicorp/terraform-provider-aws.git](https://github.com/hashicorp/terraform-provider-aws.git).
Просто найдите нужные ресурсы в исходном коде и ответы на вопросы станут понятны.  


1. Найдите, где перечислены все доступные `resource` и `data_source`, приложите ссылку на эти строки в коде на 
гитхабе.   
- [resource](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L411)
- [data_source](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/provider.go#L169)

2. Для создания очереди сообщений SQS используется ресурс `aws_sqs_queue` у которого есть параметр `name`. 
  * С каким другим параметром конфликтует `name`? Приложите строчку кода, в которой это указано.
    - [ссылка](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/resource_aws_sqs_queue.go#L51)
```terraform
name": {
  Type:          schema.TypeString,
  Optional:      true,
  ForceNew:      true,
  Computed:      true,
  ConflictsWith: []string{"name_prefix"},
  ValidateFunc:  validateSQSQueueName,
},
"name_prefix": {
  Type:          schema.TypeString,
  Optional:      true,
  ForceNew:      true,
  ConflictsWith: []string{"name"},
}
```
      
  * Какая максимальная длина имени?
    - [80 символов](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1037)
 
  * Какому регулярному выражению должно подчиняться имя? 
    - [`^[0-9A-Za-z-_]+$`](https://github.com/hashicorp/terraform-provider-aws/blob/8e4d8a3f3f781b83f96217c2275f541c893fec5a/aws/validators.go#L1054)
