From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: Re: IBM Thinkpad and ACPI 20030916 for 2.4.23-pre4
Date: Wed, 17 Sep 2003 21:12:57 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309172112.57778.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
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
List-Id: linux-acpi@vger.kernel.org


Hi!

I'm havig the same problems, without these patches. I guess, bug is somewhere deeper in the acpi code ...

IBM ThinkPad R40 (lates bios 1.09)

<code>
[root@hrvojelap root]# cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mW
remaining capacity:      58530 mWh
present voltage:         16437 mV
utdelete-0381 [55] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object ced5c928

utdelete-0381 [55] ut_update_ref_count   : **** Warning **** Large Reference Count (CACB) in object ced5c928

utdelete-0381 [51] ut_update_ref_count   : **** Warning **** Large Reference Count (CACC) in object ced5c928

utobject-0467 [46] ut_get_simple_object_s: Unsupported type=CA in object ced5c928
utdelete-0381 [45] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object ced5c928

acpi_battery-0195 [42] acpi_battery_get_statu: Error evaluating _BST
</code>

and after that:

<code>
utdelete-0381 [57] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object ced5ca28

utdelete-0381 [57] ut_update_ref_count   : **** Warning **** Large Reference Count (CACB) in object ced5ca28

utdelete-0381 [53] ut_update_ref_count   : **** Warning **** Large Reference Count (CACC) in object ced5ca28

utobject-0467 [48] ut_get_simple_object_s: Unsupported type=CA in object ced5ca28
utdelete-0381 [47] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object ced5ca28

acpi_battery-0195 [44] acpi_battery_get_statu: Error evaluating _BST
utdelete-0381 [59] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object ced5c928

utdelete-0381 [59] ut_update_ref_count   : **** Warning **** Large Reference Count (CACB) in object ced5c928

utdelete-0381 [55] ut_update_ref_count   : **** Warning **** Large Reference Count (CACC) in object ced5c928

utobject-0467 [50] ut_get_simple_object_s: Unsupported type=CA in object ced5c928
utdelete-0381 [49] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object ced5c928

acpi_battery-0195 [46] acpi_battery_get_statu: Error evaluating _BST
</code>

Hrvoje



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
