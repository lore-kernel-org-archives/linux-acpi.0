From: Peter Koellner <peter-j7nYi6VcvCfR7s880joybQ@public.gmane.org>
Subject: acpi on sony vaio fx209k, searching for a new starting point
Date: Mon, 30 Dec 2002 16:51:50 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.43.0212301636210.1599-100000@finnegan>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi!

it has been some time, but now i have got the opportunity to experiment with
the acpi development sources again. my last working setup is
linux-2.4.18-rc4 with the acpi-20020214 patch and my own workaround to disable
execution of INI methods.
now i have tried up to linux-2.4.20 with acpi-20021212 and several 2.5
kernels, the most recent of which is 2.5.53.
unfortunately, none of them works. with the 2.5.53 kernel, i did not even
get proper debug messages until now. the system freezes right after acpi
messages on the console screen but does not show them in syslog after reboot.
and then i have to remove the battery and power line to restart, because not
even the power switch works any more. same effect with all patches and
kernels after 2.4.18-rc4 and acpi-20020214.
now i would like to get back into the bugfixing. if i remember well,
the reason why this sony-related bug has not been fixed in the 2.4 series
was the redesign of the driver model, so i suppose i should skip the 2.4
series and concentrate on the 2.5 development sources. is that right?
if so, what can i do to support possible fixes for this problem?
are there any patches around for this sort of problem?

-- 
peter koellner <peter-j7nYi6VcvCfR7s880joybQ@public.gmane.org>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
