From: Patrick Fries <Patrick-9fk+B6U9FIoKfV0655qpAQ@public.gmane.org>
Subject: Problems with throttling on P4M notebook
Date: Sat, 26 Nov 2005 12:31:36 +0100
Message-ID: <1133004696.14234.17.camel@laptux>
Mime-Version: 1.0
Content-Type: text/plain
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

I have an Acer TravelMate 630 with a 1.40GHz P4m.
My problem is, that throttling does not seem to work.

If I pass "7" to /proc/acpi/proces.../throttling the CPU temparature
doesn't go down faster than usual. The throttling-state is accepted
(since "cat throttling" showes a "*" in front of T7) but without any
effect.

I have to use the "acpi-cpufreq"-driver since "speedstep-smi" does not
work for me. My distro is "Gentoo Linux" running with kernel 2.6.15-rc2.
Additional infos about my notebook can be found here:
http://www.fagotten.org/daniele/acer-tm630/

Thanks in advance,
Patrick




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
