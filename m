From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: Re: Weirdness in arch/i386/kernel/acpi_wakeup.S
Date: Wed, 12 Feb 2003 12:50:23 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302121245090.6226-100000@godzilla.axis.se>
References: <20030210170928.GD443@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030210170928.GD443-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 10 Feb 2003, Pavel Machek wrote:
> > (The problem I'm having is that the console VGA is not re-initialized upon 
> > coming back from an S3 suspend and I am trying to debug that)
> 
> Have you tried acpi_sleep=s3_bios and acpi_sleep=s3_mode (not yet in
> 2.5.59, but already in 2.5.59-acpi?)

(tried with 2.5.60 now including the 4096 byte wakeup .org fix, and btw this 
is on an Acer Travelmate 634LC laptop).

Without s3_bios and s3_mode, and without any drivers compiled into the 
kernel, the kernel wakes up after the suspend, and you can execute stuff 
using the keyboard but the VGA never resumes. Close call!

With s3_bios, the display lights up and the cursor starts blinking in the 
upper left corner, but it hangs there (no keyboard input possible). I guess 
the BIOS call succeeded in reinitializing the display but something after 
that hung.

With s3_mode, the display neither lights up nor allows keyboard input :)

Anyway, may I ask what debugging methods are best for tracking down problems 
like this on an i386. I'm used to doing kernel debugging on embedded systems 
but then you have access to logic analysers, LED-lighting etc.. what would 
be an appropriate way to debug such low level code on a PC - I noticed these 
references in acpi_wakeup.S like "movw	$0x0e00 + 'L', %fs:(0x10)" that seem 
to be some kind of debug messages - what do they really do - write to the 
VGA character memory ?

/Bjorn



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
