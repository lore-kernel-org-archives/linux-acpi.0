From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v2] ACPI: Fix resource_lock dead lock in acpi_power_on_device
Date: Fri, 14 Sep 2012 09:15:02 +0800
Message-ID: <50528516.2020002@intel.com>
References: <1347440853-12540-1-git-send-email-aaron.lu@intel.com> <201209140026.35993.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1460 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2INBPm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Sep 2012 21:15:42 -0400
In-Reply-To: <201209140026.35993.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Leb Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On 09/14/2012 06:26 AM, Rafael J. Wysocki wrote:
> On Wednesday, September 12, 2012, Aaron Lu wrote:
>> Commit 0090def("ACPI: Add interface to register/unregister device
>> to/from power resources") used resource_lock to protect the devices list
>> that relies on power resource. It caused a mutex dead lock, as below
>>
>>     acpi_power_on ---> lock resource_lock
>>       __acpi_power_on
>>         acpi_power_on_device
>>           acpi_power_get_inferred_state
>>             acpi_power_get_list_state ---> lock resource_lock
>>
>> This patch adds a new mutex "devices_lock" to protect the devices list
>> and calls acpi_power_on_device in acpi_power_on, instead of
>> __acpi_power_on, after the resource_lock is released.
>>
>> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> Good catch, thanks.
> 
> I hope Len won't mind if I take it for v3.6.
> 

Yes, that would be good.
And the commit enters v3.4, so a stable tag may need be added.

>> ---
>> v2:
>> If power resource is already on, no need to check if device needs
>> to be resumed.
>> v1:
>> By Lin Ming.
>>
>>  drivers/acpi/power.c | 36 ++++++++++++++++++++++++------------
>>  1 file changed, 24 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
>> index 215ecd0..3582a26 100644
>> --- a/drivers/acpi/power.c
>> +++ b/drivers/acpi/power.c
>> @@ -105,6 +105,7 @@ struct acpi_power_resource {
>>  
>>  	/* List of devices relying on this power resource */
>>  	struct acpi_power_resource_device *devices;
>> +	struct mutex devices_lock;
>>  };
>>  
>>  static struct list_head acpi_power_resource_list;
>> @@ -223,7 +224,6 @@ static void acpi_power_on_device(struct acpi_power_managed_device *device)
>>  
>>  static int __acpi_power_on(struct acpi_power_resource *resource)
>>  {
>> -	struct acpi_power_resource_device *device_list = resource->devices;
>>  	acpi_status status = AE_OK;
>>  
>>  	status = acpi_evaluate_object(resource->device->handle, "_ON", NULL, NULL);
>> @@ -236,19 +236,14 @@ static int __acpi_power_on(struct acpi_power_resource *resource)
>>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned on\n",
>>  			  resource->name));
>>  
>> -	while (device_list) {
>> -		acpi_power_on_device(device_list->device);
>> -
>> -		device_list = device_list->next;
>> -	}
>> -
>>  	return 0;
>>  }
>>  
>>  static int acpi_power_on(acpi_handle handle)
>>  {
>> -	int result = 0;
>> +	int result = 0, resume_device = 0;
> 
> I'll change the data type of resume_device to bool when applying the patch.
> 

Sure, thanks.

-Aaron
