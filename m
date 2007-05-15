From: Norbert Preining <preining@logic.at>
Subject: Re: Suspend2RAM Asus V6V
Date: Tue, 15 May 2007 08:17:15 +0200
Message-ID: <20070515061715.GA19470@gamma.logic.tuwien.ac.at>
References: <463BC369.7010309@gmx.de> <20070506225824.GA14463@gamma.logic.tuwien.ac.at> <20070515004025.a4533bbd.j-engel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:53201 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758980AbXEOGRQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 May 2007 02:17:16 -0400
Content-Disposition: inline
In-Reply-To: <20070515004025.a4533bbd.j-engel@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Engel <j-engel@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Die, 15 Mai 2007, Johannes Engel wrote:
> Bios 0401 works quite well.
> BIOS >=3D1001 seems to introduce a bug: s2ram does not work any more.

Well I have an Acer TM 3012, but with more or less the same hardware, s=
o
I guess this won't help you. Could you dump and disassemble the two
DSDTs and compare them, maybe the difference between those also may be
found in the DSDT of the Acer.

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining@logic.at>                    Universit=E0=
 di Siena
Debian Developer <preining@debian.org>                         Debian T=
eX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
MELCOMBE REGIS (n.)
The name of the style of decoration used in cocktail lounges in mock
Tudor hotels in Surrey.
			--- Douglas Adams, The Meaning of Liff
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
