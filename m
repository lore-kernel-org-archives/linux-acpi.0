From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Fwd: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Date: Mon, 28 Mar 2005 03:02:57 -0500
Message-ID: <200503280302.57640.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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


----------  Forwarded Message  ----------

Subject: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state 
issue - 'standby' on a laptop
Date: March 28, 2005 02:53
From: Shawn Starr <shawn.starr at rogers d0t com>
To: Pavel Machek <pavel at suse d0t cz>, Len Brown <len d0t brown at intel d0t 
com>

Hello,

I've noticed something strange with issuing 'standby' to the system:

when echoing "standby" to /sys/power/state, nothing happens, not even a log
 or system activity to attempt standby mode.

However, trying echo "1" to /proc/acpi/sleep the system attempts to (standby)
and aborts:

[4295945.236000] PM: Preparing system for suspend
[4295946.270000] Stopping tasks:
=============================================================================
[4295946.370000] Restarting tasks... done

We get no reason as to why it quickly aborts.

[4294672.065000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294676.827000] ACPI: (supports S0 S3 S4 S5)

What is '1' in /proc/acpi/sleep?  standby mode is not the same as suspend to
ram? when I put a normal desktop in standby mode its still 'on' but the hard
disk is put to sleep and the system runs in a lower power mode.

Shawn.

-------------------------------------------------------


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
