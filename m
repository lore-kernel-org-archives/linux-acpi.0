From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 17:18:49 +0100
Message-ID: <20090321161849.GA17906@gamma.logic.tuwien.ac.at>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320004043.GF19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:49985 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbZCUQTF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 12:19:05 -0400
Content-Disposition: inline
In-Reply-To: <200903211222.36642.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, sony-vaio-z-series@lists.launchpad.net, malattia@linux.it, linux-acpi@vger.kernel.org

Hi Matthias,

On Sa, 21 M=C3=A4r 2009, Matthias Welwarsky wrote:
> > Maybe Matthew can take a look and fix the compile warnings in funct=
ion
> > =E2=80=98sony_ovga_dsm=E2=80=99 (there are some!).
>=20
> Check the attached patch, it does away with the compile warnings. I'v=
e removed=20
> the warnings in functional code and put ifdefs (ugh!) around debug on=
ly code.=20
> You can just remove it if you don't like it, I'm only keeping it arou=
nd for=20
> reference.

Against which version of sony-laptop does it apply? Against kernel,
against kernel+Matthew, against yours, against kernel+Matthew+mine? I
couldn't find out ..

Thanks for taking a look into that

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
AFFPUDDLE (n.)
A puddle which is hidden under a pivoted paving stone. You only know
it's there when you step on the paving stone and the puddle shoots up
your leg.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
