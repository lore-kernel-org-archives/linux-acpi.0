From: "Craig Dunford" <cdunford-OnllAtm1sHQ@public.gmane.org>
Subject: ACPI Event File
Date: Mon, 14 Feb 2005 13:10:27 -0500
Message-ID: <001501c512c0$76535240$b0ea1946@littledump>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
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

I use acpid as many do to read events from /proc/acpi/event. I'm on a laptop and I use the gnome battstat applet and every once in a 
while it craps out. So I decided to stop acpid so I could take a look at the event file myself. I get this error:

Device or Resource busy

So I decided to restart acpid, but it generated an error similar to the above, saying it also couldn't open the event file.

ACPID starts fine when I boot my lapto though. I used acpi_listen to see what events are coming through. I had been made aware to me 
that the gnome battstat applet expects to see battery events every couple seconds saying it has discharged or recharged some amount. 
To my dismay, acpi_listen showed no events. If I plugged in my laptop or unplugged it, thats the only event that registered.

I also check in /proc/acpi/battery/BAT0/state which shows me the current charge of the battery no problem.

Is there anything I can do to fix this?

I am on Debian running Debian kernel 2.6.8-2-686.

Thanks. 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
