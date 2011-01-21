From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: regression 2.6.37 -> 2.6.38-rc1: after suspend backlight
 cannot be adjusted
Date: Fri, 21 Jan 2011 05:11:47 +0100
Message-ID: <1295583107.2613.45.camel@edumazet-laptop>
References: <20110121015529.GD9796@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44370 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1AUELx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jan 2011 23:11:53 -0500
In-Reply-To: <20110121015529.GD9796@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Le vendredi 21 janvier 2011 =C3=A0 10:55 +0900, Norbert Preining a =C3=A9=
crit :
> Hi everyone,
>=20
> (please Cc)
>=20
> going to 2.6.38-rc1 I see the following regression: After reboot I
> can easily adjust the backlight with the keys on my keyboard, but=20
> after a suspend-to-ram this does not work anymore.
>=20
> This is a Sony laptop, and backlight is controlled by the video
> acpi driver AFAIR.
>=20

Hi Norbert

Maybe this is the problem Linus had to bisect, you could try his patch =
:

http://marc.info/?l=3Dlinux-netdev&m=3D129556877919576&w=3D2

Thanks !


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
