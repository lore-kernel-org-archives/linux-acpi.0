From: Romano Giannetti <romanol@upcomillas.es>
Subject: missing IBF_1 confirmations?
Date: Wed, 07 Nov 2007 00:09:50 +0100
Message-ID: <1194390590.26583.4.camel@rukbat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ic0245.upco.es ([130.206.70.245]:54353 "EHLO
	antispam.upcomillas.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbXKFXJy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Nov 2007 18:09:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org


Hi,=20

	latest git (v2.6.24-rc1-748-g2655e2c) spams my logs with a message
like:=20

SYS: Nov  6 23:55:21 rukbat kernel: [ 1479.474976] ACPI: EC: missing
IBF_1 confirmations,switch off interrupt mode.
SYS: Nov  6 23:55:21 rukbat kernel: [ 1479.475838] ACPI: EC: non-query
interrupt received, switching to interrupt mode

every now and then.=20

(0)rukbat:~% dmesg | grep IBF_1 | wc -l
178

Is it dangerous? I didn't happen with a 2.6.24-rc1.

	Romano=20

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
