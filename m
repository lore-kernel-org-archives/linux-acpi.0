From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Sleeping pills for the 2.5.39 Insomnia ..
Date: Mon, 30 Sep 2002 19:32:16 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209301932.16677.p_christ@hol.gr>
References: <200209301541.47910.p_christ@hol.gr> <200209301612.28344.p_christ@hol.gr> <1033400645.7338.17.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_S9F936OAAJEG5W7JAF46"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1033400645.7338.17.camel-s1IKGncK6J2OERECOqmV57dB6IYNvbhm87tLKu7D3g4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--------------Boundary-00=_S9F936OAAJEG5W7JAF46
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit

> Since software_suspend() gets called from there and IIRC thats not part
> of the acpi subsytem I wonder why S4 would not work in case state is
> correctly set there...
>
> Anyway, thats only a quick shot assumption so do not flame in case
> I am plain wrong ;)
>

I already solved the bug. Don't try any more..

To A.Grover: please apply the patch (or just the '!' yourself).
I'd like the two extra messages to be always logged. It's your call to keep 
them.

Can you give me a one-line explanation for those messages I get with S4? Is 
the S1 warning of any importance?

--------------Boundary-00=_S9F936OAAJEG5W7JAF46
Content-Type: text/x-diff;
  charset="iso-8859-7";
  name="sleep.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sleep.diff"

diff -bBaur ./drivers/acpi/sleep.c /usr/src/linux/drivers/acpi/sleep.c
--- ./drivers/acpi/sleep.c	2002-09-28 14:05:32.000000000 +0300
+++ /usr/src/linux/drivers/acpi/sleep.c	2002-09-30 19:11:58.000000000 +0300
@@ -329,8 +329,9 @@
 	state_string[count] = '\0';

 	state = simple_strtoul(state_string, NULL, 0);
+	printk(KERN_INFO PREFIX "sleep: S%d written\n", state);

-	if (sleep_states[state])
+	if (!sleep_states[state])
 		return_VALUE(-ENODEV);

 #ifdef CONFIG_SOFTWARE_SUSPEND
@@ -341,6 +342,8 @@
 #endif
 	status = acpi_suspend(state);

+	printk(KERN_INFO PREFIX "sleep: S%d resumed w. status 0x%x\n", state, status);
+
 	if (ACPI_FAILURE(status))
 		return_VALUE(-ENODEV);

@@ -665,7 +668,7 @@
 	if (acpi_disabled)
 		return_VALUE(0);

-	printk(KERN_INFO PREFIX "(supports");
+	printk(KERN_INFO PREFIX "Sleep supports");
 	for (i=0; i<ACPI_S_STATE_COUNT; i++) {
 		u8 type_a, type_b;
 		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
@@ -674,7 +677,7 @@
 			printk(" S%d", i);
 		}
 	}
-	printk(")\n");
+	printk("\n");


 	/* 'sleep' [R/W]*/


--------------Boundary-00=_S9F936OAAJEG5W7JAF46
Content-Type: application/x-bzip2;
  name="messages.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="messages.bz2"

QlpoOTFBWSZTWVSq/A8AAZxfgEAQYO//8q+iWoA/79/kQAKKuGxtrbQkoCGgp6anoZQyGmjRoA0N
A0EiSYSMmkNTT1MAhoB6AI9TMhgAAAAAAAAAAEUiIaaTyTT0IyNBoAANAGmeuBtLbdvtwbvOOcmf
DQ2bJ9QjPRnZVwh5uVJBvRahJ47ahLRMF4jRMnCqDSJMNsYmTiXn1TojQhKTjTLThrjZUwkGO99G
TdFPLmll1IWlFTnvOJ7oBX1a+xtoabG022NjefjDT1HZS/NcxaUbmiXrM14k+kx7a0XAlvDCJqSZ
7lBKhFuki2PlYizJlINM84VQB3zRbpSrvap8fdbSDBhkgQiVaMdArk393kIhJ6JAaWAnBHMEk1se
rI6NxAsTeRbAcmHNIuYIhIIx7Jvz5hID0i8QTVi9QcIf6akJOAjsz/CxMQ+9gYTC5C5peSbh+2Ef
RH26ENKaxRS3k0XjGZ2oDBDNkopUJFJEH69loHXYV9c91lTMX6pBmIi/hHahZyUpJCtSxCDDjQlR
WN+5IVsW0ZBB7FE2wcss18LfsZkggtQuGW3NnRdgV1heTEi2syEvyJOpccslYcb1lO5plqVaQpBS
DJ0hOMhhdhMqZBQRWg1cuIye/VcKjVxCpikKEF1shYhGBIeOv3ISvurQlmdrI1oSrBi1SWhHX+MI
GYTQZQnVgzn9JaUXFrL6jPSRlmFULARxlCJMwL5tg1UGpSQUNcyCaYhhyRuqROCYMTnBImgZpy2x
4tQyJOWKkQykKTAJtIRKBtsrVKaWxoSwxOLfd7i7kinChIKlV+B4

--------------Boundary-00=_S9F936OAAJEG5W7JAF46--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
