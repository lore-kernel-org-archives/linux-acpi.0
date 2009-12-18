From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [git pull request] ACPI and driver patches for 2.6.33.merge
Date: Fri, 18 Dec 2009 06:14:57 +0100
Message-ID: <20091218051457.GB417@elte.hu>
References: <alpine.LFD.2.00.0912161453480.10371@localhost.localdomain>
 <86802c440912171728s27dd7108k85a0f1563660c95b@mail.gmail.com>
 <20091218022112.GA30333@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:40886 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbZLRFPP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Dec 2009 00:15:15 -0500
Content-Disposition: inline
In-Reply-To: <20091218022112.GA30333@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>


* Shaohua Li <shaohua.li@intel.com> wrote:

> On Fri, Dec 18, 2009 at 09:28:50AM +0800, Yinghai Lu wrote:
> > On Wed, Dec 16, 2009 at 12:06 PM, Len Brown <lenb@kernel.org> wrote:
> > > Hi Linus,
> > >
> > > please pull from:
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> > >
> > ;..
> > >
> > > Shaohua Li (3):
> > > ? ? ?ACPI: Add a generic API for _OSC -v2
> > > ? ? ?ACPI: cleanup pci_root _OSC code.
> > > ? ? ?ACPI: Add platform-wide _OSC support.
> > 
> > it seems these three patches broke the _OSC on my intel new systems.
> > 
> > revert them fix the problem with AER and pciehp and etc
>
> can you give more details? I just cleaned up the _OSC code for AER and 
> pciehp, no function changes.

Famous last words ;-)

Yinghai, i suspect Shaohua needs the kind of info you'd need if you tried to 
fix it: acpidump, before/after debug boot log, a description of what goes bad, 
etc.

Thanks,

	Ingo
