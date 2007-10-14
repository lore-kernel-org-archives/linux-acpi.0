From: Romano Giannetti <romanol@upcomillas.es>
Subject: Re: [Suspend-devel] Fan not working after hibernate but ok
	afters2ram?
Date: Sun, 14 Oct 2007 13:09:08 +0200
Message-ID: <1192360148.20668.2.camel@rukbat>
References: <1192224624.7038.9.camel@rukbat>
	<200710131206.34890.rjw@sisk.pl> <471096C2.4070505@suse.de>
	<200710131234.38292.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ic0245.upco.es ([130.206.70.245]:60283 "EHLO
	antispam.upcomillas.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbXJNLJP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Oct 2007 07:09:15 -0400
In-Reply-To: <200710131234.38292.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, suspend-devel@lists.sourceforge.net, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sat, 2007-10-13 at 12:34 +0200, Rafael J. Wysocki wrote:
> O
> OK, thanks.
>=0D
> Romano, the patches are here:
>=0D
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23/patches/38-A=
CPI-power-don_t-cache-power-resource-state.patch
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23/patches/39-A=
CPI-Fan-fan-device-does-not-need-own-structure.patch
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23/patches/40-F=
an-Drop-force_power_state-acpi_device-option.patch
>=0D
> Can you please apply them on top of 2.6.23 and see if that helps?

Will try as soon as I have half an hour. Unfortunately, I have to
prepare a lt of classes for tomorrow; I'll see if I can find a little
spot... thanks so much. I will be back asap.

Romano=0D



--
La presente comunicaci=C3=B3n tiene car=C3=A1cter confidencial y es par=
a el exclusivo uso del destinatario indicado en la misma. Si Ud. no es =
el destinatario indicado, le informamos que cualquier forma de distribu=
ci=C3=B3n, reproducci=C3=B3n o uso de esta comunicaci=C3=B3n y/o de la =
informaci=C3=B3n contenida en la misma est=C3=A1n estrictamente prohibi=
dos por la ley. Si Ud. ha recibido esta comunicaci=C3=B3n por error, po=
r favor, notif=C3=ADquelo inmediatamente al remitente contestando a est=
e mensaje y proceda a continuaci=C3=B3n a destruirlo. Gracias por su co=
laboraci=C3=B3n.

This communication contains confidential information. It is for the exc=
lusive use of the intended addressee. If you are not the intended addre=
ssee, please note that any form of distribution, copying or use of this=
 communication or the information in it is strictly prohibited by law. =
If you have received this communication in error, please immediately no=
tify the sender by reply e-mail and destroy this message. Thank you for=
 your cooperation.=0D

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
