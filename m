From: Ingo Molnar <mingo@elte.hu>
Subject: Re: mpparse_{32,64}.c merge questions
Date: Wed, 12 Mar 2008 08:04:19 +0100
Message-ID: <20080312070419.GA18216@elte.hu>
References: <47CDB9D7.9030107@suse.de> <47CDBFD9.1050703@suse.de> <20080304213552.GD8944@elte.hu> <200803111328.43314.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:57545 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbYCLHEd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 03:04:33 -0400
Content-Disposition: inline
In-Reply-To: <200803111328.43314.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Andi Kleen <ak@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>


* Len Brown <lenb@kernel.org> wrote:

> > we dont, but please do _not_ "redesign" anything during unification.
> > 
> > try to keep it simple and bisectable. Lots of small patches. Stupid
> > #ifdefs if need to be. Pick the 32-bit version or the 64-bit version 
> > of any approach, if it's obvious that the unified version will still 
> > work fine. Ask if in doubt.
> 
> I agree with Ingo on the "keep it simple" merge steps..
> 
> I can't resist mentioning, however, what I'd like to see long term.
> 
> I'd like to see mpparse.o depend on CONFIG_MPS=y
> I'd like to be able to build CONFIG_ACPI=y and CONFIG_MPS=n
> 
> Andy Grover prototyped splititing MPS from ACPI a while back, but it 
> never made it upstream.

sure and agreed. And this absolutely has to happen in a separate 
patchset. Unification is done best by not changing much and by delaying 
any difficult change to as late in the unification effort as possible. 
(thus any non-trivial change, if it breaks things and has to be 
reverted, wont pull another 100 "easy" changes with itself)

	Ingo
