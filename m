From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Kill #endif comments
Date: Thu, 29 Aug 2002 00:05:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020828220501.GA30098@elf.ucw.cz>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

The ifdef in acpi.h is no longer dependand on CONFIG_ACPI_BOOT (its
CONFIG_ACPI) so better kill the comment. Also local_irq_disable() that
did not use to be there somehow slipped in (probably my fault). Please
apply,
								Pavel


--- clean/drivers/acpi/system.c	Wed Aug 28 22:38:43 2002
+++ linux-swsusp/drivers/acpi/system.c	Wed Aug 28 23:12:12 2002
@@ -257,7 +257,6 @@
 	unsigned long		flags = 0;
 
 	local_irq_save(flags);
-	local_irq_disable();
 	
 	switch (state)
 	{
--- clean/include/linux/acpi.h	Wed Aug 28 22:39:02 2002
+++ linux-swsusp/include/linux/acpi.h	Wed Aug 28 23:17:41 2002
@@ -345,11 +345,9 @@
 
 extern int acpi_mp_config;
 
-#else /*!CONFIG_ACPI_BOOT*/
-
+#else
 #define acpi_mp_config	0
-
-#endif /*CONFIG_ACPI_BOOT*/
+#endif
 
 
 #ifdef CONFIG_ACPI_PCI

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
