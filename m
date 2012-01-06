From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] PNP: work around Dell 1536/1546 BIOS MMCONFIG bug
 that breaks USB
Date: Fri, 6 Jan 2012 09:49:01 +0100
Message-ID: <20120106084901.GD14188@elte.hu>
References: <20120105212719.3965.40406.stgit@bhelgaas.mtv.corp.google.com>
 <20120105212724.3965.30193.stgit@bhelgaas.mtv.corp.google.com>
 <CAErSpo6=yHFspY_L0rQa6iVD692nYyL=BR=3qBwc3UV8M16xbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:34076 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133Ab2AFIvH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Jan 2012 03:51:07 -0500
Content-Disposition: inline
In-Reply-To: <CAErSpo6=yHFspY_L0rQa6iVD692nYyL=BR=3qBwc3UV8M16xbw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, thuban@singularity.fr, dann frazier <dann.frazier@canonical.com>, Lisa Salimbas <lisa.salimbas@canonical.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>


* Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Thu, Jan 5, 2012 at 2:27 PM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
> > Some Dell BIOSes have MCFG tables that don't report the entire
> > MMCONFIG area claimed by the chipset. =A0If we move PCI devices int=
o
> > that claimed-but-unreported area, they don't work.
> >
> > This quirk reads the AMD MMCONFIG MSRs and adds PNP0C01 resources a=
s
> > needed to cover the entire area.
>=20
> PNP stuff usually goes through Len's ACPI tree, but this is=20
> really x86-specific, and these two patches need to go=20
> together, so I think it would make sense to put them both in=20
> the x86 tree.  Len, do you object?

I'd really suggest the PCI tree for this - mmconfig is really=20
PCI related.

Thanks,

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
