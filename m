From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH] x86: create drivers/x86/ from drivers/misc/
Date: Sun, 30 Nov 2008 23:35:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811302329440.3314@localhost.localdomain>
References: <20081128213620.2ec593d4.sfr@canb.auug.org.au>
 <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au>
 <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain>
 <20081128223533.GA5175@uranus.ravnborg.org>
 <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
 <20081129001647.GA8699@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <20081129001647.GA8699@khazad-dum.debian.net>
Sender: linux-next-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On Fri, 28 Nov 2008, Henrique de Moraes Holschuh wrote:

> On Fri, 28 Nov 2008, Len Brown wrote:
> > > > Move x86 platform specific drivers from drivers/misc/
> > > > to a new home under drivers/x86/.
> [...]
> > > We already have 81 one directory entries under drivers/
> > > and with patch you open up for an additional
> > > directory for each arch - not elegant.
> > 
> > I followed the example of drivers/s390/,
> > per Linus' suggestion.
> > 
> > The other place that seemed to suggest itself was
> > arch/x86/drivers/, as we already have:
> > 
> > arch/um/drivers/
> > arch/sh/drivers/
> > arch/cris/*/drivers/
> 
> IMHO, from a purely "tree organization" point of view, it would be best if
> arch-specific platform drivers were under drivers/platform/<arch>/.  And
> arch/ be left for the core arch-specific stuff.
> 
> Whether that would work well, when arch maintenance factors are taken into
> account, I don't know.

Each of the drivers has a primary maintainer --
though some of them jare  more active than others...
And I'll continue to be available to help them where I can.

> > > As it is today (before this patch) the directories unider
> > > drivers/ said what the drivers was used for - which is logical.
> > > 
> > > But with this new arch specific directory it is no longer obvious
> > > is a driver should be located under say drivers/net/* or
> > > drivers/arm/* in case it is a arm specific driver.
> 
> drivers/platform/<arch> would help in that regard, I think.

I agree.
drivers/platform/x86/ seems to be a better home than drivers/x86/
for this bunch.  I'll update the patch to do this.
The other arch's can follow later if they choose.

thanks,
-Len
