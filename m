From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: fans not working after suspend to disk on nc-4000 and nc-8000
Date: Mon, 05 Sep 2005 16:12:58 +0200
Message-ID: <E1ECHiU-0005le-00@dorka.pomaz.szeredi.hu>
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

On the nc-4000 and nc-8000 notebooks, there's a problem with the fan
control after a resume from hiberantion.  This is a long standing
problem with an otherwise perfectly working hibernation.  Tried with
2.6.10 to 2.6.13, and with suspend to disk and swsusp2.

After resume the fans are not switched on (or off) based on
temperature.  This is pretty dangerous, and makes hibernation
basically unusable for me.

Unloading the ACPI modules before suspend, and reloding them after
resume doesn't help.

Setting /proc/acpi/thermal_zone/TZ1/polling_frequency to some
value after resume _sometimes_ helps, but not reliably.

A similar report is here:

  http://lists.suspend2.net/lurker/message/20050409.225750.4602a704.en.html

Could someone please help solve this?  I can test debug patches, etc.

Thanks,
Miklos


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
