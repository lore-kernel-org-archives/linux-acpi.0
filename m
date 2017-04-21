From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] acpi, nfit: fix the memory error check in nfit_handle_mce
Date: Fri, 21 Apr 2017 12:21:01 -0700
Message-ID: <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w@mail.gmail.com>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36114 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424798AbdDUTVD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2017 15:21:03 -0400
Received: by mail-oi0-f46.google.com with SMTP id s131so22361398oia.3
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2017 12:21:02 -0700 (PDT)
In-Reply-To: <20170420221818.23522-1-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Thu, Apr 20, 2017 at 3:18 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> The check for an MCE being a memory error in the NFIT mce handler was
> bogus. Fix it to check for the correct MCA status compound error code.
>
> Reported-by: Tony Luck <tony.luck@intel.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/acpi/nfit/mce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
> index 3ba1c34..23e12a0 100644
> --- a/drivers/acpi/nfit/mce.c
> +++ b/drivers/acpi/nfit/mce.c
> @@ -26,7 +26,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
>         struct nfit_spa *nfit_spa;
>
>         /* We only care about memory errors */
> -       if (!(mce->status & MCACOD))
> +       if (!(mce->status & 0xef80) == BIT(7))

Can we get a define for this, or a comment explaining all the magic
that's happening on that one line?
