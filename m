From: Dimitris Stasinopoulos <dimitris-1R3Ry79yXbc@public.gmane.org>
Subject: 2.4.21-rc1+acpi_24042003: Failure on Compaq 1722EA
Date: Wed, 30 Apr 2003 11:02:56 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304301102.56509.dimitris@linea.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
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

Hello, I have a Compaq 1722EA, which works with the _stock_ DSDTs quite 
well (battery, thermal zone, AC, fan, lid), in conjuction with kernel 
2.4.18+acpi04102002. I do however want to upgrade to 2.4.21-rc1, but 
patching up with acpi24042003 and trying to boot get nowhere. After 
printing these messages:

ACPI: Embedded controler [H8] (gpe 29)
schedule_task(): keventd has not started
schedule_task(): keventd has not started
PCI: probing PCI hardware
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10

it hangs indefinately, without any further messages. The PCI bridge is an 
Intel 82801BAM/CAM. So:

1) Any ideas on the problem? All I want is battery stats, the thermal 
zone, AC, fan and the lid button. Sleep states do not concern me.
2) Is there any way I can port the 2.4.18+acpi patch code that works for 
me to 2.4.21-rc1? Or are there major changes in the rest of the kernel 
that effectively prohibit this?  Thanks in advance

Dimitris

-- 
Not only will all eyes be on the leaders of men,
but all combat sights as well.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
