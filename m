From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.15.6][suspend] sleeping function called from invalid context on swsusp resume from STR
Date: Thu, 9 Mar 2006 12:50:50 +0100
Message-ID: <20060309115050.GA3167@elf.ucw.cz>
References: <200603090820.36867.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23250 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751824AbWCILvC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2006 06:51:02 -0500
Content-Disposition: inline
In-Reply-To: <200603090820.36867.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On =C4=8Ct 09-03-06 08:20:36, Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> I get this when resuming from swsup STR. I wonder if this may possibl=
y account=20
> for hard lockups I have been experiencing with acpi_cpufreq (see "Sys=
tem=20
> completely hangs using acpi_cpufreq").

This warning is known and harmless (just hard to fix nicely).
								Pavel
--=20
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted.=
=2E.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
