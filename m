From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] ACPI/hpet: prevent boot hang when hpet=force used on
	ICH-4M
Date: Fri, 24 Apr 2009 08:37:34 +0200
Message-ID: <20090424063734.GA21739@elte.hu>
References: <alpine.LFD.2.00.0904222223200.21119@localhost.localdomain> <alpine.LFD.2.00.0904231917030.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:57652 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704AbZDXGhp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Apr 2009 02:37:45 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904231917030.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> Linux tells ICH4 users that they can (manually) invoke
> "hpet=force" to enable the undocumented ICH-4M HPET.
> The HPET becomes available for both clocksource and clockevents.
> 
> But as of ff69f2bba67bd45514923aaedbf40fe351787c59
> (acpi: fix of pmtimer overflow that make Cx states time incorrect)
> the HPET may be used via clocksource for idle accounting, and
> hpet=force on an ICH4 box hangs boot.
> 
> It turns out that touching the MMIO HPET withing
> the ARB_DIS part of C3 will hang the hardware.
> 
> The fix is to simply move the timer access outside
> the ARB_DIS region.  This is a no-op on modern hardware
> because ARB_DIS is no longer used.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13087

Nice fix! This moots the other half-quirk patch you wrote for hpet, 
right?

	Ingo
