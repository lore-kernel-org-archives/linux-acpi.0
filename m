From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 16:32:59 +0100
Message-ID: <20090323153259.GA31191@gamma.logic.tuwien.ac.at>
References: <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090323123030.GC11430@gamma.logic.tuwien.ac.at> <20090323130457.GA2767@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:56190 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbZCWPdO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 11:33:14 -0400
Content-Disposition: inline
In-Reply-To: <20090323145859.GA24358@srcf.ucam.org> <20090323122946.GB11430@gamma.logic.tuwien.ac.at> <20090323130457.GA2767@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

Hi you two,

On Mo, 23 M=E4r 2009, Matthew Garrett wrote:
> Ok, thanks. Can you try this instead of the other patches? I'm a touc=
h=20
> concerned about the release events on the S1 and S2 buttons looking l=
ike=20
> the events for some of the Fn keys, which may mean that we need to fi=
nd=20
> some way of distinguishing them.

I tried your patch together with Mattia's remark:

On Mo, 23 M=E4r 2009, Mattia Dongili wrote:
> the above code was not meant to be tested. What you should do instead=
 is
> changing the line (after Matthew's patch):
> 	if (ev =3D=3D 0x92 || ev =3D=3D 0x93) {
> in sony_acpi_notify to
> 	if (ev =3D=3D 0x92 || ev =3D=3D 0x93 || ev =3D=3D 0x90) {

and it works fine.

Regarding the key press events I did what Mattia said (loading with
debug=3D1): Some created an "Unknown event" in the log, some not.

S1:
sony-laptop: sony_acpi_notify, event: 0x20
sony-laptop: sony_acpi_notify, event: 0x10

S2:
sony-laptop: sony_acpi_notify, event: 0x20
sony-laptop: sony_acpi_notify, event: 0x11

=46n-F5 (brightness -)
sony-laptop: Unknown event: 90 85
sony-laptop: sony_acpi_notify, event: 0x85
sony-laptop: sony_laptop_report_input_event, event not known: 133
sony-laptop: unknown input event 85
sony-laptop: Unknown event: 90 5
sony-laptop: sony_acpi_notify, event: 0x05

=46n-F6 (brightness +)
sony-laptop: Unknown event: 90 86
sony-laptop: sony_acpi_notify, event: 0x86
sony-laptop: sony_laptop_report_input_event, event not known: 134
sony-laptop: unknown input event 86
sony-laptop: Unknown event: 90 6
sony-laptop: sony_acpi_notify, event: 0x06
sony-laptop: unknown input event 06

=46n-F7 (switch output mode)
sony-laptop: Unknown event: 90 87
sony-laptop: sony_acpi_notify, event: 0x87
sony-laptop: sony_laptop_report_input_event, event not known: 135
sony-laptop: unknown input event 87
sony-laptop: Unknown event: 90 7
sony-laptop: sony_acpi_notify, event: 0x07

=46n-F9 (Zoom minus)
sony-laptop: sony_acpi_notify, event: 0x14
sony-laptop: sony_acpi_notify, event: 0x3b

=46n-F10 (Zoom plus)
sony-laptop: Unknown event: 90 8a
sony-laptop: sony_acpi_notify, event: 0x8a
sony-laptop: sony_laptop_report_input_event, event not known: 138
sony-laptop: unknown input event 8a
sony-laptop: Unknown event: 90 a
sony-laptop: sony_acpi_notify, event: 0x0a



Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Te=
chnology
Debian Developer <preining@debian.org>                         Debian T=
eX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
LULWORTH (n.)
Measure of conversation. A lulworth defines the amount of the length,
loudness and embarrassment of a statement you make when everyone else
in the room unaccountably stops talking at the same time.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
