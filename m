From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Wed, 20 Feb 2008 10:37:04 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802201007300.7833@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
	<b6a2187b0802200954p1cccb01aqbc48c865797f0af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b6a2187b0802200954p1cccb01aqbc48c865797f0af1@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org



On Thu, 21 Feb 2008, Jeff Chua wrote:
> 
> > That said, before you do anything else, try if suspend-to-RAM works.
> 
> Linus, guess I missed this part ... so before touch anything, I did
> tried suspend-to-ram, and it works on console and in X.

Ok, so this is with clean current -git, and nothing disabled?

> And suspend-to-disk hangs, but I can still press and hold the power
> button to power it off.

The "press and hold for five seconds" is actually a hardware feature of 
the southbridge (well, I guess there is "software" in there too, but it's 
the embedded kind). So the fact that it powers off at that point means 
nothing, it just means that ok, your kernel is hung, but the hardware
still works ;)

This *sounds* like some part of the suspend-to-disk sequence is doing 
something stupid like trying to access the screen after it has been turned 
off, which doesn't surprise me at all. My oft-stated opinion has been that 
suspend-to-disk isn't a suspend at all, and should never have been 
confused with "suspending" anything.

It's "snapshot-and-restore", and my opinion is that:

 - it should *never* call "suspend()"/"resume()" at all (that should be
   reserved purely for suspend-to-RAM and has real power management 
   issues!)

 - it should have a totally separate "halt/unhalt/restore" thing 
   that has nothing what-so-ever to do with power management, and is 
   purely about stopping the hardware for things like USB and network 
   cards (which otherwise do things like scan their command lists 
   asynchronously) and making sure that the driver state is consistent 
   with that stopped hw state.

 - the people who confuse snapshot/restore with suspend/resume are 
   horrible people that cause problems exactly because driver people then 
   get those things mixed up, and something like the video suspend/resume 
   should probably never have impacted suspend-to-disk in the first place!

HOWEVER, that's a separate fight I've had, and in the meantime:

> Then upon powering on and resume, I get the ugly green "console" screen. 
> I can still type and move around. Starting X runs fine. Ctrl-Alt-Del or 
> switching back to console will get back to the green screen.

.. so this implies that while the laptop apparently hung at the end of the 
snapshotting, the snapshotting did actually work, and it must have hung at 
the very end, presumably when it tried to actually turn the power off.

So there seems to be two (probably largely independent) problems:

 - the hang at shutdown that requires you to press-and-hold the power 
   button to actually cut power.

   At a guess: putting the VGA device into D3hot makes the ACPI code that 
   actually does the shutoff unhappy. Probably because it wants to access 
   the device, and ends up not ever getting the replies it wants, since 
   the hardware has been turned off.

 - the fact that we restore something wrong for you and the screen is 
   green.

   At a guess: the restore_vga ends up restoring some state that wasn't 
   correctly and fully saved.

IOW, I think your patch that disables the two lines actually ends up 
pretty much matching the two *different* problems. Can you confirm that 
doing those two parts of that patch individually actually does 
individually fix the two issues? (Ie disabling D3hot makes it shut down 
nicely but resume with green text, while disabling just restore_vga() ends 
up with shutdown problems, but once you press-and-hold the power button, 
the thing will then restore nicely)+

		Linus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
