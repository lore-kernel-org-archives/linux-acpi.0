From: Tony Vroon <tony@vroon.org>
Subject: Re: Bluetooth driver vs RFKILL state LED
Date: Sun, 28 Dec 2008 13:43:03 +0000
Message-ID: <49578267.6020401@vroon.org>
References: <200812281224.41223.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganymede.vroon.org ([195.66.242.11]:46549 "EHLO
	ganymede.vroon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbYL1NzI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Dec 2008 08:55:08 -0500
In-Reply-To: <200812281224.41223.toralf.foerster@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Toralf F=F6rster wrote:
> I'm wondering why at my ThinkPad T41 the bluetooth LED is on even if =
I did not=20
> compiled bluetooth support into the kernel nor as module.

That LED indicates whether the Bluetooth radio is enabled (powered up,
it is a USB device). Consider it like a light socket. You don't have a
working bulb in there, but you can still switch the socket on & off.
You see the results of your switching the moment you screw in a working
lightbulb (load your Bluetooth driver).

It would in fact be a layering violation to care about whether or not a
Bluetooth driver is loaded when switching the radio on & off. If you
want your Bluetooth to start out off and remain off, you should set you=
r
BIOS up accordingly.

Regards,
Tony V.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklXgmcACgkQp5vW4rUFj5qL8ACeO8mw7Fl5qy5PC0NtqeBkE2Ti
aEEAnRUo1NcZsM3wt9rBW+m/M4UD05Pf
=3DmNiX
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
