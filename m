From: Norbert Preining <preining@logic.at>
Subject: Re: Suspend2RAM Asus V6V
Date: Mon, 7 May 2007 00:58:24 +0200
Message-ID: <20070506225824.GA14463@gamma.logic.tuwien.ac.at>
References: <463BC369.7010309@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:44816 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbXEFW6Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 May 2007 18:58:25 -0400
Content-Disposition: inline
In-Reply-To: <463BC369.7010309@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Engel <j-engel@gmx.de>
Cc: linux-acpi@vger.kernel.org

Hi Johannes,

On Sam, 05 Mai 2007, Johannes Engel wrote:
> Switching the laptop on again hitting the power button (other buttons=
 do
> not show any effect) the cdrom drive gets initialised, the harddisk l=
ed
> gets switched on but the screen remains black and the laptop hangs
> completely (no keystroke accepted, even not Magic SysRq keys).

I have the same problem, and tried to debug it with net console, with
minimal kernel configs, with init=3D/bin/bash, with all the combination=
s,
to no avail. I did submit a bug report to the resepctive bug tracker bu=
t
it looks like nobody is caring for this kind of stuff.

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
DUDOO (n.)
The most deformed potato in any given collection of potatoes.
			--- Douglas Adams, The Meaning of Liff
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
