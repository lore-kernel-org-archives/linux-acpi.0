From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC PATCH] x86: create drivers/x86/ from drivers/misc/
Date: Fri, 28 Nov 2008 22:16:47 -0200
Message-ID: <20081129001647.GA8699@khazad-dum.debian.net>
References: <20081128213620.2ec593d4.sfr@canb.auug.org.au> <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au> <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain> <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain> <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain> <20081128223533.GA5175@uranus.ravnborg.org> <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 28 Nov 2008, Len Brown wrote:
> > > Move x86 platform specific drivers from drivers/misc/
> > > to a new home under drivers/x86/.
[...]
> > We already have 81 one directory entries under drivers/
> > and with patch you open up for an additional
> > directory for each arch - not elegant.
> 
> I followed the example of drivers/s390/,
> per Linus' suggestion.
> 
> The other place that seemed to suggest itself was
> arch/x86/drivers/, as we already have:
> 
> arch/um/drivers/
> arch/sh/drivers/
> arch/cris/*/drivers/

IMHO, from a purely "tree organization" point of view, it would be best if
arch-specific platform drivers were under drivers/platform/<arch>/.  And
arch/ be left for the core arch-specific stuff.

Whether that would work well, when arch maintenance factors are taken into
account, I don't know.

> > As it is today (before this patch) the directories unider
> > drivers/ said what the drivers was used for - which is logical.
> > 
> > But with this new arch specific directory it is no longer obvious
> > is a driver should be located under say drivers/net/* or
> > drivers/arm/* in case it is a arm specific driver.

drivers/platform/<arch> would help in that regard, I think.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
