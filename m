From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm2
Date: Mon, 21 Aug 2006 06:44:11 -0700
Message-ID: <20060821064411.20e61aa0.akpm@osdl.org>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<44E97AF9.2040009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:16775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030450AbWHUNoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 09:44:23 -0400
In-Reply-To: <44E97AF9.2040009@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 21 Aug 2006 11:20:57 +0200
Maciej Rutecki <maciej.rutecki@gmail.com> wrote:

> Andrew Morton napisa=C5=82(a):
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1=
8-rc4/2.6.18-rc4-mm2/
> >=20
> >=20
>=20
> I have this entry in dmesg:
>=20
> [   23.701949] ACPI Error (utglobal-0125): Unknown exception code:
> 0xFFFFFFEA [20060707]
> [   23.702181] ACPI Error (utglobal-0125): Unknown exception code:
> 0xFFFFFFEA [20060707]
> [   23.705646]   got res [dd000000:dd00ffff] bus [dd000000:dd00ffff]
> flags 7202 for BAR 6 of 0000:01:00.0
>=20
> When I try:
>=20
> cat standby > /sys/power/state
>=20
> graphics card doesn't go to standby, I had this text on console:
>=20
> [  280.908000] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
> [  280.920000] Suspending console(s)
>=20

Can you try reverting git-acpi.patch please?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
