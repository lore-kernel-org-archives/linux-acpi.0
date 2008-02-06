From: Romano Giannetti <romanol@upcomillas.es>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Wed, 06 Feb 2008 11:09:20 +0100
Message-ID: <1202292560.21858.5.camel@localhost>
References: <20071226020325.GA21099@srcf.ucam.org>
	 <20080128012549.GA24166@srcf.ucam.org>
	 <20080127211013.1ddaa6a1.akpm@linux-foundation.org>
	 <200802012246.13162.lenb@kernel.org>
	 <20080202113008.GA4251@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from antispam.upcomillas.es ([130.206.70.245]:52772 "EHLO
	antispam.upcomillas.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760848AbYBFKJW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 05:09:22 -0500
In-Reply-To: <20080202113008.GA4251@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org



On Sat, 2008-02-02 at 09:30 -0200, Henrique de Moraes Holschuh wrote:
> On Fri, 01 Feb 2008, Len Brown wrote:
> > You might check if CONFIG_ACPI_VIDEO=3Dm is set and you can load th=
e "video" module.
> > While the sony may be non-standard and not load, your thinkpad may =
work.
[...]
>=20
> We really need to solve the userspace mess, though.
>=20

I do not know if this is relevant... but for example, with a i915 hw
here (toshiba laptop):

#cat max_brightness=20
100

#echo 50 > brightness ; cat actual_brightness=20
0
#echo 60 > brightness ; cat actual_brightness=20
0
#echo 70 > brightness ; cat actual_brightness=20
70
#echo 80 > brightness ; cat actual_brightness=20
0
#echo 90 > brightness ; cat actual_brightness=20
0
#echo 100 > brightness ; cat actual_brightness=20
100

#uname -a
Linux rukbat 2.6.24 #13 SMP PREEMPT Fri Feb 1 13:12:23 CET 2008 i686 GN=
U/Linux

which is at least strange (and probably broken). actual_brightness is
real, when it says 0 backlight is off. You can imagine what happens
using the backlight up/down control... flashing lights!=20

Romano


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
