From: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Subject: Computer Resets on Resume From S3
Date: Thu, 20 Nov 2003 15:22:15 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200311201522.15255.jak97@doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello

I have a KT4 Ultra (MS-6590) computer, with latest BIOS. 
I am running kernel 2.6.0-test9-bk21.
When I enter S3, by "echo 3 > /proc/acpi/sleep", the machine suspends all the 
tasks and then appears to power-down (all the hard disks are powered down, 
and the power-supply fan is off).

I know that the machine is not truly off, because I can trigger a resume by 
pressing a key on the keyboard. Also /proc/acpi/alarm works fine.

The trouble is that resume from S3 immediately resets the computer, so it as 
if I had just turned the computer on, rather than resuming the previous 
session.

Can anybody suggest some debugging that I can try to narrow this problem down? 
Perhaps by inserting a forced oops() somewhere so that I can see where it 
gets to before rebooting?

What happens on S3 resume? Is this fault occuring in the DSDT? Is it occuring 
in the kernel? What would the relevant kernel procedures to examine be?

Any help much appreciated

John



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
