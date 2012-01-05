From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PNP: work around Dell 1536/1546 BIOS MMCONFIG bug
 that breaks USB
Date: Thu, 5 Jan 2012 14:30:13 -0700
Message-ID: <CAErSpo6=yHFspY_L0rQa6iVD692nYyL=BR=3qBwc3UV8M16xbw@mail.gmail.com>
References: <20120105212719.3965.40406.stgit@bhelgaas.mtv.corp.google.com> <20120105212724.3965.30193.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64400 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758302Ab2AEVaf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Jan 2012 16:30:35 -0500
Received: by lahd3 with SMTP id d3so312584lah.19
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jan 2012 13:30:34 -0800 (PST)
In-Reply-To: <20120105212724.3965.30193.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: thuban@singularity.fr, dann frazier <dann.frazier@canonical.com>, Lisa Salimbas <lisa.salimbas@canonical.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, Jan 5, 2012 at 2:27 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> Some Dell BIOSes have MCFG tables that don't report the entire
> MMCONFIG area claimed by the chipset. =A0If we move PCI devices into
> that claimed-but-unreported area, they don't work.
>
> This quirk reads the AMD MMCONFIG MSRs and adds PNP0C01 resources as
> needed to cover the entire area.

PNP stuff usually goes through Len's ACPI tree, but this is really
x86-specific, and these two patches need to go together, so I think it
would make sense to put them both in the x86 tree.  Len, do you
object?

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
