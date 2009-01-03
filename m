From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Sat, 03 Jan 2009 22:57:30 +0000
Message-ID: <495FED5A.5090102@linx.net>
References: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:39486 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760081AbZACW67 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Jan 2009 17:58:59 -0500
In-Reply-To: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: nokos@gmx.net, Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Peter Gruber wrote:
> Tested it on the S6410, and works as expected

On the subject of the S6410 (and S6420, which I have), I believe I can
simplify the backlight handling a *LOT*. Peter, to confirm that, could
you tell me whether you have ACPI_VIDEO (a kernel config option)
disabled? I'm hoping for a kernel configuration of:
# CONFIG_ACPI_VIDEO is not set

With ACPI_VIDEO disabled (a default on quite a lot of systems, as it
depends on video output switching) SBLL did indeed fail to update the
display brightness. Also, the display hotkeys failed to work. Events
were reported, but the "before" and "after" levels were always the same
value.

After loading ACPI_VIDEO, the hotkeys came to life. Also, after looking
at the DSDT I decided to specifically disable use_alt, causing the
driver to use SBLL & GBLL instead of SBL2 & GBLS.
Display brightness continued to be controllable. (And the Fujitsu laptop
driver continues to be useful, as backlight control methods are not
present on the ACPI video device)

So it seems to me that we should:
1) explicitly depend on ACPI_VIDEO through Kconfig
2) remove the use_alt framework

Regards,
Tony V.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklf7VoACgkQp5vW4rUFj5qXigCfSsDP38ochJ7i6X3/eFiZ3SP1
UqEAn28yGSYRBLmvWA3+vNhDSJ1ro5oS
=u1wO
-----END PGP SIGNATURE-----
