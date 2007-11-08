From: Romano Giannetti <romanol@upcomillas.es>
Subject: 2.6.24-rc2 (esthetic?) regression: auto select interrupt spams my
	logs
Date: Thu, 08 Nov 2007 10:55:44 +0100
Message-ID: <1194515744.7115.12.camel@rukbat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ic0245.upco.es ([130.206.70.245]:45924 "EHLO
	antispam.upcomillas.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758465AbXKHJzq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2007 04:55:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


Hi,

After the ACPI changes between 2.6.24-rc1 and -rc2 I have my logs
"spammed" (every 2-3 seconds) by:=20

[  423.112903] ACPI: EC: missing IBF_1 confirmations,switch off interru=
pt mode.
[  423.113020] ACPI: EC: non-query interrupt received, switching to int=
errupt mode
[  426.078972] ACPI: EC: missing IBF_1 confirmations,switch off interru=
pt mode.
[  426.079645] ACPI: EC: non-query interrupt received, switching to int=
errupt mode
[  426.622773] ACPI: EC: missing IBF_1 confirmations,switch off interru=
pt mode.
[  426.622889] ACPI: EC: non-query interrupt received, switching to int=
errupt mode

It seems that no harm is done, apart (but it could be another thing)
that gnome-panel is much slower on startup.=20

Romano =20


--=20
Sorry for the disclaimer --- =A1I cannot stop it!



--
La presente comunicaci=F3n tiene car=E1cter confidencial y es para el e=
xclusivo uso del destinatario indicado en la misma. Si Ud. no es el des=
tinatario indicado, le informamos que cualquier forma de distribuci=F3n=
, reproducci=F3n o uso de esta comunicaci=F3n y/o de la informaci=F3n c=
ontenida en la misma est=E1n estrictamente prohibidos por la ley. Si Ud=
=2E ha recibido esta comunicaci=F3n por error, por favor, notif=EDquelo=
 inmediatamente al remitente contestando a este mensaje y proceda a con=
tinuaci=F3n a destruirlo. Gracias por su colaboraci=F3n.

This communication contains confidential information. It is for the exc=
lusive use of the intended addressee. If you are not the intended addre=
ssee, please note that any form of distribution, copying or use of this=
 communication or the information in it is strictly prohibited by law. =
If you have received this communication in error, please immediately no=
tify the sender by reply e-mail and destroy this message. Thank you for=
 your cooperation.=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
