From: Malte Doersam <malte.d-hi6Y0CQ0nG0@public.gmane.org>
Subject: How to debug not working S3?
Date: Fri, 18 Jul 2003 00:42:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307180042.35263.malte.d@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
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

Hi everybody,

I'm curious how you get some usefull information on which point the resume 
might fail.  I'm just trying 2.6-test0 with ACPI revision 20030714 and S1 
works quite fine, but S3 is nasty.

Computer: Thinkpad R31 i810 laptop

if I echo 3 to /proc/acpi/sleep all the processes are moved to the 
refrigerator and the laptop turns itself off. Invoking any acpi-event makes 
the Thinkpad waking up, I hear the harddrive spinning up for like a second 
and then turning off again. After this, the system is kinda dead and must be 
turned off the hard way. (pressing the power button for 4 seconds).

I'd like to gather some information on the problem, which prevents resuming. 
Any hint/note on how to do this?

cheers Malte

P.S. there is a bug on bugzilla filed in the category 'input devices' but is 
probably acpi related: http://bugzilla.kernel.org/show_bug.cgi?id=804



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
