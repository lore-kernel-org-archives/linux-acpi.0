From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Tue, 25 Nov 2003 13:02:51 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069725771.876.296.camel@gaston>
References: <20031119180119.GB22307@tate.loria.fr>
	 <20031120111315.GB432@openzaurus.ucw.cz> <1069370504.705.32.camel@gaston>
	 <20031120234708.GA431@elf.ucw.cz> <20031121155010.C19564@loria2.loria.fr>
	 <1069637387.723.112.camel@gaston>  <20031124173603.GA298@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031124173603.GA298-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Emmanuel Thome <Emmanuel.Thome+acpi-/zGXu1G9BXs@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-11-25 at 04:36, Pavel Machek wrote:
> Hi!
> 
> > In the meantime, if we can (not sure about it) call back into the BIOS
> > when waking up (Andi seemed to imply we are in real mode when getting
> > out of sleep), we may just use int10 to hard re-POST video cards at this
> > point. We must also make sure we do that for the AGP bridge if
> > possible.
> 
> Look at arch/i386/kernel/acpi/wakeup.S code. It attempts to do
> real-mode reinitialization (if you pass right acpi_sleep= paramater),
> but it only works for some people.
> 
> If it is possible to improve that real-mode code to work more people,
> feel free to send patches.
> 
> [I now have another machine -- arima notebook -- where none of current
> methods works. I'll need to look at it closely.]

Well, I did a quick look only, I'm a bit dumb with x86 assembly, but
it looks you are only trying to call VESA for setting a mode, not
doing a full POST of the card

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
