From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-rc2 System no longer powers off after
	suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 23:36:44 +0100
Message-ID: <200802202336.45492.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<alpine.LFD.1.00.0802201256040.7833@woody.linux-foundation.org>
	<200802201344.11643.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200802201344.11643.jesse.barnes@intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, 20 of February 2008, Jesse Barnes wrote:
> On Wednesday, February 20, 2008 1:13 pm Linus Torvalds wrote:
> > On Wed, 20 Feb 2008, Jesse Barnes wrote:
> > > The current callback system looks like this (according to Rafael and the
> > > last time I looked):
> > >   ->suspend(PMSG_FREEZE)
> > >   ->resume()
> > >   ->suspend(PMSG_SUSPEND)
> > >   *enter S3 or power off*
> > >   ->resume()
> >
> > Yes, it's very messy.
> >
> > It's messy for a few different reasons:
> >
> >  - the one you hit: a driver actually has a really hard time telling what
> >    PMSG_SUSPEND really means.

In fact the driver can find out in which state to put the device into,
depending on the target ACPI state which is known.

> >  - more importantly, we generally don't want to "suspend/resume" the
> >    hardware at all around a power-off, because we're going to resume with
> >    the state at the time of the PMSG_FREEZE, which means that the hardware
> >    has actually *changed* and been used in between!
> 
> Exactly.
> 
> > So the "->resume" really isn't a resume at all. It's much closer to a
> > "->reset".
> 
> Yeah, in the hibernate case this is definitely true.

Agreed.

> > Of course, the "solution" to this all right now is that we have to reset
> > everything even if it *is* a suspend event, so it basically means that STR
> > ends up using the much weaker model that snapshot-to-disk uses.
> >
> > The fundamental problem being that the two really have nothing
> > what-so-ever to do with each other. They aren't even similar. Never were.
> >
> > > And in the long term we could have:
> > >   ->suspend()
> > >   *enter S3*
> > >   ->resume()
> >
> > Yes, apart from all the complexities (suspend_late/resume_early). So in
> > reality it's more than that, but the suspend/resume things are clearly
> > nesting, and they have the potential to actually keep state around
> > (because we *know* this machine is not going to mess with the devices in
> > between).
> 
> Really, in the simple s3 case we still need early/late stuff?

Yes, we do.  There are devices that need to be suspended with interrupts off.

> > IOW, here we actually can have as an option "assume the device is there
> > when you return".

That is, unless the user pulls out that pendrive while suspended, no?

> > > or:
> > >   ->hibernate()
> > >   *kexec to another kernel to save image*
> > >   *power off*
> > >   ->return_from_hibernate() (or somesuch)
> >
> > Enough people don't trust kexec that I suspect the right thing simply is
> >
> > 	->freeze()		// stop dma, synchronize device state
> > 	*snapshot*
> > 	->unfreeze();		// resume dma
> > 	*save image*
> > 	[ optionally ->poweroff() ]	// do we really care? I'd say no

We do, if there are devices that wake us up from S4 and don't wake us up from
S5, for example.  Plus this f*cking fan in my box that doesn't work after the
resume if we don't do ->poweroff() ...

> > 	*power off*
> > 	->restore()		// reset device to the frozen one
> >
> > which may have four entry-points that can be illogically mapped to the
> > suspend/resume ones like we do now, but they really have nothing to do
> > with suspending/resuming.

Apart from putting devices into the right low power states, that is.

> Well, it seems like we'll have to fix drivers in either case, and isn't a 
> kexec approach fundamentally more sound and simple, design-wise?  Rafael 
> pointed out some problems with properly setting wakeup states, but I think 
> that could be overcome...

Your honor, I would like to register a differing opinion ...
 
> > And notice how while "freeze/restore" kind of pairs like a
> > "suspend/resume", it really shouldn't be expected to realistically restore
> > the same state at all. The "restore" part is generally much better seen as
> > a "reset hardware" than a "resume" thing.

That's absolutely correct.

> > Because we literally cannot trust *anything* about the state since we froze
> > it - we might have booted a different OS in between etc. Very different from
> > suspend/resume. 
> 
> Yeah, definitely.  It has to be much more robust and deal with configuration 
> changes, etc. (within reason).

Agreed.

Thanks,
Rafael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
