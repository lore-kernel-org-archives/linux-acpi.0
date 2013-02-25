From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: Overriding ACPI tables via initrd only works
 with an initrd and on X86
Date: Mon, 25 Feb 2013 12:00:03 -0800
Message-ID: <CAE9FiQXnJF_qXgG5fN7xE7t40a5yF79hksei6YgYAcmjtaNwOg@mail.gmail.com>
References: <1361538742-67599-1-git-send-email-trenn@suse.de>
	<1361538742-67599-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:63886 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580Ab3BYUAE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2013 15:00:04 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so3532860ieb.20
        for <linux-acpi@vger.kernel.org>; Mon, 25 Feb 2013 12:00:03 -0800 (PST)
In-Reply-To: <1361538742-67599-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: hpa@zytor.com, linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, aaron.lu@intel.com, devurandom@gmx.net

On Fri, Feb 22, 2013 at 5:12 AM, Thomas Renninger <trenn@suse.de> wrote:
> Reflect this dependency in Kconfig.
>
> Shorten the config description as suggested by Borislav Petkov.
>
> Finding a suitable memory area to store the modified table(s) has been
> taken over from arch/x86/kernel/setup.c and makes use of max_low_pfn_mapped:
> memblock_find_in_range(0, max_low_pfn_mapped,...)
> This one is X86 specific. It may not be hard to extend this functionality
> for other ACPI aware architectures if there is need for.
>
> For now make this feature only available for X86 to avoid build failures on
> IA64, compare with:
> https://bugzilla.kernel.org/show_bug.cgi?id=54091
>
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>

what is that?

you need to fix your scripts.

> ---
>  drivers/acpi/Kconfig |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1a4ed64..c692404 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -266,7 +266,8 @@ config ACPI_CUSTOM_DSDT
>         default ACPI_CUSTOM_DSDT_FILE != ""
>
>  config ACPI_INITRD_TABLE_OVERRIDE
> -       bool "ACPI tables can be passed via uncompressed cpio in initrd"
> +       bool "ACPI tables override via initrd"
> +       depends on BLK_DEV_INITRD && X86
>         default n
>         help
>           This option provides functionality to override arbitrary ACPI tables

Can replace max_low_pfn_mapped with max_low_pfn instead ?
like to see if you can put acpi tables above 4G for x86_64.

if it does not work, you can use min(max_low_pfn<<PAGE_SHIFT,  0xffffffffUL)
instead.

Yinghai
