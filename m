From: Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Wed, 8 Oct 2003 22:53:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031008215342.GE1920@fairlite.demon.co.uk>
References: <20030930165926.GH1921@fairlite.demon.co.uk> <20030930173646.GF11391@poupinou.org> <20031003193814.GE205@openzaurus.ucw.cz> <20031006124935.GQ11391@poupinou.org> <20031006130533.GA311@elf.ucw.cz> <20031008102745.GF11391@poupinou.org> <20031008191610.GB1035@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031008191610.GB1035-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 08, 2003 at 09:16:11PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > > > When using ACPI to shutdown the machine to disk or memory, obviously an
> > > > > > > application can read events from /proc/acpi/events to see what to do.
> > > > > > > 
> > > > > > > How does ACPI in the kernel wait for applications to do what they
> > > > > > > need to when receiving an ACPI event, as it seems the kernel shuts down
> > > > > > > everything pretty quickly ?
> > > > > > 
> > > > > > AFAIK, there is no support for suspending userspace drivers (like X).
> > > > > 
> > > > > Actually X get console switch event, so they should
> > > > > give control of VGA to the kernel...
> > > > 
> > > > Exactly, you have to switch to a console.  That's the problem.
> > > 
> > > ???
> > > 
> > > Kernel tells X to switch to console; there's interface to say that,
> > > and we are using it. It should just work.
> > 
> > X know more exactly what it have to do to save current states of
> > the video chipset, or even know when to put the video chipset
> > in suspend mode.  The nv driver (for example) have to reset the
> > whole xvideo stuff just because it do not work anymore after a
> > suspend/resume, but this reset is not necessary for just
> > switching to console.  2D/3D acceleration in general also need
> > more works after a suspend/resume which is not necessary
> > for just switching to console.
> > All of that console switching work only on intel like archs.
> 
> IMO X should do full save and restore, on every console switch. That
> way it is safe to killall -9 X when you are on console, and I think I
> like it that way. I do not think console switching is i386-only, I
> know that sparc64's had consoles, too.
 
Doing a kill -9 on any application doesn't allow the application to
catch the signal. Thus X cannot restore itself, and neither can any
application that gets it. If you kill -9 anything then suffer the 
consequences of it not cleaning up.

> OTOH if X knew how to bring video card up from powerdown... that would
> help a lot, and would need a kernel support. ("Hey, X, I just did
> resume and graphics card is uninitialized. It is not even in vga text
> mode. Do something with it.")

Most drivers in X do know how to bring up the video chip from an
uninitialized state. If the kernel is doing a VT switch internally and
back again on resume then it should just work.

Is that what your saying currently happens in 2.6.0-test6 ??

Or is it only in your swsusp package for that functionality ??

Alan.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
