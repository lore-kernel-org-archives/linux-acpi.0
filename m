From: "Sajjan, Vikas C" <vikas.cha.sajjan-ZPxbGqLxI0U@public.gmane.org>
Subject: RE: [PATCH] nfit: use devm_add_action_or_reset()
Date: Thu, 7 Jul 2016 04:02:59 +0000
Message-ID: <DF4PR84MB0041088EEAC90477519309A8D93B0@DF4PR84MB0041.NAMPRD84.PROD.OUTLOOK.COM>
References: <1467606771-21704-1-git-send-email-vikas.cha.sajjan@hpe.com>
 <20160704075404.GB10278@linux-rxt1.site>
 <CAPcyv4h3QT9fwkVL6B79S=8UO6K+D8fzybWgr_dVS11vEB5=9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4h3QT9fwkVL6B79S=8UO6K+D8fzybWgr_dVS11vEB5=9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, joeyli <jlee-IBi9RG/b67k@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


-----Original Message-----
From: Dan Williams [mailto:dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org] 
Sent: Thursday, July 07, 2016 3:48 AM
To: joeyli <jlee-IBi9RG/b67k@public.gmane.org>
Cc: Sajjan, Vikas C <vikas.cha.sajjan-ZPxbGqLxI0U@public.gmane.org>; Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org; Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Knippers, Linda <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH] nfit: use devm_add_action_or_reset()

Thanks, applied.

Thank you, Dan.

On Mon, Jul 4, 2016 at 12:54 AM, joeyli <jlee-IBi9RG/b67k@public.gmane.org> wrote:
> On Mon, Jul 04, 2016 at 10:02:51AM +0530, Vikas C Sajjan wrote:
>> If devm_add_action() fails, we are explicitly calling the cleanup to 
>> free the resources allocated. Lets use the helper 
>> devm_add_action_or_reset() and return directly in case of error, 
>> since the cleanup function has been already called by the helper if there was any error.
>>
>> Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan-ZPxbGqLxI0U@public.gmane.org>
>> ---
>>  drivers/acpi/nfit.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c index 
>> c2ad967..44ebe1e 100644
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
> Reviewed-by: Lee, Chun-Yi <jlee-IBi9RG/b67k@public.gmane.org>
>
> Joey Lee
