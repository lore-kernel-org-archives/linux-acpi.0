From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [PATCH] ACPI poweroff fixes for 2.4.26-pre2
Date: Fri, 26 Mar 2004 01:01:50 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080262910.4144.39.camel@darkstar>
References: <20040308205444.GH484@elf.ucw.cz>
	 <20040309233325.GA22953@alpha.home.local>
	 <1079279490.10225.10.camel@darkstar>
	 <20040315210729.GA19306@alpha.home.local>
	 <1079389434.3695.2.camel@darkstar>
	 <20040315231927.GA19829@alpha.home.local>
	 <20040322105946.GC1505@openzaurus.ucw.cz>
	 <1080253327.3755.20.camel@darkstar> <20040325222934.GF2179@elf.ucw.cz>
	 <1080255058.4187.1.camel@darkstar>  <20040325230037.GK2179@elf.ucw.cz>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vZkZfddOl8R88h3fvMIU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040325230037.GK2179-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-vZkZfddOl8R88h3fvMIU
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Preamble :
I can be confused, but far as I know, you propose a patch for a _very
wrong_ thing, ( I believe that you are right ).
acpi_system_save_state is one reality, at least in kernel 2.4.26-pre2,
but what you propose looks like, that just resolve half of the problem.
if it a recently patch that made this problem I don't know.

Seeing the code yes, you are right.
I don't know if as make any sense to you but, what do you think put
acpi_system_save_state under #ifdef CONFIG_PM instead of CONFIG_SLEEP ?
like this=20

thanks
On Thu, 2004-03-25 at 23:00, Pavel Machek wrote:
> Hi!
>=20
> > so acpi_system_save_state(state) does do nothing at all ?
> > or does return nothing at all ?
>=20
> IIRC there was patch that made acpi_system_save_state() do nothing at
> all if !CONFIG_ACPI_SLEEP. I'm arguing thats very wrong.
> 								Pavel
--=20
S=E9rgio M. B.

--=-vZkZfddOl8R88h3fvMIU
Content-Disposition: attachment; filename=sys.diff
Content-Type: text/x-patch; name=sys.diff; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.26-pre2/drivers/acpi/system.c.orig	2004-03-26 00:47:29.000000000 +0000
+++ linux-2.4.26-pre2/drivers/acpi/system.c	2004-03-26 00:57:11.000000000 +0000
@@ -46,14 +46,16 @@
 #include <linux/mc146818rtc.h>
 #include <linux/irq.h>
 #include <asm/hw_irq.h>
+#endif /* CONFIG_ACPI_SLEEP */
 
+#ifdef CONFIG_PM
 acpi_status acpi_system_save_state(u32);
 #else
 static inline acpi_status acpi_system_save_state(u32 state)
 {
 	return AE_OK;
 }
-#endif /* !CONFIG_ACPI_SLEEP */
+#endif /* CONFIG_PM */ 
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME		("acpi_system")
@@ -110,62 +112,6 @@
 	printk(KERN_EMERG "ACPI: can not power off machine\n");
 }
 
-#endif /*CONFIG_PM*/
-
-
-#ifdef CONFIG_ACPI_SLEEP
-
-/**
- * acpi_system_restore_state - OS-specific restoration of state
- * @state:	sleep state we're exiting
- *
- * Note that if we're coming back from S4, the memory image should have
- * already been loaded from the disk and is already in place.  (Otherwise how
- * else would we be here?).
- */
-acpi_status
-acpi_system_restore_state(
-	u32			state)
-{
-	/* 
-	 * We should only be here if we're coming back from STR or STD.
-	 * And, in the case of the latter, the memory image should have already
-	 * been loaded from disk.
-	 */
-	if (state > ACPI_STATE_S1) {
-		acpi_restore_state_mem();
-
-		/* Do _early_ resume for irqs.  Required by
-		 * ACPI specs.
-		 */
-		/* TBD: call arch dependant reinitialization of the 
-		 * interrupts.
-		 */
-#ifdef CONFIG_X86
-		init_8259A(0);
-#endif
-		/* wait for power to come back */
-		mdelay(1000);
-
-	}
-
-	/* Be really sure that irqs are disabled. */
-	ACPI_DISABLE_IRQS();
-
-	/* Wait a little again, just in case... */
-	mdelay(1000);
-
-	/* enable interrupts once again */
-	ACPI_ENABLE_IRQS();
-
-	/* turn all the devices back on */
-	if (state > ACPI_STATE_S1)
-		pm_send_all(PM_RESUME, (void *)0);
-
-	return AE_OK;
-}
-
-
 /**
  * acpi_system_save_state - save OS specific state and power down devices
  * @state:	sleep state we're entering.
@@ -259,6 +205,63 @@
 	return error ? AE_ERROR : AE_OK;
 }
 
+#endif /*CONFIG_PM*/
+
+
+#ifdef CONFIG_ACPI_SLEEP
+
+/**
+ * acpi_system_restore_state - OS-specific restoration of state
+ * @state:	sleep state we're exiting
+ *
+ * Note that if we're coming back from S4, the memory image should have
+ * already been loaded from the disk and is already in place.  (Otherwise how
+ * else would we be here?).
+ */
+acpi_status
+acpi_system_restore_state(
+	u32			state)
+{
+	/* 
+	 * We should only be here if we're coming back from STR or STD.
+	 * And, in the case of the latter, the memory image should have already
+	 * been loaded from disk.
+	 */
+	if (state > ACPI_STATE_S1) {
+		acpi_restore_state_mem();
+
+		/* Do _early_ resume for irqs.  Required by
+		 * ACPI specs.
+		 */
+		/* TBD: call arch dependant reinitialization of the 
+		 * interrupts.
+		 */
+#ifdef CONFIG_X86
+		init_8259A(0);
+#endif
+		/* wait for power to come back */
+		mdelay(1000);
+
+	}
+
+	/* Be really sure that irqs are disabled. */
+	ACPI_DISABLE_IRQS();
+
+	/* Wait a little again, just in case... */
+	mdelay(1000);
+
+	/* enable interrupts once again */
+	ACPI_ENABLE_IRQS();
+
+	/* turn all the devices back on */
+	if (state > ACPI_STATE_S1)
+		pm_send_all(PM_RESUME, (void *)0);
+
+	return AE_OK;
+}
+
+
+
 
 /****************************************************************************
  *

--=-vZkZfddOl8R88h3fvMIU--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
