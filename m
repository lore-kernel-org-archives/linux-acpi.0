From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 22:04:57 +0900
Message-ID: <20090323130457.GA2767@kamineko.org>
References: <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090323123030.GC11430@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:37051
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZCWNFA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 09:05:00 -0400
Content-Disposition: inline
In-Reply-To: <20090323123030.GC11430@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mon, Mar 23, 2009 at 01:30:30PM +0100, Norbert Preining wrote:
> On Mo, 23 M=E4r 2009, Mattia Dongili wrote:
> > A vaio SR user sent me this list for 0x9c that after a call to SN07=
(202)
> > becomes:
> >=20
> > +       { 0x81, SONYPI_EVENT_MODEKEY_PRESSED },
> > +       { 0x01, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > +       { 0x82, SONYPI_EVENT_PKEY_P1 },
> > +       { 0x02, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > +       { 0x83, SONYPI_EVENT_PKEY_P2 },
> > +       { 0x03, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > +       { 0x84, SONYPI_EVENT_PKEY_P3 },
> > +       { 0x04, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > +       { 0x85, SONYPI_EVENT_PKEY_P4 },
> > +       { 0x05, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > +       { 0x86, SONYPI_EVENT_PKEY_P5 },
> > +       { 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > +       { 0x87, SONYPI_EVENT_SETTINGKEY_PRESSED },
> > +       { 0x07, SONYPI_EVENT_ANYBUTTON_RELEASED },
> > +       { 0, 0 },
>=20
> Couldn't test that since several SONYPI_EVENT* are not defined in
> current -rc8 plus Matthew patch. And I didn't want to try it out.=20

the above code was not meant to be tested. What you should do instead i=
s
changing the line (after Matthew's patch):
	if (ev =3D=3D 0x92 || ev =3D=3D 0x93) {
in sony_acpi_notify to
	if (ev =3D=3D 0x92 || ev =3D=3D 0x93 || ev =3D=3D 0x90) {
load the driver with debug=3D1 and press the unrecognized Fn keys.
You *should* get a bunch of "unknown input event XX" in the kernel log,
with those we can build the necessary mappings for your specific model
(hopefully not just yours).

--=20
mattia
:wq!
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
