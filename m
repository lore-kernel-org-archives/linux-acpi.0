From: Aaron Bennett <aaron.bennett-jaKf3pluACk@public.gmane.org>
Subject: help getting Fedora Core 2 to suspend...
Date: Thu, 17 Jun 2004 15:14:41 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40D1EDA1.8050207@olin.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I posted this to Fedora-list and someone there suggested I try acpi-devel also...

Hi,

I'm going crazy trying to find a real way to make a Dell Latitude D600
suspend with FC2 and acpi...

When I do echo 1 > /proc/acpi/sleep , X goes away and I get some console
messages like this... ( these are from dmesg because the console
messages go by too fast... )


PM: Preparing system for suspend
Stopping tasks:
==========================================================================|
PCI: Setting latency timer of device 0000:00:1d.7 to 64
Could not suspend device 0000:00:1d.7: error -5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
tg3: eth0: Link is down.
Restarting tasks... done
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.


And then X comes back up as if nothing has happened!  I tried disabling
DRI and even setting the driver to vesa (neither of which option I like)
and it still happens the same way.

FWIW, echo 3 > /proc/acpi/sleep does the same thing, and echo 5 does nothing.

I've found references to a myserious "make x and dri not suck with
radeon" patch, but I can't seem to find it.  I'm hoping to not have to
roll my own kernel because this is for a laptop distribution project --
it's going to find it's way onto ~150 laptops so I'm trying not to have
maintain my own kernel rpms.

Please help before I get more keyprint on my forehead from slamming it
against the keyboard.

asdfsdafkljasdfjkl

ouch.  :-) 

-- 
Aaron Bennett
UNIX Administrator
Franklin W. Olin College of Engineering




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
