From: Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Thu, 9 Oct 2003 15:06:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031009140648.GH1922@fairlite.demon.co.uk>
References: <20030930165926.GH1921@fairlite.demon.co.uk> <20030930173646.GF11391@poupinou.org> <20031003193814.GE205@openzaurus.ucw.cz> <20031006124935.GQ11391@poupinou.org> <20031006130533.GA311@elf.ucw.cz> <20031008102745.GF11391@poupinou.org> <20031008191610.GB1035@elf.ucw.cz> <20031008215342.GE1920@fairlite.demon.co.uk> <20031008215850.GF1238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031008215850.GF1238-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 08, 2003 at 11:58:50PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > IMO X should do full save and restore, on every console switch. That
> > > way it is safe to killall -9 X when you are on console, and I think I
> > > like it that way. I do not think console switching is i386-only, I
> > > know that sparc64's had consoles, too.
> >  
> > Doing a kill -9 on any application doesn't allow the application to
> > catch the signal. Thus X cannot restore itself, and neither can any
> > application that gets it. If you kill -9 anything then suffer the 
> > consequences of it not cleaning up.
> 
> I should be able to kill -9 any task and keep my system running (I'm
> not complaining about stale lock files etc). Unfortunately that is not
> true with X. It would be nice if at kill -9 would be safe at least
> when kernel has control of display.
 
You said 'X should do full save and restore, on every console switch'.
The fact is that X can only do a full save/restore (and it does!) on
the VT that it owns. If you really want to do a kill -9, then the
kernel has no choice but to clean up and restore itself which is impossible
as it knows nothing about some of the intricasies of the some of the graphics
engines out there.

> > > OTOH if X knew how to bring video card up from powerdown... that would
> > > help a lot, and would need a kernel support. ("Hey, X, I just did
> > > resume and graphics card is uninitialized. It is not even in vga text
> > > mode. Do something with it.")
> > 
> > Most drivers in X do know how to bring up the video chip from an
> > uninitialized state. If the kernel is doing a VT switch internally and
> > back again on resume then it should just work.
> 
> Kernel is doing VT switch in -test6. But I do not really think X can
> bring up the video chip... are you really able to program video card
> memory timings and similar stuff? On what cards?

X can bring it up. X uses the int10 library to softboot a video board.
XFree86 even has an x86 emulator so it can do this on non-X86 platforms.

I guess I'll just have to try -test6 to see if it does VT switch when
hitting the power button to suspend.... 

Alan.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
