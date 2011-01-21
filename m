From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: regression 2.6.37 -> 2.6.38-rc1: after suspend backlight
 cannot be adjusted
Date: Fri, 21 Jan 2011 05:16:34 +0100
Message-ID: <1295583394.2613.47.camel@edumazet-laptop>
References: <20110121015529.GD9796@gamma.logic.tuwien.ac.at>
	 <1295583107.2613.45.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59415 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab1AUEQk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jan 2011 23:16:40 -0500
In-Reply-To: <1295583107.2613.45.camel@edumazet-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Le vendredi 21 janvier 2011 =C3=A0 05:11 +0100, Eric Dumazet a =C3=A9cr=
it :
> Le vendredi 21 janvier 2011 =C3=A0 10:55 +0900, Norbert Preining a =C3=
=A9crit :
> > Hi everyone,
> >=20
> > (please Cc)
> >=20
> > going to 2.6.38-rc1 I see the following regression: After reboot I
> > can easily adjust the backlight with the keys on my keyboard, but=20
> > after a suspend-to-ram this does not work anymore.
> >=20
> > This is a Sony laptop, and backlight is controlled by the video
> > acpi driver AFAIR.
> >=20
>=20
> Hi Norbert
>=20
> Maybe this is the problem Linus had to bisect, you could try his patc=
h :
>=20
> http://marc.info/?l=3Dlinux-netdev&m=3D129556877919576&w=3D2
>=20
> Thanks !
>=20

Or just pull linux-2.6, since patch is now committed

commit 28e58ee8ce1f0e69c207f747b7b9054b071e328d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jan 20 16:21:59 2011 -0800

    Fix broken "pipe: use event aware wakeups" optimization
   =20
    Commit e462c448fdc8 ("pipe: use event aware wakeups") optimized the=
 pipe
    event wakeup calls to avoid wakeups if the events do not match the
    requested set.
   =20
    However, the optimization was buggy, in that it didn't actually use=
 the
    correct sets for the events: when we make room for more data to be
    written, the pipe poll() routine will return both the POLLOUT _and_
    POLLWRNORM bits.  Similarly for read.
   =20
    And most critically, when a pipe is released, that will potentially
    result in POLLHUP|POLLERR (depending on whether it was the last rea=
der
    or writer), not just the regular POLLIN|POLLOUT.
   =20
    This bug showed itself as a hung gnome-screensaver-dialog process, =
stuck
    forever (or at least until it was poked by a signal or by being tra=
ced)
    in a poll() system call.
   =20
    Cc: Davide Libenzi <davidel@xmailserver.org>
    Cc: David S. Miller <davem@davemloft.net>
    Cc: Eric Dumazet <eric.dumazet@gmail.com>
    Cc: Jens Axboe <axboe@kernel.dk>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
