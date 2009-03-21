From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 17:51:00 +0100
Message-ID: <20090321165100.GB20271@gamma.logic.tuwien.ac.at>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090321144521.GA21615@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:59552 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbZCUQvO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 12:51:14 -0400
Content-Disposition: inline
In-Reply-To: <20090321144521.GA21615@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sa, 21 M=E4r 2009, Mattia Dongili wrote:
> > The new init sequence for SN07 also enables all the special keys, e=
ven the=20
> > speed/stamina switch now generates an ACPI event, as well as S1, S2=
 and Eject.=20
> > But you cannot distinguish them, they all report the same event.
>=20
> You mey need the additional SN07 call to get the actual key press, se=
e
> the code in sony_acpi_notify.

Hey that would be phantastic to have the keys working, please!

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
DUNBOYNE (n.)
The moment of realisation that the train you have just patiently
watched pulling out of the station was the one you were meant to be
on.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
