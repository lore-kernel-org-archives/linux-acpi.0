From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] nfit: fix _FIT evaluation memory leak
Date: Thu, 14 Jul 2016 22:27:07 -0700
Message-ID: <CAPcyv4ioH59KiQruBZS4oGHFPWF1F4StwWq-kdaMF2ACmix7sA@mail.gmail.com>
References: <146855333714.573.13934675433503265133.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20160715051553.GE27155@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33497 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbcGOF1I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2016 01:27:08 -0400
Received: by mail-oi0-f47.google.com with SMTP id j185so142462422oih.0
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jul 2016 22:27:08 -0700 (PDT)
In-Reply-To: <20160715051553.GE27155@linux-rxt1.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Vishal Verma <vishal.l.verma@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Xiao Guangrong <guangrong.xiao@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On Thu, Jul 14, 2016 at 10:15 PM, joeyli <jlee@suse.com> wrote:
> Hi Dan,
>
> On Thu, Jul 14, 2016 at 08:28:57PM -0700, Dan Williams wrote:
>> acpi_evaluate_object() allocates memory. Free the buffer allocated
>> during acpi_nfit_add().
>>
>> Cc: <stable@vger.kernel.org>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Reported-by: Xiao Guangrong <guangrong.xiao@intel.com>
>> Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/acpi/nfit.c |    7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
>> index 0497175ee6cb..008dbaaa2b75 100644
>> --- a/drivers/acpi/nfit.c
>> +++ b/drivers/acpi/nfit.c
>> @@ -2414,12 +2414,15 @@ static int acpi_nfit_add(struct acpi_device *adev)
>>                       acpi_desc->nfit =
>>                               (struct acpi_nfit_header *)obj->buffer.pointer;
>>                       sz = obj->buffer.length;
>> +                     rc = acpi_nfit_init(acpi_desc, sz);
>>               } else
>>                       dev_dbg(dev, "%s invalid type %d, ignoring _FIT\n",
>>                                __func__, (int) obj->type);
>> -     }
>> +             kfree(buf.pointer);
>> +             acpi_desc->nfit = NULL;
>
> Looks "acpi_desc->nfit = NULL" statement will be removed in [PATCH 2/2]
> immediately. Why add it in PATCH 1?

I was debating it, but for code readability of -stable kernels (where
patch2 will not be included) I want to make it clear that nothing uses
the value of ->nfit outside of acpi_nfit_init().

>
>> +     } else
>> +             rc = acpi_nfit_init(acpi_desc, sz);
>>
>> -     rc = acpi_nfit_init(acpi_desc, sz);
>>       if (rc) {
>>               nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
>>               return rc;
>>
>
> Other parts are no problem to me.

Thanks.
