From: Santiago Garcia Mantinan <manty-gaW6/AuhO2xeoWH0uzbU5w@public.gmane.org>
Subject: acpi breaking synaptics mouse support on Acer Travelmate 260
Date: Wed, 13 Aug 2003 00:17:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030812221751.GA2432@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I recently (the 11th) posted on lkml a message with subject "2.6.0test3
problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)" on which I
commented all the major problems I was seing on this machine.

I have not received any replies there about the ACPI problem, so I have done
further testing and I'm posting here hoping this is a better place to give
this info, if this is not the right place please tell me where could I post
this (I'm not on the list but given the description my guess was that this
was the right place).

The machine is a PIII mobile at 1GHz with intel chipset (i82801+i830M) 256
Megs of RAM the mouse is a Synaptics touchpad. The problem is that the mouse
gets crazy (if using the normal mouse driver) or looses sync (if using the
synaptics driver). I have looked at the interrupts happening when one moves
the mouse and the number is much higher (from 3 to 10 times) in 2.6 compared
with 2.4, also when one stops moving the mouse in 2.6 the interrupts keep on
happening for half a second or so, while it stops inmediately in 2.4.

I have tested this in 2.6.0test3 and test2 with and without the latest patch
available on the acpi.sf.net site, the acpi-20030730-2.6.0-test2.diff.gz
patch, I have also tested with and without APIC, having always the same
result. The only way I found to get the mouse working ok was to fully remove
ACPI, removing only some parts of it was of no use.

Well, hope this helps to put a little bit of light on this problems, if you
need more info to track this down, you want this as a bug on the bts, or
whatever, just tell me.

Regards...
-- 
Manty/BestiaTester -> http://manty.net


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
