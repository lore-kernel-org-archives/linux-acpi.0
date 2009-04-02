From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] x86 setup BIOS workarounds
Date: Thu, 2 Apr 2009 12:31:15 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904021227060.4130@localhost.localdomain>
References: <200904011640.n31GeD0m008691@voreg.hos.anvin.org> <alpine.LFD.2.00.0904011115210.4130@localhost.localdomain> <alpine.LFD.2.00.0904020017480.4657@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48608 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759666AbZDBTj3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Apr 2009 15:39:29 -0400
In-Reply-To: <alpine.LFD.2.00.0904020017480.4657@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Michael K. Johnson" <johnsonm@rpath.com>, Justin Forbes <jmforbes@linuxtx.org>, Jordan Hargrave <Jordan_Hargrave@dell.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org



On Thu, 2 Apr 2009, Len Brown wrote:
> 
> Yes, this expects old BIOS to always return 20.

Do you have any reason to expect that all BIOS'es are bug-free in this 
area? 

That would be a first.

We already check for other error cases where the BIOS didn't do the right 
thing in other ways in its e820 routine, or clobbered the wrogn registers 
or whatever. Why would you expect that the return value would always be 
ok?

> No, it does not expect old BIOS to have any particular value
> in buf.ext_flags -- since that is examined only for size > 20.

The point is, that expectation that the BIOS returns 20 seems very 
unreasonable. BIOS writers tend to have been on pain medication for so 
long that they can hardly remember their own name, much less actually make 
sure they follow all the documentation.

Now, if Windows has actually _depended_ on the right return value since 
Win95, that would be a good, strong argument.

Because that's the only case where we can pretty much depend on BIOS 
writers get things right - if Windows doesn't boot when they get it wrong. 
As far as I can tell, that has always been the only real quality assurance 
for most BIOS'es.

			Linus
