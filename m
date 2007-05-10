From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] ACPI: Keep TSC stable, when lapic_timer_c2_ok is set
Date: Thu, 10 May 2007 22:50:56 +0200
Message-ID: <1178830256.22481.1.camel@localhost.localdomain>
References: <1178555611.3042.13.camel@localhost.localdomain>
	 <200705100409.37753.lenb@kernel.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:38603 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753148AbXEJUsD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2007 16:48:03 -0400
In-Reply-To: <200705100409.37753.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@suse.de>, linux-acpi@vger.kernel.org

> Note, however, that the assumption that the TSC and the LAPIC
> timer breaking under the same conditions will not always
> be true going forward.
> 
> In particular, there will be systems with a fully functional TSC
> and a broken LAPIC timer.  But I guess we'll cross that bridge
> when we come to it...

Sigh, is there any kind of breakage which is not invented yet ?

I guess we need to have a seperate option for the TSC vs. C2 then.

	tglx


