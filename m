From: Dareus <linuxmail-P1JKnMZDrucAvxtiuMwx3w@public.gmane.org>
Subject: Need some pointers on newbish info
Date: 27 Aug 2002 18:12:55 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1030486375.16969.28.camel@neutron>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello All,

First some system info

I've been playing around with the ACPI support (with patch) in the
2.4.19 kernel (latest ACPI patch, rh 7.3 system, vanilla kernel) on one
on my desktop system which is an award bios with a Athlon 1.4 processor

Kernel is built with all ACPI options except battery, AC and CPU only
but I'm only seeing processor and button directory trees in my
/proc/acpi

I was kind of hoping to see a thermal directory but it isn't there.

I tried playing around to see what I could do to see if it was a buggy
bios but I ran out of documentation to follow after getting the acpidmp
but the decoders I tried either returned no info or seg faulted.

Any suggestions on what I can do to get useful information out of the
acpidmp or other ACPI info or a website with more up to date
troubleshooting information?


Second question, on this kernel I tried switching the speed down to 50%
using the throttling but the machine acted very jumpy after that.  Is
that a known issue due to changing the timing of the CPU while the
kernel is already running?  Remember, this should still be 700Mhz which
should be just fine for running a few x apps I assume.

Thanks in advance,
Dareus




-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
