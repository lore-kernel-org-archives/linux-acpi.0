From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: PME# for add-on cards
Date: Tue, 25 Aug 2009 20:42:03 -0300
Message-ID: <20090825234203.GB14047@khazad-dum.debian.net>
References: <200908240112.39424.rjw@sisk.pl>
 <20090824094429.GB1134@srcf.ucam.org>
 <200908242039.07607.rjw@sisk.pl>
 <20090824121239.51ac35ce@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090824121239.51ac35ce@jbarnes-g45>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 24 Aug 2009, Jesse Barnes wrote:
> On Mon, 24 Aug 2009 20:39:07 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > On Monday 24 August 2009, Matthew Garrett wrote:
> > > On Mon, Aug 24, 2009 at 01:12:39AM +0200, Rafael J. Wysocki wrote:
> > > > After some debugging it turned out that PCI0 is the PCI host
> > > > bridge (no-bus:pci0000:00), so apparently echoing PCI0
> > > > to /proc/acpi/wakeup causes a wake-up GPE to be set up for the
> > > > host bridge which triggers wake-up once eth0 signals PME#.
> > > 
> > > Mm. That sounds entirely plausible. If it were a built-in card then
> > > the DSDT would provide that GPE, but as an add-in...
> > > 
> > > > First, I wonder if that's the case in general (anybody knows?).
> > > > Second, if that is the case, would it be a good idea to set up
> > > > the host bridge wake-up GPE by default?
> > > 
> > > I'd expect this to be the case in general, yes. Systems that work 
> > > without this probably have the BIOS enable it themselves on
> > > suspend. I suspect we'll have to set it to make sure.
> > 
> > OK, Matthew, Alan, thanks for your opinions.
> > 
> > I'll try to implement this, then.
> 
> I think that's the best approach.  The only risk that I can see
> immediately is that we'll expose ourselves to add-in cards with flakey
> PME# signals.  We can worry about that when/if we see it though.

I have seen it, an old atheros-based wifi card packaged by 3COM.  My Intel
D875PBZ motherboard could not turn off (it would turn back on due to #PME)
with that crap installed.  Probably the BIOS didn't defend itself enough
against PME on power _off_.  I didn't even need to have ANY driver at all
for that card for it to be a hassle.

I have sinced given that card away to someone who runs it under Windows in a
different motherboard (that probably masks #PME on shutdown :p).

May I humbly suggest a command-line switch to let the user disable the new
behaviour (or even selectively disable/enable it per host bridge) since day
one?  The default can be enabled, let's priorize good hardware and firmware
over buggy crap!  but let's make it easy to work around any issues it could
cause right from the beginning, because they _will_ happen.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
