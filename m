From: Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: Suspend to RAM works, but no wake up. ATI Technologies
	Inc Rage Mobility P/M (rev 64) video card
Date: Sun, 26 Jun 2005 10:41:56 +0200
Message-ID: <1119775316.19781.13.camel@sponge.fungus>
References: <20050626095708.3649fdff.linux@celifornia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pW65XBbU1W3ipY0VimS8"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050626095708.3649fdff.linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-pW65XBbU1W3ipY0VimS8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-06-26 at 09:57 +0200, Benedek Frank wrote:
> When I use this option, it does wake up when I hit a key. However, while
> asleep, the screen isnt completely off. I can hear a buzzing sound,
> very soflty, but I can definetally hear it. Also, when I open the
> lid, (it wont wake up yet, only on button press) I can see some text on
> the screen if I tilt it in the right angle. THe LCD seems off, but it
> does has some text on it, so it cannot be off, just dimmed to a maximum.
> ANd the buzzing sound gives it also away. I left the machine suspended
> at 33% battery yesterday at 2AM, and by 7AM when I woke up, the battery
> was dead, and the laptop shut down. Usually 33% gives me 40 mintues of
> work time, I think it should have lasted for a 5 hours suspension, no?

I have an IBM ThinkPad X31 (2672-XXH), also with a ATI Radeon (ATI
Technologies Inc Radeon Mobility M6 LY).

While I do not get the high pitched noise, I do see the problem with the
LCD backlight not powering off during S3. I have to use radeontool [1]
to power off the LCD backlight before going into S3 and reverse this
procedure when the laptop wakes up from S3.

Perhaps the in-kernel radeonfb driver could be modified to allow
powering down the LCD backlight before entering S3?

Sincerely,
Brix
[1]: http://fdd.com/software/radeon/
--=20
Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Gentoo Metadistribution | Mobile computing herd

--=-pW65XBbU1W3ipY0VimS8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCvmpUv+Q4flTiePgRAlJeAJ9krfLM47LUtsomFPi0Qc0c33aoXgCgnJai
1BFAsPh60RqCKh+b1gxYSSQ=
=lEWJ
-----END PGP SIGNATURE-----

--=-pW65XBbU1W3ipY0VimS8--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
