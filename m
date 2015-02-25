From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 2/9] ACPI: clear up warnings on use of printk reported
 by checkpatch.pl
Date: Wed, 25 Feb 2015 20:55:41 +0800
Message-ID: <54EDC64D.8040301@linaro.org>
References: <1424824585-6405-1-git-send-email-al.stone@linaro.org> <1424824585-6405-3-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33352 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbbBYMzt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2015 07:55:49 -0500
Received: by pabkx10 with SMTP id kx10so5145508pab.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2015 04:55:49 -0800 (PST)
In-Reply-To: <1424824585-6405-3-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, robert.moore@intel.com, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org

On 2015=E5=B9=B402=E6=9C=8825=E6=97=A5 08:36, al.stone@linaro.org wrote=
:
> From: Al Stone <al.stone@linaro.org>
>
> In preparation for later splitting out some of the arch-dependent cod=
e from
> osl.c, clear up all the warnings reported by checkpatch.pl where pr_*=
 should
> be used instead of printk(KERN_* ...).
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>   drivers/acpi/osl.c | 46 +++++++++++++++++++------------------------=
---
>   1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 1dc3a3b..865317c 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -141,7 +141,7 @@ static u32 acpi_osi_handler(acpi_string interface=
, u32 supported)
>   {
>   	if (!strcmp("Linux", interface)) {
>
> -		printk_once(KERN_NOTICE FW_BUG PREFIX
> +		pr_notice_once(FW_BUG PREFIX

I think you can use pr_fmt() and then remove all the PREFIX in
this patch, just

#define pr_fmt(fmt) "ACPI: " fmt

in top of this file before all #includes.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
