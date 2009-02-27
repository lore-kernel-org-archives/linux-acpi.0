From: Charles@schwieters.org
Subject: Re: experimental patch for toshiba_acpi
Date: Fri, 27 Feb 2009 16:31:59 -0500
Message-ID: <E1LdAJL-0003Jk-EQ@tan.cit.nih.gov>
References: <200902280015.17286.arvidjaar@mail.ru>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailfwd.nih.gov ([128.231.90.107]:11162 "EHLO
	nihrelayxway2.hub.nih.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519AbZB0VcE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Feb 2009 16:32:04 -0500
In-reply-to: <200902280015.17286.arvidjaar@mail.ru> 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Charles@schwieters.org, linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hello Andrey--

> >This patch comes from http://memebeam.org/free-software/toshiba_acpi/.
> >With this patch, the module conflicts with the toshiba module (which
> >works only on non-acpi-enabled kernels).
> 
> Could you please elaborate? Because (Portege 4000):
> 
> {pts/2}% lsmod | grep tosh
> toshiba                 4012  0
> toshiba_acpi            7540  0
> rfkill                 10480  1 toshiba_acpi
> backlight               4560  2 toshiba_acpi,video
> input_polldev           4012  1 toshiba_acpi
> {pts/2}% sudo fan
> Fan is on.
> 

My understanding is that with the experimental patch, both toshiba and
toshiba_acpi use /dev/toshiba. Do you have the experimental patch
applied? Does fan work if you remove the toshiba module?

Charles
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFJqFvPPK2zrJwS/lYRApaPAJwK7jbkxT070MBKm+TyWI9/gEO89wCfS4sy
iukYMH2E2g9UiQ2EB+YIaAE=
=AFBQ
-----END PGP SIGNATURE-----
