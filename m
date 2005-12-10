From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: MSI boards: C1 listed but not used ?
Date: Sat, 10 Dec 2005 07:43:42 +0100
Message-ID: <20051210064341.GA11410@tangens.sinus.cz>
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

Hi there,
  I have about 3 Athlon mobos from MSI of similar versions (KT6 Delta, K7T
Turbo etc., VIA chipsets) and all 3 seems to be not very friendly to CPU
power management on Linux.
  Not only that they don't allow to use deeper C states than C1 because of
too big latencies (typical trick, P2_LVL_LAT is 101, just one usec above
the limit to keep it disabled), but it seems that even C1 is somewhat
unreachable - in older kernels (like 2.6.11) C1 was even not listed as
available, and now (2.6.15-rc5, 2.6.14.x) it is listed, but with zero usage:

root@co:~# cat /proc/acpi/processor/CPU1/power
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[00000000]

  In the ACPI spec there is, that C1 (HLT instruction) is always available; 
why it seems to be not entered at all ? The above dump was obtained after
a lot of days of uptime with CPU load being 0.00 most of the time.
  Is there a possibility to improve CPU PM a bit ? I know about athcool, it
really helps on 2 of 3 boards, on the third it get an unexpected contents of
some register and doesn't have any effect.
                              With regards, Pavel Troller


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
