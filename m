From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] TRIVIAL allow ME OS in os_acpi_name override.
Date: Mon, 12 May 2003 16:48:56 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030512144856.GF19475@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


OS Windows ME override for os_acpi_name need character ':' to be
included.

Please apply.

--- linux/drivers/acpi/osl.c	2003/05/09 13:57:41	1.1
+++ linux/drivers/acpi/osl.c	2003/05/12 14:41:42
@@ -999,7 +999,7 @@
 		return 0;
 
 	for (; count-- && str && *str; str++) {
-		if (isalnum(*str) || *str == ' ')
+		if (isalnum(*str) || *str == ' ' || *str == ':')
 			*p++ = *str;
 		else if (*str == '\'' || *str == '"')
 			continue;

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
