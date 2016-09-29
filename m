From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/3] nfit: don't start a full scrub by default for an MCE
Date: Wed, 28 Sep 2016 17:53:22 -0700
Message-ID: <CAPcyv4hsZQYsw=d5tn=yY-tBzMnTT2YP+ZJHd4EtLpxxf-S_ow@mail.gmail.com>
References: <1475107811-8880-1-git-send-email-vishal.l.verma@intel.com> <1475107811-8880-2-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34379 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbcI2AxY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Sep 2016 20:53:24 -0400
Received: by mail-oi0-f51.google.com with SMTP id n132so9903001oih.1
        for <linux-acpi@vger.kernel.org>; Wed, 28 Sep 2016 17:53:23 -0700 (PDT)
In-Reply-To: <1475107811-8880-2-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Linda Knippers <linda.knippers@hpe.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Sep 28, 2016 at 5:10 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> Starting a full Address Range Scrub (ARS) on hitting a memory error
> machine check exception may not always be desirable. Provide a way
> through sysfs to toggle the behavior between just adding the address
> (cache line) where the MCE happened to the poison list and doing a full
> scrub. The former (selective insertion of the address) is done
> unconditionally.


>
> Cc: linux-acpi@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Linda Knippers <linda.knippers@hpe.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 23 ++++++++++++++++++++---
>  drivers/acpi/nfit/mce.c  | 24 +++++++++++++++++++-----
>  drivers/acpi/nfit/nfit.h |  6 ++++++
>  3 files changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 80cc7c0..ec1069e 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -901,6 +901,14 @@ static ssize_t scrub_show(struct device *dev,

I think scrub_show() should display the current auto-scrub mode, right?

>         return rc;
>  }
>
> +/*
> + * The 'scrub' attribute can only have following values written to it:
> + * '1': Start an on-demand scrub, and enable a full scrub to happen if a
> + *      machine check exception for a memory error is received.
> + * '2': Switch to the default mode where a machine check will only insert
> + *      the address on which the memory error was received into the poison
> + *      and badblocks lists.
> + */
>  static ssize_t scrub_store(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t size)
>  {
> @@ -911,15 +919,24 @@ static ssize_t scrub_store(struct device *dev,
>         rc = kstrtol(buf, 0, &val);
>         if (rc)
>                 return rc;
> -       if (val != 1)
> -               return -EINVAL;
>
>         device_lock(dev);
>         nd_desc = dev_get_drvdata(dev);
>         if (nd_desc) {
>                 struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>
> -               rc = acpi_nfit_ars_rescan(acpi_desc);
> +               switch (val) {
> +               case MCE_SCRUB_ON:
> +                       rc = acpi_nfit_ars_rescan(acpi_desc);
> +                       acpi_desc->scrub_mode = MCE_SCRUB_ON;
> +                       break;
> +               case MCE_SCRUB_OFF:
> +                       acpi_desc->scrub_mode = MCE_SCRUB_OFF;
> +                       break;

Shouldn't this still kick off a scrub?  It's awkward that the only way
to run a scrub is to put the driver into automatic re-scrub mode.
