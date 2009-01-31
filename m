From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2009-01-28-02-17 uploaded - docking station issues.
Date: Fri, 30 Jan 2009 21:03:52 -0800
Message-ID: <20090130210352.cf9e4d7f.akpm@linux-foundation.org>
References: <200901281019.n0SAJ9C6013727@imap1.linux-foundation.org>
	<20830.1233246343@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38284 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750715AbZAaFD7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Jan 2009 00:03:59 -0500
In-Reply-To: <20830.1233246343@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org

On Thu, 29 Jan 2009 11:25:43 -0500 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 28 Jan 2009 02:19:09 PST, akpm@linux-foundation.org said:
> > The mm-of-the-moment snapshot 2009-01-28-02-17 has been uploaded to
> >=20
> >    http://userweb.kernel.org/~akpm/mmotm/
>=20
> % ls -l /sys/devices/platform/dock.0/docked
> -r--r--r-- 1 root root 4096 2009-01-29 10:49 /sys/devices/platform/do=
ck.0/docked
> % cat /sys/devices/platform/dock.0/docked
> =F1=DEcat: write error: Bad address
>=20
> strace of the cat shows:
>=20
> open("/sys/devices/platform/dock.0/docked", O_RDONLY) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0444, st_size=3D4096, ...}) =3D 0
> read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0"..., 4096) =3D 1812586496
>=20
> Under 2.6.29-rc2-mmotm0116, this would return either "0" or "1", not =
4K
> of nulls.
>=20

Is it due to=20

acpi-dock-dont-eval-_sta-on-every-show_docked-sysfs-read.patch

and/or

acpi-dock-dont-eval-_sta-on-every-show_docked-sysfs-read-simplification=
=2Epatch

?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
