From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: 2.6.23-rc3-mm1
Date: Mon, 27 Aug 2007 15:35:35 +0200
Message-ID: <46D2D327.6040307@imap.cc>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>	<46CF695D.1020008@imap.cc>	<20070824170702.a2c51084.akpm@linux-foundation.org>	<653FFBB4508B9042B5D43DC9E18836F5014D954E@scsmsx415.amr.corp.intel.com>	<653FFBB4508B9042B5D43DC9E18836F5014D956A@scsmsx415.amr.corp.intel.com>	<46D0BA9D.1080708@imap.cc> <20070825165701.8423f5e6.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig66CAB4E014047B70F6E776D0"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756366AbXH0Nh2@vger.kernel.org>
In-Reply-To: <20070825165701.8423f5e6.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>, Thomas Renninger <trenn@suse.de>, Adam Belay <abelay@novell.com>
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66CAB4E014047B70F6E776D0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 26.08.2007 01:57 schrieb Randy Dunlap:
> On Sun, 26 Aug 2007 01:26:21 +0200 Tilman Schmidt wrote:
>=20
>> Am 25.08.2007 02:38 schrieb Pallipadi, Venkatesh:
>> >=20
>> > Tilman: Can you configure CONFIG_CPU_IDLE in your config (under Powe=
r
>> > Management option) and double check that the frequency part works af=
ter
>> > that.
>>=20
>> Strangely enough, I do not see that option in "make xconfig".
>> The "Power Management" subtree ends with "CPU Frequency scaling".
>> In "make menuconfig" the option is there, though.
>=20
> That sounds strange.  Please share your .config file.

I'm sorry but I cannot reproduce the phenomenon anymore. After setting
CONFIG_CPU_IDLE with "make menuconfig", when I ran "make xconfig" again
it showed the option too. Moving .config.old back to .config doesn't
make it disappear again. So it seems "make menuconfig" has elliminated
whatever caused this.

If you still want to have a look, both .config and .config.old are
available at http://gollum.phnxsoft.com/~ts/2.6.23-rc3-mm1/ .

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig66CAB4E014047B70F6E776D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG0tMnQ3+did9BuFsRAuDKAJ49weU/Xc4BsFtPNeibgRLJTiLSxwCfUkn6
FzmvYw7iDGLl7kDiiuHjTJ0=
=TXB+
-----END PGP SIGNATURE-----

--------------enig66CAB4E014047B70F6E776D0--
