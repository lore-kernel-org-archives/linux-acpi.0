From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.12-rc2-mm1: ACPI=y, ACPI_BOOT=n problems
Date: Tue, 5 Apr 2005 18:36:55 -0700
Message-ID: <20050405183655.0c778129.akpm@osdl.org>
References: <fa.gcqu6i7.1o6qrhn@ifi.uio.no>
	<42524D83.1080104@reub.net>
	<20050405121444.GB6885@stusta.de>
	<6.2.3.0.2.20050406002812.04393a30@tornado.reub.net>
	<20050405132417.GD6885@stusta.de>
	<4252F090.4040605@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4252F090.4040605-dIRlkrwy3vBBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Steven Cole <elenstev-dIRlkrwy3vBBDgjK7y7TUQ@public.gmane.org>
Cc: bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org, reuben-lkml-MwA23MxOyI4@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Steven Cole <elenstev-dIRlkrwy3vBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> arch/i386/kernel/setup.c: In function 'setup_arch':
>  arch/i386/kernel/setup.c:1571: warning: implicit declaration of function 'acpi_boot_table_init'
>  arch/i386/kernel/setup.c:1572: warning: implicit declaration of function 'acpi_boot_init'


diff -puN include/linux/acpi.h~no-acpi-build-fix include/linux/acpi.h
--- 25/include/linux/acpi.h~no-acpi-build-fix	2005-04-05 00:14:46.000000000 -0700
+++ 25-akpm/include/linux/acpi.h	2005-04-05 00:23:39.000000000 -0700
@@ -418,16 +418,6 @@ extern int sbf_port ;
 
 #define acpi_mp_config	0
 
-static inline int acpi_boot_init(void)
-{
-	return 0;
-}
-
-static inline int acpi_boot_table_init(void)
-{
-	return 0;
-}
-
 #endif 	/*!CONFIG_ACPI_BOOT*/
 
 unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
@@ -538,5 +528,18 @@ static inline int acpi_get_pxm(acpi_hand
 
 extern int pnpacpi_disabled;
 
+#else	/* CONFIG_ACPI */
+
+static inline int acpi_boot_init(void)
+{
+	return 0;
+}
+
+static inline int acpi_boot_table_init(void)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_ACPI */
+
 #endif	/* _LINUX_ACPI_H */
_



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
