From: Phil Short <justswitch-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: What should visible in /proc/acpi?
Date: Fri, 26 Jul 2002 13:38:53 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020726131505.D82573-100000@Grayswandir.cygnet_hq>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

What files/directories should be visible in /proc/acpi?

The system is a stock Toshiba 1005-S157, which has a 1.06Ghz Celeron, with
BIOS changed to Rev 2.1.

Using 2.4.18+acpi-20020709+nocorruption.2.patch+swsusp9 (and hand-patching
CONFIG_ACPI_SLEEP in the appropriate location) the following entries
appear in the /proc/acpi directory:

alarm battery button debug_layer debug_level dsdt embedded_conroller
event fadt info processor sleep

In particular there is nothing related to the ac_adaptor, fan or thermal
functions.  Also, the sleep functions do not appear to work, and events
(power button and lid switch) appear to work intermittently.  The only
function that appears to work cleanly is the battery state reporting
function (and of course the various info functions).  There do not appear
to be any IRQ routing problems (at least all of the laptop hardware
appears to work).  There is one apparent acpi-related error message in the
dmesg output:

 exfldio-0110 [280] Ex_setup_region   : Field [ACPW] Base+Offset+Width
38+0+4 is beyond end of region [GPIO] (length 3B)
 acpi-ac-0082 [266] acpi_ac_get_state : Error reading AC Adapter State

Similar results are obtained with 2.4.18+20020725 (after commenting out
each debug that were causing compile errors).

How closely does this relate to what it should be on a working system? Do
I need to provide more info?

--

Phil




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
