From: Heiko Gerstung <hg-Zwoj8m1Se4ooLuGpnUaJU7NAH6kLmebB@public.gmane.org>
Subject: Something seems to be wrong with my RSDP
Date: Sat, 07 May 2005 14:28:32 +0200
Message-ID: <427CB470.4060700@heiko-gerstung.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi!

I went through the process of cleaning up my DSDT with iasl and fixed it
for my Acer C100, it went from 47 errors/0 warnings to 0 errors/0
warnings, but even compiling this into my kernel did not enable ACPI on
my machine.

I hacked the kernel (drivers/acpi/tables.c) and removed the checksum
test for my RSDP, now it fails with the error message
"ACPI: No System Description Table (RSDT/XSDT) specified in RSDP"

Which brings me to the point where I think that the reading of my RSDP
completely fails (therefore the checksum test fails and no DSDT can be
found somehow).

Is there any ACPI guru alive who could give me a hint why getting the
RSDP cannot be read and what I could check/alter to fix this? Remember:
The Knoppix kernel works fine, and I am currently trying to get an exact
copy of the source tree for that kernel in order to find out what's the
difference...

If I get my kernel up and running with ACPI I will check whether my DSDT
runs fine and contribute it to your database, as there is currently no
fixed DSDT available for my Acer Travelmate C100 ...

Kind regards,
Heiko





-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
