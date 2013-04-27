From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression] suspend is flakey, "shutdown -h now" does not power off
Date: Sat, 27 Apr 2013 22:12:57 +0200
Message-ID: <15552608.yopBJFHLkP@vostro.rjw.lan>
References: <4EC27F88.9070209@gmail.com> <5985141.Edh9Qf6347@vostro.rjw.lan> <517BEBD5.6050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46783 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092Ab3D0UEr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Apr 2013 16:04:47 -0400
In-Reply-To: <517BEBD5.6050301@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu.dubuget@gmail.com
Cc: linux-acpi@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>

On Saturday, April 27, 2013 05:16:37 PM Matthieu Dubuget wrote:
> Le 27/04/2013 17:09, Rafael J. Wysocki a =C3=A9crit :
> > Did it ever worked with a kernel that's not from Ubuntu?
>=20
> I do not know=E2=80=A6 You suggest that I shourd find a =C2=AB pure =C2=
=BB
> kernel that is working, around 2.6.30 version?

Yes.  Basically, I'd like to know if the fact that it worked was due to=
 an
Ubuntu patch or something we did in the mainline that changed.

Also, it would be good to know what the failing hardware is.

> I'll come back when/if I will have found one.

Thanks!

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
