From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 4/5] trace, eMCA: Add a knob to adjust where to save
 event log
Date: Fri, 4 Apr 2014 04:05:49 -0400
Message-ID: <20140404080549.GA6267@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-5-git-send-email-gong.chen@linux.intel.com>
 <CA+8MBbKxeSB9oubne9p2YJYcEZYt1gKDuZf3K-CEDjpk-K_Kdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59372 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbaDDI37 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 04:29:59 -0400
Content-Disposition: inline
In-Reply-To: <CA+8MBbKxeSB9oubne9p2YJYcEZYt1gKDuZf3K-CEDjpk-K_Kdw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, "m.chehab@samsung.com" <m.chehab@samsung.com>, Steven Rostedt <rostedt@goodmis.org>, linux-acpi <linux-acpi@vger.kernel.org>, "arozansk@redhat.com" <arozansk@redhat.com>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 04:46:53PM -0700, Tony Luck wrote:
> > +static int extlog_trace_show(struct seq_file *m, void *v)
> > +{
> > +       atomic_inc(&trace_on);
> > +       return 0;
> > +}
> > +
> > +static int trace_open(struct inode *inode, struct file *file)
> > +{
> > +       return single_open(file, extlog_trace_show, NULL);
> > +}
>=20
> Shouldn't this atomic_inc() be inside the trace_open() function
> ... not the extlog_trace_show()?
>=20
Gee. It's my fault. I thought extlog_trace_show is only called
by *open* but after I look through related codes, I find it is called
be *read*, too. I will fix it in next version.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTPmfcAAoJEI01n1+kOSLH82UQAJz9sQ7ErJS3hpwbbbId3Mkh
QzS3jSVkdFpoa+wqMZxu8k/dGs4JuSnuwXoYGdj0tl46uBbiy9ZI9tS0qNtMUV3X
pVk4Bbu0qmTs3XCLy8Xvcv9s0TqXnIpBl7JbQqbqQCXrgleRQm2U1N/W463P8ePX
xoueFK99gEeQQZYVYjF5QOxq72/kQqNCj/mMGTrNoRLXjgK8vOh/qWBDRp8hNdsz
s3ni0c1phY1fcbdeXCalsh3E70uK6RwgyL9j+bahlkOSllIrDvNxYSOI+tPS38Qm
g5cYNZyOQ8LLZdoxU9SnEgOHuGvembpdelFNAQow7KW4mnvco/P2o4M1+X3SZGm6
uHaq7OLUuIE8zWA+kR1AbdeNmiYXCMHExRJ21vfTmVxitn+cydq+ajExJUrD+Lj3
RvgVuwdgpojk3xnJdiNW83WSIuUOe8cP5wVL3tXtwCYwhazF2WP9vRf6ys6xfuTF
cv2xau86Jc+6JVfgKaieLCOrJyYGmKBGN8lafPVTwt+c7ADEY0yHw0n9ZUBOosWM
QI1Kv177YlORsW4fBYostvwuInGoTfd+lmvB8rOOO4/zcnBTv31G9C1cjnUfR6ww
jFqinx7BWiQEeX/OH1qcr9QujF//gD3EnJlpF44Vab0qRDdT8Ql1vgrqGIVXfWFf
e1x1IYqkUoYP/PKYMeTg
=7CDy
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
