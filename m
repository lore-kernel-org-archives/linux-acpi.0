From: Johannes Wilms <johannes.wilms-S0/GAf8tV78@public.gmane.org>
Subject: ACPI seems to work, but sleep states don't
Date: Thu, 16 Jun 2005 19:52:06 +0200
Message-ID: <42B1BC46.5030004@web.de>
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

Hi,

I am experiencing strange results with ACPI on my Fujitsu-Siemens Amilo
M7400 (Centrino 1.4GHz), Debian Sarge, Kernel 2.6.11, with some patches
for Winbond SD/MMC card support.

I have ACPI support including Sleep States compiled into the kernel, and
 the Debian packages acpi and acpid installed to access the functions.
The /proc/acpi interface seems to work nicely, returning all information
(like battery status or button events) correctly. Also cat
/sys/power/states lists "standby mem disk" as it should.

On the web, several people report that also sleep states work. I have
appended a list of URLs of reports I have discovered. They all report
that at least disk = Hibernate = S4 works out of the box. They all use
slightly different 2.6 kernels, but rather older ones than mine.

For me, however, echo disk > /sys/power/state doesn't seem to do
anything at all. echo standby > /sys/power/state makes the screen go
black for a second or so, and then return to normal again, and produces
in dmesg:
PM: Preparing system for suspend
Stopping tasks: ===== ... ======|
Restarting tasks... done
The only thing which seems to be the same as in the other installations
is echo mem > /sys/power/state, which does seem to put the system in
suspend mode, but the display cannot be activated again.

I am not particularly interested in the S3 suspend mode, but it would be
nice if I could use S4 and standby.

Maybe I should mention that acpid gives the error message
"acpid: can't open /proc/acpi/event: Device or resource busy"
but then I don't think that's related really.

I would appreciate your help on how to get S4 and standby working, as I
am out of ideas. Especially, I cannot find any reports of a similar
situation online.

Thank you very much,
Johannes Wilms


Other Amilo M7400 users:
http://www.angelfire.com/linux/notebook/fujitsu/m7400.html
http://www.cc.jyu.fi/~hastrup/linux/amilo.html
http://www.rage-star.org/linux.html
http://www.david-froehlich.de/index.html?computer-amilo.html


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
