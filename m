From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 13:30:30 +0100
Message-ID: <20090323123030.GC11430@gamma.logic.tuwien.ac.at>
References: <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:41784 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbZCWMaf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 08:30:35 -0400
Content-Disposition: inline
In-Reply-To: <20090322231029.GC17905@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mo, 23 M=E4r 2009, Mattia Dongili wrote:
> A vaio SR user sent me this list for 0x9c that after a call to SN07(2=
02)
> becomes:
>=20
> +       { 0x81, SONYPI_EVENT_MODEKEY_PRESSED },
> +       { 0x01, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +       { 0x82, SONYPI_EVENT_PKEY_P1 },
> +       { 0x02, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +       { 0x83, SONYPI_EVENT_PKEY_P2 },
> +       { 0x03, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +       { 0x84, SONYPI_EVENT_PKEY_P3 },
> +       { 0x04, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +       { 0x85, SONYPI_EVENT_PKEY_P4 },
> +       { 0x05, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +       { 0x86, SONYPI_EVENT_PKEY_P5 },
> +       { 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +       { 0x87, SONYPI_EVENT_SETTINGKEY_PRESSED },
> +       { 0x07, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +       { 0, 0 },

Couldn't test that since several SONYPI_EVENT* are not defined in
current -rc8 plus Matthew patch. And I didn't want to try it out.=20

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
BABWORTH
Something which justifies having a really good cry.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
