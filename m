From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nfit: use devm_add_action_or_reset()
Date: Wed, 6 Jul 2016 15:18:20 -0700
Message-ID: <CAPcyv4h3QT9fwkVL6B79S=8UO6K+D8fzybWgr_dVS11vEB5=9A@mail.gmail.com>
References: <1467606771-21704-1-git-send-email-vikas.cha.sajjan@hpe.com> <20160704075404.GB10278@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33696 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbcGFWSW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2016 18:18:22 -0400
Received: by mail-oi0-f54.google.com with SMTP id u201so493812oie.0
        for <linux-acpi@vger.kernel.org>; Wed, 06 Jul 2016 15:18:22 -0700 (PDT)
In-Reply-To: <20160704075404.GB10278@linux-rxt1.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linda Knippers <linda.knippers@hpe.com>

Thanks, applied.

On Mon, Jul 4, 2016 at 12:54 AM, joeyli <jlee@suse.com> wrote:
> On Mon, Jul 04, 2016 at 10:02:51AM +0530, Vikas C Sajjan wrote:
>> If devm_add_action() fails, we are explicitly calling the cleanup to free
>> the resources allocated. Lets use the helper devm_add_action_or_reset()
>> and return directly in case of error, since the cleanup function
>> has been already called by the helper if there was any error.
>>
>> Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
>> ---
>>  drivers/acpi/nfit.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
>> index c2ad967..44ebe1e 100644
>> --- a/drivers/acpi/nfit.c
>> +++ b/drivers/acpi/nfit.c
>> @@ -1920,11 +1920,11 @@ static int acpi_nfit_insert_resource(struct acpi_nfit_desc *acpi_desc,
>>       if (ret)
>>               return ret;
>>
>> -     ret = devm_add_action(acpi_desc->dev, acpi_nfit_remove_resource, res);
>> -     if (ret) {
>> -             remove_resource(res);
>> +     ret = devm_add_action_or_reset(acpi_desc->dev,
>> +                                     acpi_nfit_remove_resource,
>> +                                     res);
>> +     if (ret)
>>               return ret;
>> -     }
>>
>>       return 0;
>>  }
>> --
>> 1.9.1
>>
>
> Reviewed-by: Lee, Chun-Yi <jlee@suse.com>
>
> Joey Lee
