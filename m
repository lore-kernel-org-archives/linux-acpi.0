From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Fri, 7 Mar 2014 01:21:54 -0500
Message-ID: <20140307062154.GA19240@gchen.bj.intel.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
 <20140306111852.GA24629@pd.tnic>
 <20140306084320.539ec76e@samsung.com>
 <20140306121714.GC24629@pd.tnic>
 <20140306100653.46249ea1@samsung.com>
 <20140306152633.GE24629@pd.tnic>
 <20140306123915.0bae1252@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25730 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbaCGGoa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Mar 2014 01:44:30 -0500
Content-Disposition: inline
In-Reply-To: <20140306123915.0bae1252@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com, arozansk@redhat.com, linux-acpi@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2014 at 12:39:15PM -0300, Mauro Carvalho Chehab wrote:
> Date: Thu, 06 Mar 2014 12:39:15 -0300
> From: Mauro Carvalho Chehab <m.chehab@samsung.com>
> To: Borislav Petkov <bp@alien8.de>
> Cc: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com,
>  arozansk@redhat.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 1/2] trace, RAS: Add basic RAS trace event
> X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.22; x86_64-redhat-linux-gnu)
>=20
> Em Thu, 06 Mar 2014 16:26:33 +0100
> Borislav Petkov <bp@alien8.de> escreveu:
>=20
> > On Thu, Mar 06, 2014 at 10:06:53AM -0300, Mauro Carvalho Chehab wrote:
> > > For example PCIe and memory errors are not x86-specific. Also, as ACP=
I=20
> > > may also be used on ARM, we may also start to have APEI errors there:
> > > 	https://lwn.net/Articles/574439/
> > > 	https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI
> > >=20
> > > So, better to think on that on a long term.
> >=20
> > kernel/ras/ could also be used in that case but I guess drivers/ras/ is
> > fine too.
>=20
> Both work for me, although drivers/ras seems more adequate, IMHO,
> as I expect that we'll have there both subsystem code and drivers.
>=20
OK, I will move this trace stub to drivers/ras in next version.
BTW, any other comments for 2nd patch? I thought Mauro will
have some comments for that patch. :-)

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTGWWCAAoJEI01n1+kOSLHuhMP/jC4cXE3aZd+4O52vea6Ju7M
42F/xDLdhCe69OzKSw8RF/933mpwl6tqkC/Sycv5Z6FIImW5mW3ADLwVZjyF2znK
BrBollByBd8+2Io9VMjSIRi7CkepsYlvp3lv12DfCTpV3USdpKjndP8LThnjHx6X
bQNNLXlEKeY4P3bqc/576MI/gGc2y4wayfbevyg7150FTD51IMXdXqyDPN4ikikP
lAKi7FIS+uLCvq3qoeKUTh4Yxc544sw59rjhRqyc8ZvPL+Q6Bk8MsS3WsG1cbl2O
345x35mQOoP99/D2cJbWvLsblfK89JgDmAEJ595JtN3o1DeiAk4l98TkR/04F8di
bcIq/jyAl9H7H2uP+ss6CF+QTcxB1/qIdP/UlKfTxm1NiBFmD+veJZLUJQ977qqz
Nbsh3IU3PZ+tqM4+B+oRiXeuQxSBSKQes3kLeE4lGM7vZWise0spwXx3aGojkybq
JVKnMWVaLDiImGKekYfyNOM1T4S0wz7OZOxlpftHnJzPUTdNvpthta6btm9op4j6
9VXGn8kNqTQHPE+OSpWDZDs3qPT0JERCw6Wvc+QRAI2Wpnhf6bh6F1+oCYkFhUbt
DcZnpRGxYZDcwXy7Ih/iLGlKvnr+35/1ZKy6Xa/XFjbNQGfON7CN4etngNq27e8j
lVDXxBqv5nm7QQHXUMt7
=MH/+
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
