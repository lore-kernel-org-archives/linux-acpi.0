From: "Witold Szczeponik" <Witold.Szczeponik@gmx.net>
Subject: [PATCH, trivial] PNP: Use constant PNP_ID_LEN instead of literal
 number
Date: Sun, 27 Nov 2011 22:26:20 +0100
Message-ID: <20111127212620.268500@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:44006 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753397Ab1K0V0Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Nov 2011 16:26:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

The attached patch uses the constant PNP_ID_LEN instead of using a=20
literal number for the length of a PNP ID in the scope of PNP quirks.

As a consequence, all IDs used in PNP quirks (c.f. "drivers/pnp/quirks.=
c")=20
are now zero-terminated and standard functions that depend on the IDs=20
to be zero-terminated now work reliably (c.f. "strlen" in "drivers/pnp/=
driver.c",=20
function "compare_pnp_id").=20


The patch is applied against 3.1.=20


Signed-off-by: Witold Szczeponik <Witold.Szczeponik@gmx.net>



Index: linux/include/linux/pnp.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/linux/pnp.h
+++ linux/include/linux/pnp.h
@@ -295,7 +295,7 @@ static inline void pnp_set_drvdata(struc
 }
=20
 struct pnp_fixup {
-	char id[7];
+	char id[PNP_ID_LEN];
 	void (*quirk_function) (struct pnp_dev * dev);	/* fixup function */
 };
=20

--=20
NEU: FreePhone - 0ct/min Handyspartarif mit Geld-zur=C3=BCck-Garantie!	=
=09
Jetzt informieren: http://www.gmx.net/de/go/freephone
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
