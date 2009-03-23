From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Mon, 23 Mar 2009 13:29:46 +0100
Message-ID: <20090323122946.GB11430@gamma.logic.tuwien.ac.at>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:33017 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbZCWM3z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 08:29:55 -0400
Content-Disposition: inline
In-Reply-To: <20090322224652.GA13814@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

Hi Matthew,

On So, 22 M=E4r 2009, Matthew Garrett wrote:
> > - suddenly the sony-laptop module is convinced that the *hardware*
> >   rfkill switch is always turned on, always. Not even reloading an =
older
> >   sony-laptop helped. Rebooting neither. Shutting down and rebootin=
g
> >   with an older sony-laptop as default made wifi show up again.
> >   I am not sure if cold booting into the latest version of your pat=
ch
> >   will work, haven't tried till now, sorry, will do tomorrow.
>=20
> Hmm. Don't /think/ I did anything that should affect that, but it's=20
> possible. If it's reproducable, can you try commenting out the=20

=46orget it, as I said, I will retry cold booting and that made it work
without a problem.

> > - S1 and S2 do adjustment of the brightness, while Fn-F5 and Fn-F6 =
do
> >   not do anything, but this is probably only configuration stuff.
>=20
> Ok, sounds like the mapping needs to be changed. Can you let me know=20
> which ACPI events are generated for each key?

S1
	sony/hotkey SNC 00000001 00000090
	sony/hotkey SNC 00000001 00000010

S2
	sony/hotkey SNC 00000001 00000091
	sony/hotkey SNC 00000001 00000011
=46n-F5 (brightness -)
	sony/hotkey SNC 00000001 00000010
	sony/hotkey SNC 00000001 0000003b
=46n-F6 (brightness +)
	sony/hotkey SNC 00000001 00000011
	sony/hotkey SNC 00000001 0000003b
=46n-F7 (switch output mode)
	sony/hotkey SNC 00000001 00000012
	sony/hotkey SNC 00000001 0000003b
=46n-F9 (Zoom minus)
	sony/hotkey SNC 00000001 00000089
	sony/hotkey SNC 00000001 00000009
=46n-F10
	sony/hotkey SNC 00000001 00000015
	sony/hotkey SNC 00000001 0000003b
=46n-F12 (suspend to disk)
	(not sure about that, it actuallyDID suspend and I am not
	sure. At least NOW I know that S2D works ;-)
	sony/hotkey SNC 00000001 00000017
	sony/hotkey SNC 00000001 0000003b

Hope that helps

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
SHIFNAL (n.,vb.)
An awkward shuffling walk caused by two or more people in a hurry
accidentally getting into the same segment of revolving door. A
similar effect is achieved by people entering three-legged races
unwisely joined at the neck instead of the ankles.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
