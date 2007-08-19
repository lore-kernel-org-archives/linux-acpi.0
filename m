From: Maciek Rutecki <maciej.rutecki@gmail.com>
Subject: Re: SATA error while resume
Date: Sun, 19 Aug 2007 17:16:40 +0200
Message-ID: <46C85ED8.5080801@gmail.com>
References: <46C80999.1060700@gmail.com> <46C852DE.8040701@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <46C852DE.8040701@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, htejun@gmail.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Mark Lord pisze:

>=20
> Looks like a bad sector in the swap partition.
> You can probably repair it by using this sequence of commands:
>=20
> swapoff /dev/sdX    <--- replace sdX with actual swap partition dev n=
ame
> sync
> cat /dev/zero > /dev/sdX
> mkswap /dev/sdX
> swapon /dev/sdX
>=20
> If it recurs after doing that, then it's time for a new drive.
>=20
> -ml
> -

rutek:/home/maciek# swapoff /dev/sda6
rutek:/home/maciek# sync
rutek:/home/maciek# cat /dev/zero > /dev/sda6
cat: b=C5=82=C4=85d zapisu: B=C5=82=C4=85d wej=C5=9Bcia/wyj=C5=9Bcia (w=
rite error, after few minutes,
probably sda6 is full)

rutek:/home/maciek# dd if=3D/dev/zero of=3D/dev/sda6
dd: zapis do `/dev/sda6': B=C5=82=C4=85d wej=C5=9Bcia/wyj=C5=9Bcia
5992177+0 przeczytanych record=C3=B3w
5992176+0 zapisanych record=C3=B3w
skopiowane 3067994112 bajt=C3=B3w (3,1 GB), 298,159 sekund, 10,3 MB/s
rutek:/home/maciek# mkswap /dev/sda6
Setting up swapspace version 1, size =3D 3067990 kB
no label, UUID=3D2061df6e-d385-4367-9a4c-c8431e57b73a
rutek:/home/maciek# swapon /dev/sda6


dmesg:
Adding 2996080k swap on /dev/sda6.  Priority:-2 extents:1 across:299608=
0k

Also I try:
dd if=3D=3D/dev/sda... of=3D/dev/null for all partitions
Test disk with bios utility and smartctl. Use autotest (bash shared
mapping and disktest). No errors/warnings. Only (sometimes) while syste=
m
resume from suspend to disk. Disk 10 months old...

Regards
--=20
Maciej Rutecki
http://www.unixy.pl


