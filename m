From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Thu, 19 Mar 2009 22:49:14 +0100
Message-ID: <20090319214914.GN29624@gamma.logic.tuwien.ac.at>
References: <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at> <20090319214437.GB24898@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:49718 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbZCSVtT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 17:49:19 -0400
Content-Disposition: inline
In-Reply-To: <20090319214437.GB24898@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Do, 19 M=E4r 2009, Matthew Garrett wrote:
> Sigh. I could have saved some amount of time if these patches had=20
> actually been sent to the mailing list. They're functionally equivale=
nt,=20

Umpf, bad.

> except mine integrate with the rfkill class correctly and check wheth=
er=20
> the hardware is present before creating the rfkill device.

I found that out only recently that there is this module floating
around.

Ok, I will give your patches a testing spin on my Vaio Z11.

One question: Should I apply the patches Mattia posted some time ago=20
(9 of them if I remember correctly) and your patch on top of them, or
apply your patch to current -rc8?

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
DITHERINGTON (n)
Sudden access to panic experienced by one who realises that he is
being drawn inexorably into a clabby (q.v.) conversation, i.e. one he
has no hope of enjoying, benefiting from or understanding.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
