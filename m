From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] libnvdimm: use enums for ARS statuses
Date: Thu, 14 Jan 2016 20:29:26 -0800
Message-ID: <CAPcyv4heaYav_o+K4hCGEpwx+de0OMBdMcrjW=naKkPARGJn_A@mail.gmail.com>
References: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
	<1452821516-26788-4-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:34695 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcAOE31 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2016 23:29:27 -0500
Received: by mail-yk0-f175.google.com with SMTP id a85so453422479ykb.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jan 2016 20:29:26 -0800 (PST)
In-Reply-To: <1452821516-26788-4-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linda Knippers <linda.knippers@hpe.com>

On Thu, Jan 14, 2016 at 5:31 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> Replace the status checking in ARS_START, ARS_STATUS with enums for
> readability.
>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/nvdimm/core.c    | 17 +++++++----------
>  drivers/nvdimm/nd-core.h | 13 +++++++++++++
>  2 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
> index 69994036..489414f 100644
> --- a/drivers/nvdimm/core.c
> +++ b/drivers/nvdimm/core.c
> @@ -542,15 +542,14 @@ static int ars_do_start(struct nvdimm_bus_descriptor *nd_desc,
>                 if (rc)
>                         return rc;
>                 switch (cmd->status) {
> -               case 0:
> +               case ND_ARS_START_SUCCESS:
>                         return 0;
> -               case 1:
> +               case ND_ARS_START_UNSUPP:
>                         /* ARS unsupported, but we should never get here */
>                         return 0;
> -               case 2:
> +               case ND_ARS_START_INVALID_PARAM:
>                         return -EINVAL;
> -               case 3:
> -                       /* ARS is in progress */
> +               case ND_ARS_START_IN_PROGRESS:
>                         msleep(1000);
>                         break;

These status codes are dsm spec specific.  I think we should have the
conversion of dsm cmd status to Linux error code happen in the bus
provider.  Currently the status returned from ->ndctl() is the
execution status of the command.  I think we want to change the
definition of ->ndctl_fn to take a pointer to an additional  command
status integer.  That way the core only needs to deal in standard
errno codes and the dsm-status to errno conversion can remain in the
bus-provider-specific code where it belongs.
