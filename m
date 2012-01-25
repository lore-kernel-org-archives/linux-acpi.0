From: joeyli <jlee@suse.com>
Subject: Re: Fwd: [Bugreport] Screen backllight issues on FirePro M5950 (HP
 EliteBook 8560w)
Date: Wed, 25 Jan 2012 09:52:34 +0800
Message-ID: <1327456354.15260.1.camel@linux-s257.site>
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
	 <1327276502.15960.150.camel@linux-s257.site>
	 <CAEPe-G+jNsa5VScrk-Nii2e=0U5bVWtcCT5apOy0BAJrjKri4Q@mail.gmail.com>
	 <1327366720.7090.7.camel@linux-s257.site>
	 <CAEPe-GLe9d7V9YLq+gGpb8N+a-9ELzeuvLbr=gKFbWU4JJxV-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:42268 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2AZC03 (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
	Wed, 25 Jan 2012 21:26:29 -0500
In-Reply-To: <CAEPe-GLe9d7V9YLq+gGpb8N+a-9ELzeuvLbr=gKFbWU4JJxV-Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Artur Flinta <aflinta@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

=E6=96=BC =E4=BA=8C=EF=BC=8C2012-01-24 =E6=96=BC 16:25 +0100=EF=BC=8CAr=
tur Flinta =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi!
>=20
> > Thanks, but looks like your kernel didn't enable
> >        CONFIG_ACPI_DEBUG=3Dy
> >
> > So, doesn't show up any acpi debug log in messages.
>=20
> Fixed, now using kernel-debug package ;) Quite huge in attachment.
>=20

I just found the _BCM in your SSDT3 table, I am tracing it:

            Method (_BCM, 1, Serialized)
            {
                Store (\_SB.BCM, Arg0)
                Local0
                If (Local0)
                {
                    Store (BRID, Local1)
                    If (LEqual (SBRV (), 0x00))
                    {
                        \_SB.SSMI (0xEA74, 0x04, Local1, 0x00, 0x00)
                    }

                    Signal (\_SB.BEVT)
                }
            }

> > Does it work set backlight level by sysfs?
> >        echo 9 > /sys/class/backlight/acpi_video0/brightness
>=20
> if kernel is booted with acpi_backlight=3Dvendor parameter, then ther=
e
> are no entries in  /sys/class/backlight directory.
>=20

OH! you are right, sorry I forgot it.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
