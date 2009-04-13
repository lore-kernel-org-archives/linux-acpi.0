From: Norbert Preining <preining@logic.at>
Subject: Re: new fixes for sony-acpi
Date: Mon, 13 Apr 2009 17:03:02 +0200
Message-ID: <20090413150302.GC2332@gamma.logic.tuwien.ac.at>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain> <20090328013832.GA4778@srcf.ucam.org> <20090328083315.GF9057@gamma.logic.tuwien.ac.at> <20090328120008.GA22470@srcf.ucam.org> <20090331152035.GA20946@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:57838 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZDMPDX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2009 11:03:23 -0400
Content-Disposition: inline
In-Reply-To: <20090331152035.GA20946@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, sony-vaio-z-series@lists.launchpad.net, Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

Hi all,

(back from mountains and destroyed laptop)

On Di, 31 M=E4r 2009, Matthew Garrett wrote:
> It's a module that loads, checks what state the firmware thinks the=20
> hardware is in and then ensures that the hardware is actually in that=
=20
> state. I believe that it gets the choice between internal and discret=
e=20
> GPUs correct. It doesn't support runtime switching right now since=20
> there's no way to do anything useful with it, but it's a trivial sysf=
s=20
> attribute.

I tested it the following way:
- 2.6.29
- all patches from Mattia send for rc1 and rc2
- the module from your email
- boot and start x as ususal
- *after* starting X I loaded the module

Output:
[ 2120.435908] nvidia-control: hardware status gave 0x801f
and it seems that the Stamina LED did light up (I don't remeber whether
it was on before).

Anything else I can test?

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
BALLYCUMBER
One of the six half-read books lying somewhere in your bed.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
