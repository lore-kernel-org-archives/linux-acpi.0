From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Sun, 04 Jan 2009 00:14:00 +0000
Message-ID: <495FFF48.7050709@linx.net>
References: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:39000 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067AbZADAP1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Jan 2009 19:15:27 -0500
In-Reply-To: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: nokos@gmx.net, Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jonathan Woithe wrote:
> I assume you're talking about the textual driver name as opposed to the
> module name ("fujitsu-laptop").  I have no immediate thoughts regarding
> this.  Personally I quite like the extended information the above output
> gives since you're left in no doubt where the driver comes from.

I would recommend fujitsu_brightness & fujitsu_hotkeys.
Short, to the point and it fits in with how pci_root in the same
directory is named.

I can combine that patch with the removal of the use_alt framework,
provided Peter gets back with a positive result. I would request that
the existing patch be applied to 2.6.29 as is so that the merge window
is not missed though.
If anything, that new patch can be applied on top.

> Regards
>   jonathan

Regards,
Tony V.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklf/0gACgkQp5vW4rUFj5qiugCeKIU0HDF3Wl14tyIlQJY9fdzT
nV4AoIX5XeHLvW90XrYErypKFj3HJe75
=+jrC
-----END PGP SIGNATURE-----
