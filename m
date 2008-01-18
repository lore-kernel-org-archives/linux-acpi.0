From: "Balbir Singh" <balbir@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc8-mm1
Date: Fri, 18 Jan 2008 10:36:54 +0530
Message-ID: <661de9470801172106t61c702b8ue9610fe66362965a@mail.gmail.com>
References: <20080117104021.25a8e562.akpm@linux-foundation.org>
	 <924EFEDD5F540B4284297C4DC59F3DEE5E909A@orsmsx423.amr.corp.intel.com>
	 <20080117230403.GA5411@balbir.in.ibm.com>
	 <20080118014223.GB25389@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:52711 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbYARFGz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 00:06:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1502717wah.23
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jan 2008 21:06:54 -0800 (PST)
In-Reply-To: <20080118014223.GB25389@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux ACPI mailing list <linux-acpi@vger.kernel.org>, Intel E/100 mailing list <e1000-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, andreas.herrmann3@amd.com

On Jan 18, 2008 7:12 AM, Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
>
> On Thu, Jan 17, 2008 at 03:04:03PM -0800, Balbir Singh wrote:
> > I think I found the root cause of the problem and a fix for it.
> > The fix works for me.
> >
>
> Thanks Balbir. But the appended fix is more clean and appropriate. Can you
> please check if it works.
> ---
>
> From Balbir Singh:
>
> > With the introduction of reserve_mattr() and free_mattr(), the ioremap*
> > routines
> > started exploiting it. The recent 2.6.24-rc8-mm1 kernel has a peculiar
> > problem
> > where in, certain devices disappear. In my case for example
> >
> > e100: Intel(R) PRO/100 Network Driver, 3. 5.23-k4-NAPI
> > e100: Copyright(c) 1999-2006 Intel Corporation
> > ACPI: PCI Interrupt 0000:04:08.0[A] -> GSI 20 (level, low) -> IRQ 20
> > modprobe:2584 conflicting cache attribute 50000000-50001000
> > uncached<->default
> > e100: 0000:04:08.0: e100_probe: Cannot map device registers, aborting.
> > ACPI: PCI interrupt for device 0000:04:08.0 disabled
> >
> > On further analysis, it was discovered that quirk_e100_interrupt() calls
> > ioremap(), which reserves memory attributes for the e100 card, but
> > iounmap()
> > does not free it.
>
> Fix the iounmap() to call free_matrr() unconditionally.
>
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
>
> Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>

Yes, it looks better. p->flags is always set, so the check was not doing much.
I also tested it and it works for me!

Tested-by: Balbir Singh <balbir@linux.vnet.ibm.com>

Balbir
