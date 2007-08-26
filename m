From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: C3 issues w/ Abit KT7
Date: Sun, 26 Aug 2007 20:10:09 +0300
Message-ID: <20070826171009.GA5827@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:36771 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941AbXHZR3H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Aug 2007 13:29:07 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm having stability issues w/ C3 on Abit KT7 (VIA KT133).

Older kernels simply refused to enter C3 on this mobo due to missing
BM control. Now I'm running 2.6.23-rc1 and noticed that C3 was offered
but never actually entered after the boot. After rmmoding the culprit
(ati_remote2) C3 was entered but after a while the system froze totally=
=2E

I've been doing some investigations on this issue and now it looks like
BM_STS is broken wrt. real PCI masters. I can see BM activity when
something is connected to the integrated UHCI controller or when doing
disk access with the integrated PATA controller, but I see no BM
activity being reported when using PCI network card or connecting the
ati_remote2 to PCI EHCI controller. If I keep the ati_remote2 connected
to the UHCI and then do some heavy network activity BM activity does
seem
to include the network BM as well (BM activity stays near 0xffffffff
instead of the more typical 0x11111111 when just ati_remote2 is in use)=
,
but if I remove ati_remote2 bm activity stays at 0x0000000 despite any
network activity. I even tried swapping the PCI slot of the network car=
d
to see if that would help - it didn't.

To me it looks like broken hw, but I can't be sure if it's just my
particular mobo or the whole Abit KT7 line. I have done some soldering
on mine (bad capacitors) so it is possible I've managed to break it
myself. If it's the whole KT7 line then I guess we'd need some kind of
C3 black list. Is there anyone else still using an Abit KT7 who would b=
e
willing double check my findings?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
