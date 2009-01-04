From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Sun, 04 Jan 2009 20:44:07 +0000
Message-ID: <49611F97.6020601@linx.net>
References: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>	 <495FED5A.5090102@linx.net> <1231066111.10356.10.camel@earth.gruber.myown>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:47772 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbZADUpe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Jan 2009 15:45:34 -0500
In-Reply-To: <1231066111.10356.10.camel@earth.gruber.myown>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

nokos@gmx.net wrote:
> with ACPI_VIDEO:
> both alt and std interface works (SBLL/SBL2), but only while X is
> running (I think with ACPI_VIDEO all brighness change etc is handled by
> the IGD stuff in i915 which is only active if X is running)

Okay, perhaps kernel mode setting will improve this situation. As
userland isn't ready for KMS now I will back off on this and bring it up
again at around the 2.6.30/2.6.31 timeframe. (As I do agree things
should work correctly without X running)

> without ACPI_VIDEO: 
> only alt interface changes brightness and it works regardless of X

On the current interface though, mind if I remove the distinction
between GBLL & GBLS? The only difference between them (that you already
noticed, based on code comments) is that GBLS does not clear GHKS. GHKS
is the "change caused by brightness keys" flag.
As a result you already have to override use_alt in 1 case.

A simplier way to autodetect (taking into account your next mail about
BLNF) would then be to see whether SBL2 exists, and use if it does.
(I've checked all other DSDTs that I have, SBL2 is unique to the S64XX
series).

My ultimate goal in this is to make the DMI-based recognition of
machines unnecessary, especially if BTNI turns out to be useful in
knowing the keymap.

> Peter 

Regards,
Tony V.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklhH5cACgkQp5vW4rUFj5oSJwCfci3c42ogoUhi/Il99Oy8L3BV
07AAoK/qdg+NC35CyPH0H3b47H0VDecF
=xGab
-----END PGP SIGNATURE-----
