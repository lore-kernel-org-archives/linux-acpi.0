From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: suspend-to-ram hangs on HP NX7010
Date: Fri, 18 Jun 2004 21:56:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40D348EC.8030903@drzeus.cx>
References: <40C6FD44.7090606@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40C6FD44.7090606-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
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

I've updated to linux 2.6.7 and applied the acpi patch for it. The 
behaviour is now a bit different.
When trying to suspend (echo 3 > /proc/acpi/sleep) I now get the following:

PM: Preparing system for suspend
Stopping tasks: 
===================================================================================================|
PCI: Setting latency timer of device 0000:00:1d.7 to 64
Could not suspend device 0000:00:1d.7: error -5
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Restarting tasks... done

Device 0000:00:1d.7 is the USB 2 controller. If I remove the ECHI module 
the behaviour is as previously (i.e. locks up).
I don't know if this is a new bug in the EHCI module or if this is the 
source of all the problems on this machine. I do not know enough of how 
things work at that level to determine if the USB controller could 
prevent the standby.
The BIOS doesn't have an option to turn of USB so I can't try it with 
the hardware disabled.
Any ideas?

Rgds Pierre




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
