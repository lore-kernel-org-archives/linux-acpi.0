From: nokos@gmx.net
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Sun, 04 Jan 2009 11:48:31 +0100
Message-ID: <1231066111.10356.10.camel@earth.gruber.myown>
References: <200901032237.n03MbfOf018915@mercury.physics.adelaide.edu.au>
	 <495FED5A.5090102@linx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:57020 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756926AbZADKsm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jan 2009 05:48:42 -0500
In-Reply-To: <495FED5A.5090102@linx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony@linx.net
Cc: Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi

I have done some testing:

with ACPI_VIDEO:

both alt and std interface works (SBLL/SBL2), but only while X is
running (I think with ACPI_VIDEO all brighness change etc is handled by
the IGD stuff in i915 which is only active if X is running)

without ACPI_VIDEO:

only alt interface changes brightness and it works regardless of X

In both cases events for the buttons are generated and it depends on if
hal/dbus and/or gnome-power-manager/kpower* is running if the the
brightness get actually changed.

Peter 



Am Samstag, den 03.01.2009, 22:57 +0000 schrieb Tony Vroon:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Peter Gruber wrote:
> > Tested it on the S6410, and works as expected
> 
> On the subject of the S6410 (and S6420, which I have), I believe I can
> simplify the backlight handling a *LOT*. Peter, to confirm that, could
> you tell me whether you have ACPI_VIDEO (a kernel config option)
> disabled? I'm hoping for a kernel configuration of:
> # CONFIG_ACPI_VIDEO is not set
> 
> With ACPI_VIDEO disabled (a default on quite a lot of systems, as it
> depends on video output switching) SBLL did indeed fail to update the
> display brightness. Also, the display hotkeys failed to work. Events
> were reported, but the "before" and "after" levels were always the same
> value.
> 
> After loading ACPI_VIDEO, the hotkeys came to life. Also, after looking
> at the DSDT I decided to specifically disable use_alt, causing the
> driver to use SBLL & GBLL instead of SBL2 & GBLS.
> Display brightness continued to be controllable. (And the Fujitsu laptop
> driver continues to be useful, as backlight control methods are not
> present on the ACPI video device)
> 
> So it seems to me that we should:
> 1) explicitly depend on ACPI_VIDEO through Kconfig

We also have to test if the ACPI_VIDEO scenario depends on DRM/DRM_I915
for the brightness handling and add a depend on those 

> 2) remove the use_alt framework
> 
> Regards,
> Tony V.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.9 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAklf7VoACgkQp5vW4rUFj5qXigCfSsDP38ochJ7i6X3/eFiZ3SP1
> UqEAn28yGSYRBLmvWA3+vNhDSJ1ro5oS
> =u1wO
> -----END PGP SIGNATURE-----

