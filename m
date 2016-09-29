From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] nfit: don't start a full scrub by default for an MCE
Date: Wed, 28 Sep 2016 19:26:10 -0700
Message-ID: <CAPcyv4hBCtUBs=YZeqfVmjJrfdoo8HXJQWQXG9bz5Lxx5utvQg@mail.gmail.com>
References: <1475107811-8880-1-git-send-email-vishal.l.verma@intel.com>
 <1475107811-8880-2-git-send-email-vishal.l.verma@intel.com>
 <CAPcyv4hsZQYsw=d5tn=yY-tBzMnTT2YP+ZJHd4EtLpxxf-S_ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4hsZQYsw=d5tn=yY-tBzMnTT2YP+ZJHd4EtLpxxf-S_ow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Sep 28, 2016 at 5:53 PM, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Sep 28, 2016 at 5:10 PM, Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> Starting a full Address Range Scrub (ARS) on hitting a memory error
>> machine check exception may not always be desirable. Provide a way
>> through sysfs to toggle the behavior between just adding the address
>> (cache line) where the MCE happened to the poison list and doing a full
>> scrub. The former (selective insertion of the address) is done
>> unconditionally.
>
>
>>
>> Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/acpi/nfit/core.c | 23 ++++++++++++++++++++---
>>  drivers/acpi/nfit/mce.c  | 24 +++++++++++++++++++-----
>>  drivers/acpi/nfit/nfit.h |  6 ++++++
>>  3 files changed, 45 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>> index 80cc7c0..ec1069e 100644
>> --- a/drivers/acpi/nfit/core.c
>> +++ b/drivers/acpi/nfit/core.c
>> @@ -901,6 +901,14 @@ static ssize_t scrub_show(struct device *dev,
>
> I think scrub_show() should display the current auto-scrub mode, right?
>
>>         return rc;
>>  }
>>
>> +/*
>> + * The 'scrub' attribute can only have following values written to it:
>> + * '1': Start an on-demand scrub, and enable a full scrub to happen if a
>> + *      machine check exception for a memory error is received.
>> + * '2': Switch to the default mode where a machine check will only insert
>> + *      the address on which the memory error was received into the poison
>> + *      and badblocks lists.
>> + */
>>  static ssize_t scrub_store(struct device *dev,
>>                 struct device_attribute *attr, const char *buf, size_t size)
>>  {
>> @@ -911,15 +919,24 @@ static ssize_t scrub_store(struct device *dev,
>>         rc = kstrtol(buf, 0, &val);
>>         if (rc)
>>                 return rc;
>> -       if (val != 1)
>> -               return -EINVAL;
>>
>>         device_lock(dev);
>>         nd_desc = dev_get_drvdata(dev);
>>         if (nd_desc) {
>>                 struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>>
>> -               rc = acpi_nfit_ars_rescan(acpi_desc);
>> +               switch (val) {
>> +               case MCE_SCRUB_ON:
>> +                       rc = acpi_nfit_ars_rescan(acpi_desc);
>> +                       acpi_desc->scrub_mode = MCE_SCRUB_ON;
>> +                       break;
>> +               case MCE_SCRUB_OFF:
>> +                       acpi_desc->scrub_mode = MCE_SCRUB_OFF;
>> +                       break;
>
> Shouldn't this still kick off a scrub?  It's awkward that the only way
> to run a scrub is to put the driver into automatic re-scrub mode.

Hmm, although it will probably still be awkward if we make it do a
scrub in this case.  Might be better to have a separate "auto_scrub"
property that sets what to do on latent error detection.
