From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] add "pnpacpi=off", print info during discovery
Date: Fri, 14 Jan 2005 09:35:25 +0800
Message-ID: <1105666525.22995.9.camel@sli10-desk.sh.intel.com>
References: <1105489541.31942.81.camel@eeyore>
	 <1105491763.29370.5.camel@sli10-desk.sh.intel.com>
	 <1105632437.3818.5.camel@eeyore>  <20050113181333.GS6069@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050113181333.GS6069-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-01-14 at 02:13, Adam Belay wrote: 
> Could you send me a copy of your patch.  I'm curious.
We have a case (PNPACPI breaks ES7000 system). We want blacklist PNPACPI
in the arch. My patch doesn't do blacklist now, so I didn't send it out.

Ok, here is my patch (my original patch forgot document, copy Bjorn's),
just a slight difference with Bjorn's.

Thanks,
Shaohua



---

 2.5-root/Documentation/kernel-parameters.txt |    3 +++
 2.5-root/drivers/pnp/pnpacpi/core.c          |   13 +++++++++++--
 2.5-root/drivers/pnp/pnpbios/core.c          |    7 ++++---
 3 files changed, 18 insertions(+), 5 deletions(-)

diff -puN drivers/pnp/pnpacpi/core.c~pnpoff drivers/pnp/pnpacpi/core.c
--- 2.5/drivers/pnp/pnpacpi/core.c~pnpoff	2005-01-14 08:59:56.373706720 +0800
+++ 2.5-root/drivers/pnp/pnpacpi/core.c	2005-01-14 09:20:15.848318400 +0800
@@ -241,10 +241,19 @@ static acpi_status __init pnpacpi_add_de
 	return AE_OK;
 }
 
+int pnpacpi_disabled __initdata;
+static int __init pnpacpi_setup(char *str)
+{
+	if (!strncmp(str, "off", 3))
+		pnpacpi_disabled = 1;
+	return 1;
+}
+__setup("pnpacpi=", pnpacpi_setup);
+
 int __init pnpacpi_init(void)
 {
-	if (acpi_disabled) {
-		pnp_info("PnP ACPI: ACPI disable");
+	if (acpi_disabled || pnpacpi_disabled) {
+		pnp_info("PnP ACPI: disabled");
 		return 0;
 	}
 	pnp_info("PnP ACPI init");
diff -puN drivers/pnp/pnpbios/core.c~pnpoff drivers/pnp/pnpbios/core.c
--- 2.5/drivers/pnp/pnpbios/core.c~pnpoff	2005-01-14 09:02:27.021804728 +0800
+++ 2.5-root/drivers/pnp/pnpbios/core.c	2005-01-14 09:09:44.726263536 +0800
@@ -538,10 +538,11 @@ int __init pnpbios_init(void)
 		return -ENODEV;
 	}
 
-#ifdef CONFIG_ACPI
-	if (!acpi_disabled) {
+#ifdef CONFIG_PNPACPI
+	extern int pnpacpi_disabled;
+	if (!acpi_disabled && !pnpacpi_disabled) {
 		pnpbios_disabled = 1;
-		printk(KERN_INFO "PnPBIOS: Disabled by ACPI\n");
+		printk(KERN_INFO "PnPBIOS: Disabled by ACPI PNP\n");
 		return -ENODEV;
 	}
 #endif /* CONFIG_ACPI */
diff -puN Documentation/kernel-parameters.txt~pnpoff Documentation/kernel-parameters.txt
--- 2.5/Documentation/kernel-parameters.txt~pnpoff	2005-01-14 09:22:04.781758000 +0800
+++ 2.5-root/Documentation/kernel-parameters.txt	2005-01-14 09:24:02.305891616 +0800
@@ -1010,6 +1010,9 @@ running once the system is up.
 			Format: { parport<nr> | timid | 0 }
 			See also Documentation/parport.txt.
 
+	pnpacpi=	[PNPACPI]
+			off   Don't use ACPI to find PNP devices
+
 	pnpbios=	[ISAPNP]
 			{ on | off | curr | res | no-curr | no-res }
 
_




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
