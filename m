From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/5] x86: acpi: Print warning for malformed host bridge resources
Date: Sat, 10 Nov 2012 14:52:08 -0700
Message-ID: <CAErSpo6DV+HKHX=5mSUzGmbJVbZdDpco7Ct-FeJJcVjCO992bg@mail.gmail.com>
References: <1352343356-4006-1-git-send-email-peter@hurleysoftware.com> <1352343356-4006-5-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46022 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab2KJVw3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Nov 2012 16:52:29 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3335394wgb.1
        for <linux-acpi@vger.kernel.org>; Sat, 10 Nov 2012 13:52:28 -0800 (PST)
In-Reply-To: <1352343356-4006-5-git-send-email-peter@hurleysoftware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Wed, Nov 7, 2012 at 7:55 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> An incorrectly specified host bridge window may prevent
> other devices from claiming assigned resources. For example,
> this flawed _CRS resource descriptor from a Dell T5400:
>      DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
>          0x00000000,         // Granularity
>          0xF0000000,         // Range Minimum
>          0xFE000000,         // Range Maximum
>          0x00000000,         // Translation Offset
>          0x0E000000,         // Length
>          ,, , AddressRangeMemory, TypeStatic)

I think the problem here is that the Range Maximum should be
0xFDFFFFFF, not 0xFE000000, right?

> prevents the adjacent device from claiming [mem 0xfe0000000-0xfe01ffff]
>
> Sanity check that the resource at least conforms to a valid
> PCI BAR; if not, emit a diagnostic warning.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  arch/x86/pci/acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 192397c..3468d16 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -298,6 +298,10 @@ setup_resource(struct acpi_resource *acpi_res, void *data)
>                         "host bridge window [%#llx-%#llx] "
>                         "([%#llx-%#llx] ignored, not CPU addressable)\n",
>                         start, orig_end, end + 1, orig_end);
> +       } else if (flags & IORESOURCE_MEM && (start & 0x0f || ~end & 0x0f)) {
> +               dev_warn(&info->bridge->dev,
> +                        "invalid host bridge window [%#llx-%#llx]\n",
> +                        start, end);

We didn't actually *fix* anything here, so I guess we're just pointing
out the reason for a subsequent failure to claim the adjacent
resource.

As far as I know, the spec doesn't actually require resources of ACPI
devices to be non-overlapping.  Windows accepts overlapping resources,
and I think Linux probably should, too, but right now we trip over
this.

In the meantime (until we figure out how to handle overlapping
resources better), can we do something to actually fix this?  Maybe we
should truncate the end of the range to 0xFDFFFFFF like we do for
non-addressable parts of the range?

Is there a bugzilla or a complete dmesg log to look at?

Bjorn

>         }
>
>         res = &info->res[info->res_num];
> --
> 1.7.12.3
>
