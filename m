From: Romano Giannetti <romanol@upcomillas.es>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on
	ToshibaSatellite A40
Date: Thu, 20 Sep 2007 18:59:42 +0200
Message-ID: <1190307582.16437.7.camel@rukbat>
References: <200709192014.08443.elendil@planet.nl>
	<20070920105312.GC12157@atrey.karlin.mff.cuni.cz>
	<200709201437.56431.elendil@planet.nl>  <46F29965.8030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757899AbXITQ77@vger.kernel.org>
In-Reply-To: <46F29965.8030603@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciek Rutecki <maciej.rutecki@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2007-09-20 at 18:01 +0200, Maciek Rutecki wrote:
> Frans Pop pisze:

> >> Unexpected, and potentially pretty serious. Something went wrong w=
ith
> >> ACPI. Can you try to narrow down when it started happening?
> >=0D
> > rc1 still had all 4 levels. I'll run a bisect between rc1 and rc6.
>=0D
> I have the same on HP/Compaq nx6310:
> ACPI: (supports S0 S3)
>=0D
> (kernel 2.6.23-rc6)

Linux version 2.6.20-16-generic (ubuntu):
ACPI: (supports S0 S3 S4 S5)

Linux version 2.6.23-rc2-rg (with a little snd-hda-intel patch)
ACPI: (supports S0 S3)

So it  seems  happened between rc1 and rc2

> But suspend to ram/disk works.

=46or me too (with s2ram, not with vanilla echo ram > ...). And the sys=
tem
is otherwise ok.

	Romano

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


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
