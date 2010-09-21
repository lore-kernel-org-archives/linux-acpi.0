From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: [PATCH 0/8] [Resend] ideapad: using EC command to control
 rf/camera power
Date: Tue, 21 Sep 2010 15:47:21 +0200
Message-ID: <20100921134720.GA19078@darkside.kls.lan>
References: <20100830181954.GE31068@darkside.kls.lan>
 <4C7E3DE0.7030209@canonical.com>
 <20100901195617.GD32589@darkside.kls.lan>
 <4C80BA81.20701@canonical.com>
 <20100909181714.GA14951@darkside.kls.lan>
 <4C89D3C0.7040105@canonical.com>
 <20100910071155.GA1263@darkside.kls.lan>
 <4C909C57.5030107@canonical.com>
 <20100915114820.GA22415@darkside.kls.lan>
 <4C920684.7080000@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C920684.7080000@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, Randy Dunlap <randy.dunlap@oracle.com>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ike,

On Thu, Sep 16, 2010 at 07:59:00PM +0800, Ike Panhc wrote:
> I have modified the driver[1]. Please kindly have a test and see if it is=
 ok for you.

This new driver works well for me. Forced enable works well with
no_bt_rfkill=3D1 and keeping the state does also work well without
no_bt_rfkill.

Sorry for the delay and thanks for your work.


best regards
   Mario
--=20
<Sique> Huch? 802.1q? Was sucht das denn hier? Wie kommt das ans TAGgeslich=
t?

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEVAwUBTJi3aBS+e2HeSPbpAQIBFQgAhGV0556YTcTdhKebPhKZI1sYyj/eufOU
3+Ph/7xhwfkrF+WT/dFSMkKHOwyG8LEqlmC4Qse+K7lurqA+UZ935uG0EtLBCXUz
TNNKxjvUl+mClikciTgcei9cfkMLYs03HIm5L37u2aO723QByVxIJYnAn/bzI1ab
7Whcq8wEEvX6FuyEcWo1ZgoTb9nXtNrevLccKRLeHX3v1Vo3xgn4JH7OBuaKeouf
0orV4M11bRzlegJfiKVih5fmoEbbJgxjZQdbrNH9L/qc6rbiO/Q5ZFqqFAPcbbAi
NQ7qicFSDbKoxho7cVUwkpmsV4azXo6NVAJIEqTBjAzySmbyExmVbg==
=7uqS
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
