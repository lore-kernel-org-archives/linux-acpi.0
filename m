From: Norbert Preining <preining@logic.at>
Subject: Re: Huu, 2.6.25-rc6 and my battery is gone ...
Date: Thu, 20 Mar 2008 16:07:41 +0100
Message-ID: <20080320150741.GA4609@gamma.logic.tuwien.ac.at>
References: <20080320084239.GB17435@gamma.logic.tuwien.ac.at> <200803201049.43600.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:52674 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbYCTPUO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2008 11:20:14 -0400
Content-Disposition: inline
In-Reply-To: <200803201049.43600.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

On Do, 20 M=E4r 2008, Rafael J. Wysocki wrote:
> > I recently switched from 2.6.25-rc3 to -rc6 and now my battery is g=
one.
> > gnome-power-guru does show permanent AC plugged in, the acpi comman=
d
> > returns nothing:
[...]
> > Is this a know issue?
>=20
> Probably.
>=20
> Please test -rc6-git4 and see if the problem is gone.

Confirmed. -rc6-git4 fixes this problem. Thanks.

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
CAARNDUNCAN (n.)
The high-pitched and insistent cry of the young female human urging
one of its peer group to do something dangerous on a cliff-edge or
piece of toxic waste ground.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
