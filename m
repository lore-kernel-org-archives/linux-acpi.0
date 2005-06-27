From: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Subject: No fan control on an Acer Aspire 1694WLMi
Date: Mon, 27 Jun 2005 23:44:07 +0200
Message-ID: <42C07327.3000209@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

Hello,

I got an Acer Aspire 1694WLMi with bios 3c25.

The fan control has no been fixed by my DSDT. The /proc/acpi/fan is empty=
.
I put the "cookbook" for debugging my DSDT, perhaps you can have a look a=
t it to see if something is wrong.


The folder /proc/acpi/thermal_zone/THRM has:
----------------8<----------------
#cat /proc/acpi/thermal_zone/THRM/cooling_mode
<setting not supported>
cooling mode:   passive

#cat /proc/acpi/thermal_zone/THRM/polling_frequency
polling frequency:       30 seconds

#cat /proc/acpi/thermal_zone/THRM/state
state:                   ok

#cat /proc/acpi/thermal_zone/THRM/temperature
temperature:             44 C

#cat /proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           97 C
passive:                 85 C: tc1=3D2 tc2=3D3 tsp=3D40 devices=3D0xdfc07=
168
---------------->8----------------

The fan module is present:
----------------8<----------------
# lsmod | grep fan
fan                     6020  0

#zgrep -i fan /proc/config.gz
CONFIG_ACPI_FAN=3Dm
---------------->8----------------
At the boot, the fan doesn't start immediately, then it start at fisrt
speed. After a moment the fan rotates at full speed, but never goes
down, even if the temperature is 44=B0C.

The CPU is not at full speed (max:2000MHz):
----------------8<----------------
#cat /proc/cpuinfo  | grep "cpu MHz"
cpu MHz         : 798.354
---------------->8----------------

Any ideas?

Thank you for your help
Best regards
Didier






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
