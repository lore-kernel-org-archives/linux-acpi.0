From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: send_IPI_mask_bitmask() (Re: 2.6.21 known regressions (v2)
	(for -stable team))
Date: Sun, 29 Apr 2007 10:25:22 +0200
Message-ID: <1177835122.5791.4.camel@localhost.localdomain>
References: <463375E5.5040108@googlemail.com>
	 <1177779533.7646.264.camel@localhost.localdomain>
	 <200704290134.39048.lenb@kernel.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:36217 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933045AbXD2IXO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 04:23:14 -0400
In-Reply-To: <200704290134.39048.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: venkatesh.pallipadi@intel.com, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, stable@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Jeff Chua <jeff.chua.linux@gmail.com>

On Sun, 2007-04-29 at 01:34 -0400, Len Brown wrote:
> > clockevents_notify() is called with the power verify information for an
> > offline CPU. I can handle this in the clockevents code, but I think acpi
> > is the correct place.
> 
> So the CONFIG_GENERIC_CLOCKEVENTS=y case is broken,
> but the CONFIG_GENERIC_CLOCKEVENTS=n below is okay?
> Not immediately clear why both cases can't fail.

True, that's strange. Even more strange is that 2.6.21-rc7 does not have
the problem, but 2.6.21 has. We did not change anything in those code
pathes between rc7 and final.

Jeff, can you please verify which -rcX was the last which did not have
this problem.

Thanks,

	tglx


