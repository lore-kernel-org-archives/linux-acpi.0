From: Richard Mittendorfer <jkerdawn-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: toshiba lib no thermal update
Date: Mon, 8 Nov 2004 18:51:37 +0100
Message-ID: <20041108175137.GA26466@sin.x.ray>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
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

hi there.

the thermal sensor on a libretto 110ct doesn't seem to work. at
initialization it get's read out right, but refuses to update, it stays
at the bootup value then.

i get some error about AE_NOT_FOUND at bootup, but nothing about THRM,
and they don't seem to be critical - throttling, buttoncontrol and
sleep states (except hibernation) work - and the acpi function on this
rather old box may not be that well supported;)?

i've tried various kernels from the 2.4 and 2.6 series, but that didn't
solve the problem. has this shown up somewhere before or can anybody
give me a hint how to fix this?

please CC me to jkerdawn at yahoo dot com since i'm not on the list.

thanks a lot.
ritch.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
