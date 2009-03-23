From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 17:37:52 +0100
Message-ID: <20090323163752.GC5463@gamma.logic.tuwien.ac.at>
References: <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090323123030.GC11430@gamma.logic.tuwien.ac.at> <20090323130457.GA2767@kamineko.org> <20090323153259.GA31191@gamma.logic.tuwien.ac.at> <20090323154332.GA24872@srcf.ucam.org> <20090323160052.GA2525@gamma.logic.tuwien.ac.at> <20090323160944.GA25882@srcf.ucam.org> <20090323162749.GA5463@gamma.logic.tuwien.ac.at> <20090323163056.GA26715@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:41111 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758612AbZCWQh4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 12:37:56 -0400
Content-Disposition: inline
In-Reply-To: <20090323163056.GA26715@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mo, 23 M=E4r 2009, Matthew Garrett wrote:
> Can you do one last thing and (with debugging enabled) try flicking t=
he=20
> rfkill switch, then let me know what event it generates?

Besides loads of remove foo bar stuff I get:

for turning from on to off:
sony-laptop: sony_acpi_notify, event: 0x93
sony-laptop: sony_laptop_report_input_event, event not known: 147
sony-laptop: unknown input event 93


for turning to from off to on
sony-laptop: sony_acpi_notify, event: 0x93
sony-laptop: sony_laptop_report_input_event, event not known: 147
sony-laptop: unknown input event 93


One more thing: Can you check the "Eject" button, I always forgot that
one (press-release):
sony-laptop: Unknown event: 90 9f
sony-laptop: sony_acpi_notify, event: 0x9f
sony-laptop: sony_laptop_report_input_event, event not known: 159
sony-laptop: unknown input event 9f
sony-laptop: Unknown event: 90 1f
sony-laptop: sony_acpi_notify, event: 0x1f

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
ABERYSTWYTH (n.)
A nostalgic yearning which is in itself more pleasant than the thing
being yearned for.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
