From: Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH] acpi/apei: free lists of resources in einj and erst
Date: Mon, 13 Jul 2015 12:43:17 +0300
Message-ID: <CALYGNiPMAPRgYLe18bePGvXuWCcGf+wCeJGW9QABCjCwXmNSEg@mail.gmail.com>
References: <20150710115832.13167.20624.stgit@buzz>
	<3908561D78D1C84285E8C5FCA982C28F32AA5A72@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33690 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbGMJnS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2015 05:43:18 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32AA5A72@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Chen, Gong" <gong.chen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>

On Fri, Jul 10, 2015 at 9:14 PM, Luck, Tony <tony.luck@intel.com> wrote:
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -379,10 +379,9 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>                         rc = apei_resources_add(&addr_resources,
>                                 trigger_param_region->address,
>                                 trigger_param_region->bit_width/8, true);
> -                       if (rc)
> -                               goto out_fini;
> -                       rc = apei_resources_sub(&trigger_resources,
> -                                       &addr_resources);
> +                       if (!rc)
> +                               rc = apei_resources_sub(&trigger_resources,
> +                                                       &addr_resources);
>                 }
>                 apei_resources_fini(&addr_resources);
>                 if (rc)
>
> This bit looks wrong ... the line right after the this diff ends is
>                         goto out_fini;
>
> so we'll call apei_resources_fini() twice in the rc!=0 case.

As I see it frees different struct apei_resources: here addr_resources and
trigger_resources at the out_fini.

Anyway calling apei_resources_fini twice is safe: it removes and frees ranges
from lists. If these lists are empty apei_resources_fini does nothing.

>
> -Tony
