From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: reading battery status and CPU time
Date: Fri, 04 Apr 2003 21:25:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2n0j6uktr.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

FYI: reading battery status still consumes lots of CPU time. Unless it's
supposed to be that way?

time cat /proc/acpi/battery/BAT0/state produces:

0.000u 0.040s 0:00.12 33.3%     0+0k 0+0io 108pf+0w
0.000u 0.040s 0:00.13 30.7%     0+0k 0+0io 108pf+0w
0.000u 0.030s 0:00.12 25.0%     0+0k 0+0io 108pf+0w
0.000u 0.030s 0:00.14 21.4%     0+0k 0+0io 108pf+0w
0.000u 0.050s 0:00.14 35.7%     0+0k 0+0io 108pf+0w
0.000u 0.030s 0:00.14 21.4%     0+0k 0+0io 108pf+0w

... which causes applications like wmacpi to consume tens of seconds of
CPU time after a while. Not really a price I'd be willing to pay for
knowing the battery status.

This is on 2.4.21-pre6 with acpi-20030328. Sharp Mebius PC-MT1-H3.

--J.


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
