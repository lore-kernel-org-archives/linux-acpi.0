From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sun, 22 Mar 2009 23:06:55 +0100
Message-ID: <20090322220655.GA13887@gamma.logic.tuwien.ac.at>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:33256 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbZCVWHL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 18:07:11 -0400
Content-Disposition: inline
In-Reply-To: <20090322203740.GA12285@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On So, 22 M=E4r 2009, Matthew Garrett wrote:
> > sony/hotkey SNC 00000001 00000090
> > sony/hotkey SNC 00000001 00000090
>=20
> Hm. Try changing 0x93 to 0x90 in the notify handler.

That did the trick, now different syms are reported.

BUT:
- suddenly the sony-laptop module is convinced that the *hardware*
  rfkill switch is always turned on, always. Not even reloading an olde=
r
  sony-laptop helped. Rebooting neither. Shutting down and rebooting
  with an older sony-laptop as default made wifi show up again.
  I am not sure if cold booting into the latest version of your patch
  will work, haven't tried till now, sorry, will do tomorrow.

- S1 and S2 do adjustment of the brightness, while Fn-F5 and Fn-F6 do
  not do anything, but this is probably only configuration stuff.

Thanks as usual

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
TROSSACHS (pl.n.) The useless epaulettes on an expensive raincoat.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
