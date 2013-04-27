From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression] suspend is flakey, "shutdown -h now" does not power off
Date: Sat, 27 Apr 2013 17:09:59 +0200
Message-ID: <5985141.Edh9Qf6347@vostro.rjw.lan>
References: <4EC27F88.9070209@gmail.com> <2675056.KHaN45LQTO@vostro.rjw.lan> <517BE422.3040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46404 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab3D0PBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Apr 2013 11:01:49 -0400
In-Reply-To: <517BE422.3040408@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthieu Dubuget <matthieu.dubuget@gmail.com>
Cc: linux-acpi@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>

On Saturday, April 27, 2013 04:43:46 PM Matthieu Dubuget wrote:
>=20
> Le 27/04/2013 16:42, Rafael J. Wysocki a =C3=A9crit :
> >
> >  What's the newest kernel you tried?
> >
> >  Rafael
> >
> >
>=20
> Hello Rafael,
>=20
> It used to worked when I bought the computer. And I can check this
> with a live CD:
>=20
> * Ubuntu 2.6.32.41+drm33.18 (started from the Ubuntu 10.04.3 LTS live
>    CD)
>=20
> Since then, I tried:
>=20
> * Debian 3.0.0-6 (which is very close to upstream stable v3.0.8)
> * Debian 3.1.0-1~experimental.1 (which is basically linus's v3.1)
> * Debian 2.6.32-39 (close to longterm v2.6.32.43)
> * Ubuntu 3.0.0-12.20-generic (3.0.4 ? started from the Ubuntu live CD=
)
>=20
> * And this morning, I downloaded, compiled and ran 3.8.10 from
>    kernel.org without more success.

I see.

Did it ever worked with a kernel that's not from Ubuntu?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
