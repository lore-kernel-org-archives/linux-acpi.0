From: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
Subject: kacpid respawning under linux-2.4.20 on Toshiba Satellite 5105
Date: Sun, 22 Dec 2002 12:41:08 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021222204108.GC689@budgie.we1.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have a Toshiba Satellite 5105-S501 and have problems with the latest
patches for the 2.4.20 kernel.  Under 2.4.19 things work ok, but with
the 2.4.20 patches I get kacpidpc respawning continuously.  My load
average sits around 1 with the kacpidpc thread always showing up
as a zombie process. It also seems that this forces the CPU fan to
run continuously.  I'm trying to build a 2.4.20-pre kernel (with
little luck) to see at what point this change occurs.

Can anyone give me some pointers where to look next in the 2.4.20
sources?

Thanks -- Ken


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
