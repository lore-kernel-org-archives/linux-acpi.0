From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH] do not compile Sony Vaio extras as a module per default
Date: Sun, 22 Oct 2006 08:39:24 +0200
Message-ID: <20061022063924.GA7177@gollum.tnic>
Reply-To: petkov@math.uni-muenster.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp104.plus.mail.re2.yahoo.com ([206.190.53.29]:43407 "HELO
	smtp104.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1423057AbWJVGjb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Oct 2006 02:39:31 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


Signed-off-by: <petkov@math.uni-muenster.de>

--- current/drivers/acpi/Kconfig.orig	2006-10-21 10:02:23.000000000 +02=
00
+++ current/drivers/acpi/Kconfig	2006-10-21 10:02:30.000000000 +0200
@@ -262,7 +262,6 @@ config ACPI_SONY
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
-	default m
 	  ---help---
 	  This mini-driver drives the ACPI SNC device present in the
 	  ACPI BIOS of the Sony Vaio laptops.

--=20
Regards/Gru=DF,
    Boris.

=09

=09
	=09
___________________________________________________________=20
Der fr=FChe Vogel f=E4ngt den Wurm. Hier gelangen Sie zum neuen Yahoo! =
Mail: http://mail.yahoo.de=0D
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
