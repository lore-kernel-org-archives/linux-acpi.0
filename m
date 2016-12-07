From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/5] acpi, nfit: fix bus vs dimm confusion in xlat_status
Date: Tue, 6 Dec 2016 17:46:31 -0800
Message-ID: <CAPcyv4h2c+CCHcdQ6h282n=iDJZXF6piPuWDSVvHxXp8EVs5DQ@mail.gmail.com>
References: <148107115997.25138.3445497812509173966.stgit@dwillia2-desk3.amr.corp.intel.com>
 <148107118149.25138.14111118284998590831.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33773 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLGBqc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2016 20:46:32 -0500
Received: by mail-oi0-f48.google.com with SMTP id w63so401035976oiw.0
        for <linux-acpi@vger.kernel.org>; Tue, 06 Dec 2016 17:46:31 -0800 (PST)
In-Reply-To: <148107118149.25138.14111118284998590831.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Tue, Dec 6, 2016 at 4:39 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Given dimms and bus commands share the same command number space we need
> to be careful that we are translating status in the correct context.
> Otherwise we can, for example, fail an ND_CMD_GET_CONFIG_SIZE command
> because max_xfer is zero. It fails because that condition erroneously
> correlates with the 'cleared == 0' failure of ND_CMD_CLEAR_ERROR.
>
> Cc: <stable@vger.kernel.org>
> Fixes: aef253382266 ("libnvdimm, nfit: centralize command status translation")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit/core.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 4b8b4f520d76..9690b28f0da7 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -94,7 +94,7 @@ static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
>         return to_acpi_device(acpi_desc->dev);
>  }
>
> -static int xlat_status(void *buf, unsigned int cmd, u32 status)
> +static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
>  {
>         struct nd_cmd_clear_error *clear_err;
>         struct nd_cmd_ars_status *ars_status;
> @@ -175,6 +175,15 @@ static int xlat_status(void *buf, unsigned int cmd, u32 status)
>         return 0;
>  }
>
> +static int xlat_status(struct nvdimm *nvdimm, void *buf, unsigned int cmd,
> +               u32 status)
> +{
> +       if (!nvdimm)
> +               return xlat_bus_status(buf, cmd, status);
> +       if (status)
> +               return -EIO;

Here comes a 0day report:

drivers/acpi/nfit/core.c:185:1: warning: control reaches end of
non-void function [-Wreturn-type]

...fixed up the patch to add a return 0;
