From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: should the resoltion of a closed lid of a docked ThinkPad be considered
Date: Mon, 26 Apr 2010 19:06:44 +0200
Message-ID: <201004261906.45251.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751210Ab0DZRHI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2010 13:07:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "linux-acpi@vger.kernel.org l" <linux-acpi@vger.kernel.org>, linux-video@atrey.karlin.mff.cuni.cz

Hello,

there's a different behaviour between 2.6.33.3 and 2.6.34-rc5 observed =
at a=20
ThinkPad T400 with intel graphic GM45 .

If it is docked and the lid is closed (1440x900) and an external DVI mo=
nitor=20
(1650x1080) is connected at the docking station - the dmesg of 2.6.33.3=
 gives:
	Console: switching to colour frame buffer device 210x65
whereas 2.6.34 gives:
	Console: switching to colour frame buffer device 180x56

=46urthermore X differs in the fact, that 2.6.33.3 sets the external mo=
nitor to=20
the expected resolution:
	(II) intel(0): Output HDMI2 using initial mode 1680x1050
whereas 2.6.34-rc5 sets it to the (unwanted) lower resolution :
	(II) intel(0): Output HDMI2 using initial mode 1440x900

Now I'm wondering whether this new behaviour is wanted - and if not - w=
hich=20
mailing list is the correct one ?

--=20
MfG/Sincerely
Toralf F=F6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
