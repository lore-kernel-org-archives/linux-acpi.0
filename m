From: "Thomas Charbonnel" <thomas-pgofvZdtUFgdnm+yROfE0A@public.gmane.org>
Subject: reenabling C2/C3 states disabled by BIOS ?
Date: Wed, 19 Jan 2005 19:13:23 +0100 (CET)
Message-ID: <35062.217.81.127.127.1106158403.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hi,

I have an Asus L5D laptop, with an AMD64 3000+ DTR processor on an
nForce3-150 chipset. I'm trying to get the quietest possible operation
on this machine. I already use powernow, and undervolted the cpu to the
minimum voltage for the slowest state (800 mV @ 800 MHz) using the
DSDT's _PSS entries, but I thought it may be possible to go further.
According to AMD's doc, this DTR cpu (considered as Mobile although not
a low-voltage one) should support acpi C states, but they seem to be
disabled by the BIOS. I already fixed the DSDT because the P_BLK length
was set to 0 (which got me throttling working), but then I realized the
P_LVL2_LAT and P_LVL3_LAT values in the FADT were set to 101 and 1001
respectively so that C states were disabled according to the ACPI specs.
I tried to override those values with AMD's recommended ones for my cpu
(P_LVL2_LAT=3D1 and P_LVL3_LAT=3D10) in drivers/acpi/processor_idle.c. As=
 a
result the CPU is now reported as power management capable,
and /proc/acpi/processor/CPU1/power reports that most time is spent in
C2 (C3 is never used because bus master activity is always reported to
be very high). The problem is that paradoxicaly the CPU seems to consume
more power and get hot faster with this hack than without. I'm most
certainly missing something, as all this is quite new to me. Is there
anything I can try from this point, or should I just wait for a BIOS
udpate ?

Thanks,
Thomas






-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
