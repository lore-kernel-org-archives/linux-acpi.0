From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI sleep: check error values and disable it on SMP
Date: Tue, 10 Jun 2003 21:14:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030610191437.GD13545@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847E96F42@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F42-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > +#ifdef CONFIG_SMP
> > > > +	/* Suspend is hard to get right on SMP. */
> > > > +	return AE_ERROR;
> > > > +#endif
> 
> This part shouldn't be an #ifdef it should be a runtime check of
> num_online_cpus().

Okay, that makes sense.

Here's updated patch, please apply.
								Pavel

--- /usr/src/tmp/linux/drivers/acpi/sleep/main.c	2003-06-10 21:10:18.000000000 +0200
+++ /usr/src/linux/drivers/acpi/sleep/main.c	2003-06-10 21:08:32.000000000 +0200
@@ -220,6 +220,10 @@
 {
 	acpi_status status;
 
+	/* Suspend is hard to get right on SMP. */
+	if (num_online_cpus() != 1)
+		return AE_ERROR;
+
 	/* get out if state is invalid */
 	if (state < ACPI_STATE_S1 || state > ACPI_STATE_S5)
 		return AE_ERROR;
@@ -232,7 +236,10 @@
 	 * TBD: S1 can be done without device_suspend.  Make a CONFIG_XX
 	 * to handle however when S1 failed without device_suspend.
 	 */
-	freeze_processes();		/* device_suspend needs processes to be stopped */
+	if (freeze_processes()) {
+		thaw_processes();
+		return AE_ERROR;		/* device_suspend needs processes to be stopped */
+	}
 
 	/* do we have a wakeup address for S2 and S3? */
 	/* Here, we support only S4BIOS, those we set the wakeup address */

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
