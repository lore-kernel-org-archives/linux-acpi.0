From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH v2 08/20] x86, ACPI: Find acpi tables in initrd early from head_32.S/head64.c
Date: Sun, 10 Mar 2013 12:25:12 +0200
Message-ID: <CAOJsxLG2Qg7vmLWirWK-GOBp65NxogGcAU5guoVphDu2G=BsjA@mail.gmail.com>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org>
	<1362897887-30808-9-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:56037 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3CJKZO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Mar 2013 06:25:14 -0400
In-Reply-To: <1362897887-30808-9-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Sun, Mar 10, 2013 at 8:44 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> +void __init x86_acpi_override_find(void)
> +{
> +       unsigned long ramdisk_image, ramdisk_size;
> +       unsigned char *p = NULL;
> +
> +#ifdef CONFIG_X86_32
> +       struct boot_params *boot_params_p;
> +
> +       /*
> +        * 32bit is from head_32.S, and it is 32bit flat mode.
> +        * So need to use phys address to access global variables.
> +        */
> +       boot_params_p = (struct boot_params *)__pa_symbol(&boot_params);
> +       ramdisk_image = get_ramdisk_image(boot_params_p);
> +       ramdisk_size  = get_ramdisk_size(boot_params_p);
> +       p = (unsigned char *)ramdisk_image;
> +       acpi_initrd_override_find(p, ramdisk_size, true);
> +#else
> +       ramdisk_image = get_ramdisk_image(&boot_params);
> +       ramdisk_size  = get_ramdisk_size(&boot_params);
> +       if (ramdisk_image)
> +               p = __va(ramdisk_image);
> +       acpi_initrd_override_find(p, ramdisk_size, false);
> +#endif
> +}
> +#endif

What is preventing us from making the 64-bit variant also work in flat
mode to make the code consistent and not hiding the differences under
the rug? What am I missing here?

                        Pekka
