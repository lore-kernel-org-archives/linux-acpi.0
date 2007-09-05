From: Tilman Schmidt <tilman@imap.cc>
Subject: Clock trouble retest results with 2.6.23-rc4-mm1 (was: 2.6.23-rc3-mm1)
Date: Wed, 05 Sep 2007 22:41:37 +0200
Message-ID: <46DF1481.2040604@imap.cc>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org>	<46CF695D.1020008@imap.cc>	<20070824170702.a2c51084.akpm@linux-foundation.org>	<46CF7C3F.10707@imap.cc> <20070824203000.1d710cee.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3878310B1CFA5DAC0A011849"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50315 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756784AbXIEUlI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Sep 2007 16:41:08 -0400
In-Reply-To: <20070824203000.1d710cee.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>, Thomas Renninger <trenn@suse.de>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3878310B1CFA5DAC0A011849
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 25.08.2007 05:30 schrieb Andrew Morton:
> On Sat, 25 Aug 2007 02:47:59 +0200 Tilman Schmidt <tilman@imap.cc> wrot=
e:

>>>> - on console early during boot, also in SuSE's /var/log/boot.msg:
>>>>
>>>> your system time is not correct:
>>>> Wed Jul 13 13:15:31 UTC 1910
>>>> setting system time to:
>>>> Tue Jul 24 00:00:00 UTC 2007

With 2.6.23-rc4-mm1 this doesn't happen anymore,
so whatever it was seems to be fixed.

>> --- /tmp/bootmsg-2.6.23-rc3	2007-08-25 02:25:54.000000000 +0200
>> +++ /tmp/bootmsg-2.6.23-rc3-mm1	2007-08-25 02:26:08.000000000 +0200
[...]
>>  <6>..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
>> -<6>checking TSC synchronization [CPU#0 -> CPU#1]: passed.
>> +<6>checking TSC synchronization [CPU#0 -> CPU#1]:
>> +<4>Measured 32 cycles TSC warp between CPUs, turning off TSC clock.
>> +<4>Marking TSC unstable due to: check_tsc_sync_source failed.

This still happens identically with 2.6.23-rc4-mm1.
Mainline kernels like my TSC, -mm kernels don't.

>> -<7>hpet_resources: 0xfed00000 is busy
>> +<4>hpet_acpi_add: no address or irqs in _CRS
>=20
> oh boy

2.6.23-rc4-mm1 reverts to mainline behaviour here.
(ie. "busy" instead of "no address or irqs")
Dunno if that's good or bad.

>> +<4>thermal: Unknown symbol acpi_processor_set_thermal_limit
>=20
> I think there are acpi fixes in Len's latest tree which will fix this.

Gone in 2.6.23-rc4-mm1.

HTH
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig3878310B1CFA5DAC0A011849
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG3xSKMdB4Whm86/kRAsfDAJ9Bt6D700L9U9oIQziYNgSgogfcUgCePiCU
qzGnydGEwQyJ6hJDpUDb5Ik=
=Qs1Y
-----END PGP SIGNATURE-----

--------------enig3878310B1CFA5DAC0A011849--
