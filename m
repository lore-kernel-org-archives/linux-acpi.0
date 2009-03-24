From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Tue, 24 Mar 2009 01:01:12 +0100
Message-ID: <20090324000112.GA15580@gamma.logic.tuwien.ac.at>
References: <20090323160052.GA2525@gamma.logic.tuwien.ac.at> <20090323160944.GA25882@srcf.ucam.org> <20090323162749.GA5463@gamma.logic.tuwien.ac.at> <20090323163056.GA26715@srcf.ucam.org> <20090323163752.GC5463@gamma.logic.tuwien.ac.at> <20090323164007.GA27023@srcf.ucam.org> <20090323164104.GE5463@gamma.logic.tuwien.ac.at> <20090323165157.GA27223@srcf.ucam.org> <20090323174834.GA13341@gamma.logic.tuwien.ac.at> <20090323195118.GA30693@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:37858 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZCXABj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 20:01:39 -0400
Content-Disposition: inline
In-Reply-To: <20090323195118.GA30693@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Mo, 23 M=E4r 2009, Matthew Garrett wrote:
> Ok, and here's what I consider to be the "final" version for now. It=20
> cleans up the event handling (it turns out that the event value=20

Tested, works as far as my tests go (kbds, rfkill on/off tests)

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
`In those days spirits were brave, the stakes were high,
men were REAL men, women were REAL women, and small furry
creatures from Alpha Centauri were REAL small furry
creatures from Aplha Centauri.'
                 --- The Book getting all nostalgic.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
