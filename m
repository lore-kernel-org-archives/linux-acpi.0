From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] x86: Enable monitor/mwait on Intel if BIOS hasn't
 already
Date: Thu, 4 Aug 2011 20:41:17 +0100
Message-ID: <20110804194117.GA5265@srcf.ucam.org>
References: <cover.1312386029.git.luto@mit.edu>
 <5bec80947da3fb72f2f18fbe6d924a69f83fbed9.1312386029.git.luto@mit.edu>
 <alpine.LFD.2.02.1108031214470.22067@x980>
 <CAObL_7GuAmzyjo5AmYxbTeiAqFtVk1N+opzWEzwJu8Mgrvts7g@mail.gmail.com>
 <CAObL_7FNa20Hsd0v-hs1vz=ejnkdaT+Yr=wwM681GbZJiuLkMQ@mail.gmail.com>
 <alpine.LFD.2.02.1108031514550.22067@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47337 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab1HDTlZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Aug 2011 15:41:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1108031514550.22067@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Lutomirski <luto@mit.edu>, x86@kernel.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, linux-acpi@vger.kernel.org

On Wed, Aug 03, 2011 at 03:17:59PM -0400, Len Brown wrote:
> > >> What machine has this BIOS bug, and are you running
> > >> the latest version of the BIOS?
> > >
> > > Intel DQ67SW, version SWQ6710H.86A.0051.2011.0413.1154. =A0This i=
s not
> > > quite up-to-date -- I'll test a newer BIOS.
> >=20
> > SWQ6710H.86A.0053.2011.0615.1535 has the same problem.  It fixed AS=
PM, though :)
> >=20
> > Should I redo the patch with a printk to warn about the firmware bu=
g?
>=20
> I would hope that a patch that _only_ prints [Firmware bug]
> should be enough.  This isn't the kind of workaround
> that we should really have to carry in the kernel.

We can't trust BIOS authors to get things right. Where we can reliably=20
fix up things that are broken, we should do so.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
