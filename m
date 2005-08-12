From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: "Alternative" methods of CPU PM ?
Date: Fri, 12 Aug 2005 11:13:54 +0200
Message-ID: <20050812091354.GA27260@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
  I would like to ask the following more less general question:
  There are systems, which have higher power saving states (C2 and higher)
unavailable because their latency set in the FADT is over the maximal limit.
For example, in my MSI MS-6501 AMD-based dual Athlon board, P_LVL2_LAT
is set to 190. Using plain kernel ACPI doesn't save much power, CPU temps
are high (over 60C) and power consumption as well (3 LEDS shining on an UPS).
  However, there is excellent "AMD 76x native power management" module,
which, when inserted, enables C states upto C3, has a tunable parameter
called "lazy_idle", which allows to set the minimum idle time necessary to
enter C2 state, and its impact is really big, temps go down to 35C or less,
allowing to stop CPU fans, and just one LED shines on UPS (of course when the
machine is idle).
  Why the native ACPI PM (over DSDT etc.) doesn't allow such a functionality ?
Why the BIOS authors didn't enter correct values to the tables to allow us
to use it ? Or is this PM so complex that it cannot be handled by a generic
ACPI kernel driver ? I looked at the source of this module and it's definitely
more complex than the generic ACPI code.
  The same applies to my Clevo D610SU (SiS chipset) notebook. Again,
P2_LVL_LAT=190. It seems it is a very favourite value for ACPI BIOS writers.
However, I don't have a native module for it, so normally just C1 is entered.
I even patched the kernel (increased max C2 lat to 200) to see what will
happen; the system runs OK, stats show that C2 is reached and used, but no more
saving than with C1 seems to be achieved - CPU temp goes over 55C even in a full
idle, causing the fan to start (and I cannot change the THM zone, as I wrote
formerly). The battery is discharged after 2 hours of idling, while on Windows
(my friend's machine, I don't have any) it works over 4 hours of a normal work
(6000 mAh capacity). The same of course applies with unpatched kernel with just
C1 (CPU halt).
  Is there a chance that a native PM for such a chipset/machine will be
written ? Or does it exist anywhere ? Should I contact Clevo to get a spec ?
  Sorry for such a long mail, but I'm really curious about it.
                                        With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
