From: Aragorn <g.cioffi-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Subject: Unresolved symbols and exported symbols version
Date: Sat, 28 Dec 2002 16:35:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021228163548.B1679@Thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hello all,

  I've got  a stock 2.4.20 kernel  upon which I applied  the latest ACPI
patch (acpi-20021212-2.4.20.diff.gz). After recompiling it together with
the modules, rebooting, ``modprobe  battery'' complains about unresolved
symbols. I lookup  these symbols in ``System.map'' and  they seem indeed
present! A  deeper investigation  in /proc/ksyms  shows some  oddity (at
least  for me)  in  kernel symbol  versioning. I've  been  able to  work
around  the  issue  by  exporting the  symbols  in  ``acpi_ksyms.c''  as
``EXPORT_SYMBOL_NOVERS''.

  The following transcript shows  the difference between the unversioned
symbols vs. versioned ones:

------------8<------------8<------------8<------------8<------------
Script started on Sat Dec 28 15:50:51 2002
[root@Thorin:~root@Thorin root]# cat /proc/ksyms
[.. these are versioned ..]
c017fdb0 acpi_get_handle_R__ver_acpi_get_handle
c01800b0 acpi_get_parent_R__ver_acpi_get_parent
c0180040 acpi_get_type_R__ver_acpi_get_type
c017fe80 acpi_get_name_R__ver_acpi_get_name
c017ff20 acpi_get_object_info_R__ver_acpi_get_object_info
[.. whereas a typical versioned symbol looks like : ..]
c0217f80 rb_insert_color_Raa2b5a22
[..]
[.. these are my messed up EXPORT_SYMBOL_NOVERS ones ..]
c01888e0 acpi_bus_get_device
c0188920 acpi_bus_get_status
c0188990 acpi_bus_get_power
c0188a50 acpi_bus_set_power
[..]

[root@Thorin root]# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.20/kernel/drivers/acpi/ac.o
depmod: 	acpi_install_notify_handler
depmod: 	acpi_evaluate_integer
depmod: 	acpi_remove_notify_handler
depmod: *** Unresolved symbols in /lib/modules/2.4.20/kernel/drivers/acpi/battery.o
depmod: 	acpi_os_free
depmod: 	acpi_install_notify_handler
depmod: 	acpi_extract_package
depmod: 	acpi_evaluate_object
depmod: 	acpi_get_handle
[..]
[root@Thorin root]# exit
Script done on Sat Dec 28 15:51:25 2002
------------8<------------8<------------8<------------8<------------

  Note  that if  I  do ``depmod  -F  System.map -ae''  I  don't get  any
error...

  In short:  if I replace  every EXPORT_SYMBOL in  ``acpi_ksyms.c'' with
EXPORT_SYMBOL_NOVERS, the  unresolved symbols go away,  the modules load
and everything seems to work right.

  My modutils/binutils, etc. meet the requirements of this kernel.

  I  don't  know if  this  is  a non-issue,  maybe  that's  just me  not
understanding enough of how modules' versions work... :)

thanks,
-- 
Aragorn


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
