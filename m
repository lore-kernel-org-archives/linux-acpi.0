From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Problem with fan control
Date: Sun, 9 Mar 2003 19:44:30 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030309194430.04b511ac.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all!
Playing around with thermal control and fan (ACPI 030228) I noticed the
following in my dmesg:

acpi_power-0363 [446] acpi_power_transition : Error transitioning device
[CFAN] to D3 acpi_bus-0496 [445] acpi_bus_set_power    : Error
transitioning device [CFAN] to D3 acpi_thermal-0567 [444]
acpi_thermal_active   : Unable to turn cooling device [c159f1a8] 'off'

I suspect this is not critical but nonetheless concerns me a little.

Next I found that the thermal management seems a little strange.
It does a pretty nice job controlling the CPU temperature using the CPU
throtteling. But the performance settings are used in the wrong way.
When my CPU gets hotter the performance setting is (re)set to maximum
performance and all manual resetting it is reverted after some seconds.

I am trying this on my P4M Asus L3800C where P0 and P1 mean about 50%
less power usage and thus less temperature. Returning it to P0 does not
make much sense to me... or is this a 'feature' of my ACPI BIOS?

CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
