From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] [2/2] Allow override acpi_gbl_pre_defined_names (aka change that _OS).
Date: Wed, 5 Feb 2003 19:47:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030205184725.GL1205@poup.poupinou.org>
References: <4.3.2.7.2.20030204000748.00b62270@mail.dns-host.com> <20030204094540.GE1205@poup.poupinou.org> <20030204132251.E16744@suse.de> <20030204154359.GH1205@poup.poupinou.org> <20030204164641.A31886@suse.de> <20030204155548.GI1205@poup.poupinou.org> <3E40AF32.AA177847@monetplus.cz> <20030205133049.A18324@suse.de> <20030205184310.GK1205@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030205184310.GK1205-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dave Jones <davej-l3A5Bk7waGM@public.gmane.org>, =?iso-8859-1?Q?Zden=ECk_OGAR_Skal=E1k?= <skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is the linux part.  It permit to pass a apci_os_name= boot args
in order to override the \_OS.



--- linux/drivers/acpi/osl.c	2003/02/05 15:51:26	1.5
+++ linux/drivers/acpi/osl.c	2003/02/05 18:09:21
@@ -201,6 +201,8 @@
 	return AE_OK;
 }
 
+static char acpi_os_name[200] = ACPI_OS_NAME;
+
 acpi_status
 acpi_os_predefined_override (const struct acpi_predefined_names *init_val,
 		             acpi_string *new_val)
@@ -209,6 +211,9 @@
 		return AE_BAD_PARAMETER;
 
 	*new_val = NULL;
+	if (!memcmp (init_val->name, "_OS_", 4))
+		*new_val = acpi_os_name;
+
 	return AE_OK;
 }
 
@@ -848,3 +853,28 @@
 
 	return AE_OK;
 }
+
+int __init
+acpi_os_name_setup(char *str)
+{
+	char *p = acpi_os_name;
+	int count = 199;
+
+	if (!str || !*str)
+		return 0;
+
+	for (; count-- && str && *str; str++) {
+		if (isalnum(*str) || *str == ' ')
+			*p++ = *str;
+		else if (*str == '\'' || *str == '"')
+			continue;
+		else
+			break;
+	}
+	*p = 0;
+
+	return 1;
+		
+}
+
+__setup("acpi_os_name=", acpi_os_name_setup);




Cheers,
-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
