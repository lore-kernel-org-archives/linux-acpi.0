From: Len Brown <lenb@kernel.org>
Subject: Re: on builds/randconfigs
Date: Wed, 12 Jan 2011 16:52:39 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101121646240.19754@x980>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au>
 <20101213112033.d0060e6c.randy.dunlap@oracle.com>
 <20110110090059.6f4d739d.randy.dunlap@oracle.com>
 <alpine.LFD.2.02.1101120008590.19140@x980> <4D2DE97C.2000205@oracle.com>
 <alpine.LFD.2.02.1101121257580.18873@x980> <4D2DF526.7090308@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <4D2DF526.7090308@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, akpm <akpm@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>
List-Id: linux-acpi@vger.kernel.org

> >> Who defines useful?

> > Configs that will be used are useful.

> Then I suggest that you start deleting non-useful kernel configs.
> You can begin in ACPI.

Maybe I wasn't clear in my previous note...

Originally, ACPI did not depend on PCI, PNP, or PM.
Now it does.  That is an 8x reduction in phantom configs.

I'm all ears for ideas on further simplification.

-Len
