From: Alexei Gilchrist <alexei-JAjqph6Yjy/o0IyPN7li9Ydd74u8MsAO@public.gmane.org>
Subject: getting BIOS to control screen
Date: Thu, 4 Dec 2003 12:42:30 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031204024230.GC955@physics.uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Under ACPI my laptops screen buttons don't work (ie switching to external screen
and setting the brightness). They DO work under APM though. This is a real pain
as I often need to switch to an external screen and I have to reboot to do this
at the moment.

blundering through the DSDT ASL I came across:


   Method (_DOS, 1, NotSerialized)
    {
       Store (And (Arg0, 0x03), Local0)
       \_SB.PSRV (0xB9, 0x20, 0x01, Local0, 0x00)
    }

If I also set bit1 to 1: And(And (Arg0, 0x03), 0x01)???? can I force it to use 
the BIOS ala APM? or have I lost the plot?

cheers,

Alexei



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
