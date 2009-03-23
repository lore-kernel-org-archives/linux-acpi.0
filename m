From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 17:00:52 +0100
Message-ID: <20090323160052.GA2525@gamma.logic.tuwien.ac.at>
References: <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090323123030.GC11430@gamma.logic.tuwien.ac.at> <20090323130457.GA2767@kamineko.org> <20090323153259.GA31191@gamma.logic.tuwien.ac.at> <20090323154332.GA24872@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:45806 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759422AbZCWQBH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 12:01:07 -0400
Content-Disposition: inline
In-Reply-To: <20090323154332.GA24872@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mo, 23 M=E4r 2009, Matthew Garrett wrote:
> Interesting. These don't seem to match your earlier numbers, but inst=
ead=20
> look much more like the 0x92-style events. Do any of the other keys=20
> generate events? This one should be consistent with the events you're=
=20
> reporting.

With this patch I get:
S1
sony-laptop: Unknown event: 90 90
sony-laptop: sony_acpi_notify, event: 0x90
sony-laptop: sony_laptop_report_input_event, event not known: 144
sony-laptop: unknown input event 90
sony-laptop: sony_acpi_notify, event: 0x20

S2
sony-laptop: Unknown event: 90 91
sony-laptop: sony_acpi_notify, event: 0x91
sony-laptop: sony_laptop_report_input_event, event not known: 145
sony-laptop: unknown input event 91
sony-laptop: sony_acpi_notify, event: 0x20

=46n-F5
sony-laptop: sony_acpi_notify, event: 0x10
sony-laptop: sony_acpi_notify, event: 0x3b

=46n-F6
sony-laptop: sony_acpi_notify, event: 0x11
sony-laptop: sony_acpi_notify, event: 0x3b

=46n-F7
sony-laptop: sony_acpi_notify, event: 0x12
sony-laptop: sony_acpi_notify, event: 0x3b

=46n-F9
sony-laptop: sony_acpi_notify, event: 0x14
sony-laptop: sony_acpi_notify, event: 0x3b

=46n-F10
sony-laptop: sony_acpi_notify, event: 0x15
sony-laptop: sony_acpi_notify, event: 0x3b


and now also Fn-F5 and Fn-F6 do the right thing, i.e., adjust the
brightness, while S1 and S2 are doing nothing.

Thanks a lot and all the best

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
CLOVIS (q.v.)
One who actually looks forward to putting up the Christmas decorations
in the office.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
