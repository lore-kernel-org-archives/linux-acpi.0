From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] nfit: Continue init even if ARS_CAP is unimplemented
Date: Thu, 3 Mar 2016 13:27:32 -0800
Message-ID: <CAPcyv4gZjaAGD_W-oWN7x+QpgEVzDcoXFCxxQAa70C19yuUOYQ@mail.gmail.com>
References: <1457040097-10038-1-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35166 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbcCCV1d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2016 16:27:33 -0500
Received: by mail-oi0-f45.google.com with SMTP id c203so24792070oia.2
        for <linux-acpi@vger.kernel.org>; Thu, 03 Mar 2016 13:27:33 -0800 (PST)
In-Reply-To: <1457040097-10038-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

On Thu, Mar 3, 2016 at 1:21 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> If firmware doesn't implement any of the ARS commands, take that to
> mean that ARS is unsupported, and continue to initialize regions without
> bad block lists. We cannot make the assumption that ARS commands will be
> unconditionally supported on all NVDIMMs.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/acpi/nfit.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index fb53db1..df99e33 100644
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
> +               dev_warn(acpi_desc->dev,
> +                       "ARS_CAP is not implemented, won't create an error list\n");

s/ARS_CAP/Address range scrub/

Also, let's make this dev_dbg(), since it's not a requirement that a
bus provider implement scrub commands.
