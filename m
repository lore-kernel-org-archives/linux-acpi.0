From: Luca Cerutti <videobert-whZMOeQn8C0@public.gmane.org>
Subject: Toshiba M30 - Fan does NOT switch on.
Date: Fri, 17 Dec 2004 17:24:59 +0100 (CET)
Message-ID: <20041217162459.69320.qmail@web14104.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

first of all, my configuration:
HW: Toshiba Satellite M30
SW: (on dual-boot) Debian 3.1
- Kernel 2.6.8-1-686 deb
- speedstep_centrino loaded as module
- toshiba_acpi 0.18 loaded as module
- acpi interface installed
- acpid installed.

ISSUES:
1) ACPID
 acpid DOES NOT appear to start: error message "cannot
open /proc/acpi/events resource busy" (sort of)

2) FAN, TRIPPOINTS AND POLICIES
 with trip_points set to "110:0:90:40:0" I can with
ease reach temperatures of 50-55 C at full CPU speed
(1600) and then I prefer to manually switch on the fan
echoing into /proc/acpi/toshiba/fan or to "powersave"
my cpufreq down to 600Mhz... what puzzles me is that
the fan SHOULD switch on at 40C
No matter what I'm echoing as cooling policy... IT
ALWAYS STAYS on "passive" (not that I notice any
effect of this"

This is becoming a little bit annoying because either
i write a script that toggles the toshiba/fan on every
time I'm boosting the cpu, or I may as well cook an
egg on the chassis of the notebook.

Waiting for your answers I thank you in advance


		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
