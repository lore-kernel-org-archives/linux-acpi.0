From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Fri, 28 Nov 2003 11:10:44 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069978244.671.219.camel@gaston>
References: <20031120111315.GB432@openzaurus.ucw.cz>
	 <1069370504.705.32.camel@gaston> <20031120234708.GA431@elf.ucw.cz>
	 <20031121155010.C19564@loria2.loria.fr> <1069637387.723.112.camel@gaston>
	 <20031124173603.GA298@elf.ucw.cz> <1069725771.876.296.camel@gaston>
	 <20031125120443.GA297@elf.ucw.cz> <20031126132419.GL7374@poupinou.org>
	 <20031126223436.GD207@elf.ucw.cz>  <20031127104722.GM7374@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031127104722.GM7374-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Emmanuel Thome <Emmanuel.Thome+acpi-/zGXu1G9BXs@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2003-11-27 at 21:47, Ducrot Bruno wrote:
> On Wed, Nov 26, 2003 at 11:34:36PM +0100, Pavel Machek wrote:
> > That's what I'm doing, but it crashes machine on most
> > machines. Perhaps PCI needs to be already initialized at this point or
> > something like that?
> 
> In fact, I don't think that POST is a good idea anyway (we had
> alerady that discussion).  It's way too early in the resume path.
> Perhaps POSTing after PCI subsystem wakeup may help, but then you
> may have to go with int 10 instead (and that will be pretty hard
> to do that in kernel space).

Well... we have to POST the card one way or another. So unless ATI
provides us with the complete POST code for all of their chipset
revisions, which may never happen, we are stuck with using the BIOS
POST facility.

However, I think Pavel is right here, we should probably restore
the PCI bus (and AGP !) completely before attempting that. Which
means we'll probably have to add a facility to x86 to go back to
real mode run that dawn int10 thing.

Something else we need on x86 (I need that at least in radeonfb),
provided that doesn't exist already, is a small hook in the PCI
code at probe time that "detects" which VGA PCI chbip had IO
decoding enabled, that is which one is the primary one.

I need that in order to properly retreive some tables, as on a
bunch of laptops, the video BIOS ROM isn't accessible on the PCI
ROM BAR of the card. So I need to check when dealing with the
primary card and peek at the BIOS image at c0000 instead of the
PCI ROM.

ben.
 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
