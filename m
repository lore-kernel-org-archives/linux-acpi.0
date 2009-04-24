From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86/hpet: prevent boot hang when hpet=force used on
	old ICH
Date: Sat, 25 Apr 2009 01:45:02 +0200
Message-ID: <20090424234502.GF6403@elte.hu>
References: <alpine.LFD.2.00.0904222223200.21119@localhost.localdomain> <20090423060936.GA1917@elte.hu> <alpine.LFD.2.00.0904231901570.15843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46085 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbZDXXpU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Apr 2009 19:45:20 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904231901570.15843@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* Len Brown <lenb@kernel.org> wrote:

> Ingo,
> Thanks for the reply.
> 
> But please disregard that patch -- we've cooked up a better one
> that allows ICH4M to continue to use hpet=force, even for clocksource.
> (and it is an ACPI patch rather than an x86 patch:-)

ok.

> However, I'll also send a 2nd patch to stop soliciting more 
> hpet=force users, since technically we shouldn't be encouraging 
> the use of this un-documented and lightly-validated hardware.

agreed - i've applied this patch.

	Ingo
