From: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Subject: kacpid problems
Date: Sat, 06 Nov 2004 00:38:34 +0100
Message-ID: <418C0EFA.6000001@yahoo.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello,

My trip_points file in /proc/acpi/thermal_zone/THRM looks like this:
critical (S5):           85 C
passive:                 70 C: tc1=5 tc2=3 tsp=256 devices=0xcdde39a8
active[0]:               45 C: devices=0xcdd94c28

The problem comes when I try to compile big programs, like 
inkscape(vector drawing program) or when I play games. I think this is a 
bug, but I don't really know, because I'm not a acpi programmer.
When my processor gets too hot, over 85 C it tries to shutdown(S5), but 
the only thing that happends is that kacpid starts running and runns 
with 99% CPU usage.
(taken from top)
5 root       7 -10     0    0    0 R  99.0  0.0   0:17.94 kacpid

Is it someone who knows what is wrong? Is it a bug or is it my hardware 
that is the problem?

thanks in advance

Jon Emil


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
