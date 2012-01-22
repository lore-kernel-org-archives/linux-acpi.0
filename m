From: joeyli <jlee@suse.com>
Subject: Re: Fwd: [Bugreport] Screen backllight issues on FirePro M5950 (HP
 EliteBook 8560w)
Date: Mon, 23 Jan 2012 07:55:02 +0800
Message-ID: <1327276502.15960.150.camel@linux-s257.site>
References: <CAEPe-G+b9U-vdDmU29=GjyABab=5-MzWm4U6pBj1upRgLjH1OQ@mail.gmail.com>
	 <CAGB3EUR750VpHdvrZ25mn9bcS-4ZT+BSJ_zD4-sRncyYNT=0Zg@mail.gmail.com>
	 <1323442460.20114.95.camel@linux-s257.site>
	 <CAEPe-G+iooX_BOD=5m1nMgn+t63XGsLR+4JCfvHKOyTx98qydg@mail.gmail.com>
	 <1324443308.10394.456.camel@linux-s257.site>
	 <CAEPe-GLzak+SG3-H4Sw8KsQmpsh-v0UJWfHQb7hXoycO0GoWTA@mail.gmail.com>
	 <1327030553.15960.92.camel@linux-s257.site>
	 <CAEPe-G+H6CDDzg9-fXZK4MJbKw_-MJFSMheCL9=yN4Gt=fmaTQ@mail.gmail.com>
	 <1327196727.15960.118.camel@linux-s257.site>
	 <CAEPe-GKff7y1g4qc5gSz4vuhz5P0XpGgPTO570YzkjO6AZNV4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:36156 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab2AVX7E (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Sun, 22 Jan 2012 18:59:04 -0500
In-Reply-To: <CAEPe-GKff7y1g4qc5gSz4vuhz5P0XpGgPTO570YzkjO6AZNV4A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Artur Flinta <aflinta@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

=E6=96=BC =E6=97=A5=EF=BC=8C2012-01-22 =E6=96=BC 14:17 +0100=EF=BC=8CAr=
tur Flinta =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Joey!
>=20
> > #define KEY_BRIGHTNESSDOWN      224
> > #define KEY_BRIGHTNESSUP        225
> >
> > Suggest you can try to run the following command before run X-windo=
ws:
> >
> > setkeycodes e054 224
> > setkeycodes e04c 225
>=20
> I've run above commands (setkeycodes), and started X-window, then
> pressed several times brightness keys... and noticed something like
> this in dmesg:
>=20
> [107404.053624] pkexec[11999]: aflinta: Executing command [USER=3Droo=
t]
> [TTY=3Dunknown] [CWD=3D/home/aflinta]
> [COMMAND=3D/usr/libexec/gsd-backlight-helper --set-brightness 5]
> [107405.449578] pkexec[12003]: pam_systemd(polkit-1:session): Failed
> to create session: Invalid argument
> [107405.450971] pkexec[12003]: aflinta: Executing command [USER=3Droo=
t]
> [TTY=3Dunknown] [CWD=3D/home/aflinta]
> [COMMAND=3D/usr/libexec/gsd-backlight-helper --set-brightness 6]
> [107405.923167] pkexec[12011]: pam_systemd(polkit-1:session): Failed
> to create session: Invalid argument
> [107405.924625] pkexec[12011]: aflinta: Executing command [USER=3Droo=
t]
> [TTY=3Dunknown] [CWD=3D/home/aflinta]
> [COMMAND=3D/usr/libexec/gsd-backlight-helper --set-brightness 4]
> [107406.197956] pkexec[12019]: pam_unix(polkit-1:session): session
> opened for user root by (uid=3D1000)
> [107406.199010] pkexec[12019]: aflinta: Executing command [USER=3Droo=
t]
> [TTY=3Dunknown] [CWD=3D/home/aflinta]
> [COMMAND=3D/usr/libexec/gsd-backlight-helper --set-brightness 2]
>=20
> But brightness haven't changed. I think that this is quite similar to
> my first tries to directly write brightness value to

Yes, you are right. At least we fix the hotkey event problem.

> /sys/class/backlight/acpi_video0/brightness (as described in my first
> post) - but without any success.
>=20

Yes! we still need fix the problem with backlight control. Please kindl=
y
give me the result after add the following debug parameter:
	acpi.debug_level=3D0xF acpi.debug_layer=3D0xFFFFFFFF log_buf_len=3D5M

And,=20
Did you try the following kernel parameter?
	acpi_backlight=3Dvendor

Please try it!
There has a write brightness command 0x06 in WHCM method, WHCM call by
WMAA.
I think might need implement 0x06 command support in hp-wmi.c,
currently, I didn't see it.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
