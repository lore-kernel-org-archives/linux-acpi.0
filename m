From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in
	hardware
Date: Fri, 4 Jul 2008 08:55:19 -0300
Message-ID: <20080704115519.GA7435@khazad-dum.debian.net>
References: <200807031805.52883.trenn@suse.de> <20080703160822.GA29110@srcf.ucam.org> <20080704030948.GB31908@khazad-dum.debian.net> <20080704091307.GB8905@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080704091307.GB8905@srcf.ucam.org>
Sender: linux-next-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 04 Jul 2008, Matthew Garrett wrote:
> On Fri, Jul 04, 2008 at 12:09:49AM -0300, Henrique de Moraes Holschuh wrote:
> > On Thu, 03 Jul 2008, Matthew Garrett wrote:
> > > Not until the opregion code is merged, no. If you'd like that to happen 
> > > faster, then figuring out why it triggers a 750ms delay on brightness 
> > > changes on the T61 would be a great help, because I haven't a clue why 
> > > it's broken...
> > 
> > I have never really tried finding out WTF in the firmware causes this, but:
> > 
> > 1. The backlight-change firmware runs in SMM.
> > 2. The calls happen in ACPI DSDT
> > 3. The SMM code DOES take care of the CMOS NVRAM
> 
> As far as I can tell, it's sleeping in the DSDT. But all the ready flags 

Which probably means the SMI trap was botched :(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
