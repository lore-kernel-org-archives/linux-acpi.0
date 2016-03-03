From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] nfit: Continue init even if ARS commands are unimplemented
Date: Thu, 3 Mar 2016 14:53:29 -0800
Message-ID: <CAPcyv4jzitH+gCL_z+ZHnqTV0TP-cvR_KKQ1JjmXatuKg4QwaA@mail.gmail.com>
References: <1457044781-15443-1-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33535 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcCCWxa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2016 17:53:30 -0500
Received: by mail-ob0-f182.google.com with SMTP id fz5so34912690obc.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Mar 2016 14:53:30 -0800 (PST)
In-Reply-To: <1457044781-15443-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

On Thu, Mar 3, 2016 at 2:39 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> If firmware doesn't implement any of the ARS commands, take that to
> mean that ARS is unsupported, and continue to initialize regions without
> bad block lists. We cannot make the assumption that ARS commands will be
> unconditionally supported on all NVDIMMs.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>
> v2:
> - improve the debug message when we his this unimplemented case (Dan).
>
>  drivers/acpi/nfit.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index fb53db1..35947ac 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -1590,14 +1590,21 @@ static int acpi_nfit_find_poison(struct acpi_nfit_desc *acpi_desc,
>         start = ndr_desc->res->start;
>         len = ndr_desc->res->end - ndr_desc->res->start + 1;
>
> +       /*
> +        * If ARS is unimplemented, unsupported, or if the 'Persistent Memory
> +        * Scrub' flag in extended status is not set, skip this but continue
> +        * initialization
> +        */
>         rc = ars_get_cap(nd_desc, ars_cap, start, len);
> +       if (rc == -ENOTTY) {
> +               dev_dbg(acpi_desc->dev,
> +                       "Address Range Scrub is not implemented, won't create an error list\n");
> +               rc = 0;
> +               goto out;
> +       }
>         if (rc)
>                 goto out;
>
> -       /*
> -        * If ARS is unsupported, or if the 'Persistent Memory Scrub' flag in
> -        * extended status is not set, skip this but continue initialization
> -        */
>         if ((ars_cap->status & 0xffff) ||
>                 !(ars_cap->status >> 16 & ND_ARS_PERSISTENT)) {
>                 dev_warn(acpi_desc->dev,
> --
> 2.5.0
>


Looks good to me.  Thanks Vishal!
