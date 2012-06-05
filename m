From: "Kani, Toshimitsu" <toshi.kani@hp.com>
Subject: Re: [PATCH v4 5/6] ACPI: Add _OST support for ACPI container hotplug
Date: Tue, 5 Jun 2012 15:36:24 +0000
Message-ID: <45D38E03-0465-42A1-AEB3-4D120FFF66DC@hp.com>
References: <1337826324-16802-1-git-send-email-toshi.kani@hp.com>
 <1337826324-16802-6-git-send-email-toshi.kani@hp.com>,<4FCD8D95.1060700@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FCD8D95.1060700@jp.fujitsu.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, "liuj97@gmail.com" <liuj97@gmail.com>, "andi@firstfloor.org" <andi@firstfloor.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Jun 4, 2012, at 9:40 PM, "Yasuaki Ishimatsu" <isimatu.yasuaki@jp.fujitsu.com> wrote:

> Hi Toshi,
> 
> 2012/05/24 11:25, Toshi Kani wrote:
>> Changed container_notify_cb() to call ACPI _OST method when ACPI
>> container hotplug operation has completed. Slightly restructured
>> the code with the same logic. The function sets eject_pending bit
>> for an eject request since it does not initiate hot-remove operation.
>> This bit is checked by the sysfs eject handler to determine if the
>> request is originated from an ACPI eject notification.
>> 
>> Signed-off-by: Toshi Kani<toshi.kani@hp.com>
>> ---
>>  drivers/acpi/container.c |   43 ++++++++++++++++++++++++++++---------------
>>  1 files changed, 28 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
>> index 45cd03b..1f9f7d7 100644
>> --- a/drivers/acpi/container.c
>> +++ b/drivers/acpi/container.c
>> @@ -158,9 +158,7 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
>>      int result;
>>      int present;
>>      acpi_status status;
>> -
>> -
>> -    present = is_device_present(handle);
>> +    u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE; /* default */
>> 
>>      switch (type) {
>>      case ACPI_NOTIFY_BUS_CHECK:
>> @@ -169,32 +167,47 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
>>          printk(KERN_WARNING "Container driver received %s event\n",
>>                 (type == ACPI_NOTIFY_BUS_CHECK) ?
>>                 "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
>> +
>> +        present = is_device_present(handle);
>>          status = acpi_bus_get_device(handle,&device);
>> -        if (present) {
>> -            if (ACPI_FAILURE(status) || !device) {
>> -                result = container_device_add(&device, handle);
>> -                if (!result)
>> -                    kobject_uevent(&device->dev.kobj,
>> -                               KOBJ_ONLINE);
>> -                else
>> -                    printk(KERN_WARNING
>> -                           "Failed to add container\n");
>> -            }
>> -        } else {
>> +        if (!present) {
>>              if (ACPI_SUCCESS(status)) {
>>                  /* device exist and this is a remove request */
>> +                device->flags.eject_pending = 1;
>>                  kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
>> +                return;
>>              }
>> +            break;
>> +        }
>> +
> 
>> +        if (!ACPI_FAILURE(status) || device)
>> +            break;
> 
> The logic is not same as previous logic.
> I think the following logic is correct.
> 
>        if (!ACPI_FAILURE(status) && device)
>            break;

Hi Yasuaki,

Great catch! You are right about that. Now the question is what this code should do when the call failed but the device gets set. This is rather hypothetical case, but I think it is safer to fail a hot add request whenever the device is set. What do you think?

Thanks,
-Toshi

> Thanks,
> Yasuaki Ishimatsu
> 
>> +
>> +        result = container_device_add(&device, handle);
>> +        if (result) {
>> +            printk(KERN_WARNING "Failed to add container\n");
>> +            break;
>>          }
>> +
>> +        kobject_uevent(&device->dev.kobj, KOBJ_ONLINE);
>> +        ost_code = ACPI_OST_SC_SUCCESS;
>>          break;
>> +
>>      case ACPI_NOTIFY_EJECT_REQUEST:
>>          if (!acpi_bus_get_device(handle,&device)&&  device) {
>> +            device->flags.eject_pending = 1;
>>              kobject_uevent(&device->dev.kobj, KOBJ_OFFLINE);
>> +            return;
>>          }
>>          break;
>> +
>>      default:
>> -        break;
>> +        /* non-hotplug event; possibly handled by other handler */
>> +        return;
>>      }
>> +
>> +    /* Inform firmware that the hotplug operation has completed */
>> +    (void) acpi_evaluate_hotplug_ost(handle, type, ost_code, NULL);
>>      return;
>>  }
>> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
