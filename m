From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] acpi/nfit: Fix memory corruption/Unregister mce decoder
 on failure
Date: Thu, 18 May 2017 14:11:41 -0400
Message-ID: <1520f1d3-2a64-1e40-b224-dcadbfb36780@redhat.com>
References: <1495065367-30551-1-git-send-email-prarit@redhat.com>
 <1495128822.20330.18.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757130AbdERSLo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 May 2017 14:11:44 -0400
In-Reply-To: <1495128822.20330.18.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linda.knippers@hpe.com" <linda.knippers@hpe.com>



On 05/18/2017 01:35 PM, Verma, Vishal L wrote:
> On Wed, 2017-05-17 at 19:56 -0400, Prarit Bhargava wrote:
>> nfit_init() calls nfit_mce_register() on module load.  When the module
>> load fails the nfit mce decoder is not unregistered.  The module's
>> memory is freed leaving the decoder chain referencing junk.  This will
>> cause panics as future registrations will reference the free'd memory.
>>
>> Only register the nfit mce decoder on success.
> 
> Good find! I'm wondering if registering the mce handler after the rest
> of the init will leave a (small) window open where MCEs can happen but
> the handler has yet to be registered.. Maybe it is inconsequential, and
> we can just do this. Alternatively, if acpi_bus_register_driver fails,
> then go back and unregister the mce handler..

FWIW my first version did exactly what you describe.  I felt like the version
below was a cleaner approach in terms of code, and because I thought that the
possibility of an MCE occurring in those few moments between the return and
registration was minimal.

I could be wrong though :) and I still have that original patch so it isn't a
big deal to do a v2.

P.

> 
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Jeff Moyer <jmoyer@redhat.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
>> Cc: Linda Knippers <linda.knippers@hpe.com>
>> ---
>>  drivers/acpi/nfit/core.c |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 656acb5d7166..b60856b4325b 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -3043,6 +3043,8 @@ static void acpi_nfit_notify(struct acpi_device
>> *adev, u32 event)
>>  
>>  static __init int nfit_init(void)
>>  {
>> +	int ret;
>> +
>>  	BUILD_BUG_ON(sizeof(struct acpi_table_nfit) != 40);
>>  	BUILD_BUG_ON(sizeof(struct acpi_nfit_system_address) != 56);
>>  	BUILD_BUG_ON(sizeof(struct acpi_nfit_memory_map) != 48);
>> @@ -3069,9 +3071,11 @@ static __init int nfit_init(void)
>>  	if (!nfit_wq)
>>  		return -ENOMEM;
>>  
>> -	nfit_mce_register();
>> +	ret = acpi_bus_register_driver(&acpi_nfit_driver);
>> +	if (!ret)
>> +		nfit_mce_register();
>>  
>> -	return acpi_bus_register_driver(&acpi_nfit_driver);
>> +	return ret;
>>  }
>>  
>>  static __exit void nfit_exit(void)
