From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: ACPI 2021111 on Asus L3800C
Date: Thu, 14 Nov 2002 20:30:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021114203058.05b4c3c1.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all!
Just thought I'd let you know that ACPI behaves quite well on an Asus
L3800C notebook. All status monitoring functions seem to work (i.e.
battery, fan, temperature) and even the CPU performance and throtteling
works. Also the lid switch works and is recognised (and since the
LCD-off hotkey and lid switch only turn off the backlight I use acpid
and a userspace program to switch off the LCD completely :)

Well done!

Just the sleep modes are all bad :(

S1 freezes the machine instantaniously, switching off the harddisk but
display stays on. S2 to S4 do exactly nothing
S5 just switches the machine off, at once :)

I would VERY much like to suspend to disk somehow. I tried swsusp which
suspends well but resume into X is almost impossible... also the
yenta_socket driver sometimes fails to init on resume.

Anyway, I (have to) use it now and am quite pleased :)
I hope to see some form of suspend working in the near future.

CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
