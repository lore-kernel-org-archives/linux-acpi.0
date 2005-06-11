From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Sony Vaio PCG-C1VRX/K Picturebook, Suspend to Ram works, but has a strange effect on the idle display
Date: Sat, 11 Jun 2005 16:41:19 +0200
Message-ID: <20050611144119.GA1763@elf.ucw.cz>
References: <200506102038.31928.linux@celifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200506102038.31928.linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> I finally got my Suspend to RAM working with my Picturebook. If interes=
ted=20
> how, please go to
>=20
> www.celifornia.com/documents/sonyvaio.html
>=20
> But I have got one problem. If I try the suspend with the 2.6.11 kernel=
 that I=20
> have, it wil do it beautifuly, but it will not resume from suspend no m=
atter=20
> what I do. I find it googling, that I need to pass a special boot param=
eter=20
> with Grub, that looks like this
>=20
> acpi_sleep=3Ds3_bios
>=20
>=20
> After all my Grub entry looks like this:
>=20
> title =A0 =A0 =A0 =A0 =A0 Debian GNU/Linux, kernel 2.6.11
> root =A0 =A0 =A0 =A0 =A0 =A0(hd0,1)
> kernel =A0 =A0 =A0 =A0 =A0/boot/vmlinuz-2.6.11 root=3D/dev/hda2 ro acpi=
_sleep=3Ds3_bios
> initrd =A0 =A0 =A0 =A0 =A0/boot/initrd.img-2.6.11
> savedefault
> boot
>=20
> Now, I can suspend and resume with the script I wrote for it, but even =
while=20
> suspended, the screen wont turn 100% off. If I tilt in in a way, about=20
> 160degree angle, I can see some text on the screen. Of course I can bar=
ely=20
> see it, but I can for Christ`s sake, while it should be off. For an=20
> "untrained" eye it seems the screen is black of course, but I got suspi=
cious=20
> after a few days of being able to suspend, as the laptop wasnt 100% qui=
et.=20
> The screen is making a little, very very little scratching noise, that =
I=20
> cannot really describe its more like an "electric" noise. Its bugging m=
e, as=20
> it must be using some of my battery, while it should not be using anyth=
ing=20
> other than what the RAM needs to not loose its stored memory.
>=20
> Thanks for helping, and let me know if you need any other log or files =
from my=20
> lappy.

Well, you'll need to write low-level support for sleeping your video
card/panel. Good luck.
								Pavel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
