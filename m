From: chirag <nisha_rajyaguru-xFOqZoH7zVZ4Eiagz67IpQ@public.gmane.org>
Subject: inspiron 5150 DSDT
Date: Wed, 29 Dec 2004 01:45:05 +0900
Message-ID: <1104252306.6382.12.camel@YahooBB219031151066.bbtec.net>
Reply-To: chirag-9dAiHs7qY9HTsWAM89vZ1+0/RLrZM5er@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi guys!

I posted earlier also but it seems that I was not able to draw enough
attention. The problem is about the ACPID events. The simptoms are
almost same as described in bug 1752
http://bugme.osdl.org/show_bug.cgi?id=1752. There are no button or lid
events. Lid closer always logs event as if the AC adepter was plugged
in. Power button event is not executed but as soon as a USB device is
plugged in the power button script in /etc/acpi/event is executed as if
it was queued. When I compiled the DSDT, it gives me a warning   
dsdt.dsl  1373:                 Method (_S0D, 0, NotSerialized)
Warning  2033 -      Unknown reserved name ^  (_S0D)

The warning occur at 4 places which correspond to USB device related
stuff namely USB0, USB1, USB2,USB3 

Device (USB0)
            {
                Name (_ADR, 0x001D0000)
.                Method (_S0D, 0, NotSerialized)
			|
			|
			|
and so on...............................

Could execution of events with plugging of usb device and irratic
reporting of button, lid and AC adepter events be related to these
warnings in DSDT?

Please help.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
