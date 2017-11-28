From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] x86: make rsdp address accessible via boot params
Date: Tue, 28 Nov 2017 22:03:15 +0100
Message-ID: <CAJZ5v0iHR+NS_Le3-jO+-bsjWMy40CEuYGSgG_MXjVGoNSB7YA@mail.gmail.com>
References: <20171128094400.25955-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36467 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdK1VDQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Nov 2017 16:03:16 -0500
In-Reply-To: <20171128094400.25955-1-jgross@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xen-devel@lists.xenproject.org, the arch/x86 maintainers <x86@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Nov 28, 2017 at 10:43 AM, Juergen Gross <jgross@suse.com> wrote:
> In the non-EFI boot path the ACPI RSDP table is currently found via
> either EBDA or by searching through low memory for the RSDP magic.
> This requires the RSDP to be located in the first 1MB of physical
> memory. Xen PVH guests, however, get the RSDP address via the start of
> day information block.
>
> In order to support an arbitrary RSDP address this patch series adds
> the physical address of the RSDP to the boot params structure filled
> by the boot loader. A kernel booted directly in PVH mode can save the
> RSDP address in the boot params, while a kernel booted in PVH mode via
> grub can rely on the RSDP address being specified by grub2 (which in
> turn got the address via the start of day information block from Xen).
>
> Juergen Gross (3):
>   x86/boot: add acpi rsdp address to setup_header
>   x86/acpi: take rsdp address for boot params if available
>   x86/xen: supply rsdp address in boot params for pvh guests
>
>  Documentation/x86/boot.txt            | 19 +++++++++++++++++++
>  arch/x86/boot/header.S                |  6 +++++-
>  arch/x86/include/uapi/asm/bootparam.h |  1 +
>  arch/x86/xen/enlighten_pvh.c          |  2 ++
>  drivers/acpi/osl.c                    |  8 ++++++++
>  5 files changed, 35 insertions(+), 1 deletion(-)
>
> --

Is this going to work with all existing setups?

Thanks,
Rafael
