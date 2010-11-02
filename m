From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 4/4] cpuidle: Hack iowait weighting to avoid
	C-state reduction for graphics.
Date: Tue, 02 Nov 2010 08:42:24 -0700
Message-ID: <87fwvj7mvz.fsf@pollan.anholt.net>
References: <1288643024-5706-1-git-send-email-eric@anholt.net>
	<1288643024-5706-5-git-send-email-eric@anholt.net>
	<1288700414.26046.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1220887265=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1288700414.26046.18.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: ykzhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, arjan@linxu.intel.com
List-Id: linux-acpi@vger.kernel.org

--===============1220887265==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Nov 2010 20:20:14 +0800, ykzhao <yakui.zhao@intel.com> wrote:
> On Tue, 2010-11-02 at 04:23 +0800, Eric Anholt wrote:
> > Improves nexuiz performance by about 1% on my system.
>=20
> CC: Arjan and linux-acpi mailing list.
>=20
> It seems that the selection of C-state will become very sensitive to IO
> wait after the multi factor is changed from 10 to 1000.
> Maybe only one IO/wait will bring that the system can't enter the deep
> C-state.

Note the original message that said "This patch series is a hack, if it
helps anyone I'll rewrite it to do the right thing".

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzQMWAACgkQHUdvYGzw6vd6ZwCgiFtCYfrkVo/XHXSUbnC+wFi/
yWsAn0AVV1fdm7g4cnk2GhQnqstQaxj1
=rCVF
-----END PGP SIGNATURE-----
--=-=-=--

--===============1220887265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1220887265==--
