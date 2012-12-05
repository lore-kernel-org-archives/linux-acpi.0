From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Look Ma, da kernel is b0rken
Date: Wed, 5 Dec 2012 21:41:14 +0000
Message-ID: <20121205214114.0bb545f1@pyramind.ukuu.org.uk>
References: <20121205070901.GA12123@rhlx01.hs-esslingen.de>
	<20121205142935.GA12119@liondog.tnic>
	<20121205152756.5afec12c@pyramind.ukuu.org.uk>
	<20121205153121.GA28556@liondog.tnic>
	<20121205154749.2af4ef36@pyramind.ukuu.org.uk>
	<20121206075721.18c0c05aa767b330f47d77eb@canb.auug.org.au>
	<20121205211244.GA6239@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121205211244.GA6239@liondog.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 5 Dec 2012 22:12:45 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Dec 06, 2012 at 07:57:21AM +1100, Stephen Rothwell wrote:
> > On Wed, 5 Dec 2012 15:47:49 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > And yes btw we should turn this option on in -next, and get these sort of
> > > things out of the tree for good. More importantly it'll mean anyone
> > > adding another one gets a whine on the spot.
> > 
> > While I appreciate your confidence, I don't notice quite a few new
> > warnings (because there are so many of them already :-().  Is there some
> > reason to not turn this on in our "normal" builds?  Does it produce many
> > false positives?
> 
> Yes, it produces a huge number of warnings which need weeding out (some
> of them are false positives and some of them are simply unfixable due to
> design decisions in the kernel, etc, etc):
> 
> $ make W=123 drivers/pnp/pnpacpi/core.o 2> w.log

I was just talking about the always true/always false stuff !
