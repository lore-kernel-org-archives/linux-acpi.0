From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Wed, 16 Apr 2014 02:23:23 -0400
Message-ID: <20140416062323.GB11297@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140415091944.GB29868@gchen.bj.intel.com>
 <20140415180553.GF4826@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28613 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbaDPGsj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2014 02:48:39 -0400
Content-Disposition: inline
In-Reply-To: <20140415180553.GF4826@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2014 at 08:05:54PM +0200, Borislav Petkov wrote:
> > Because 128 is not enough once all fields in error record exist, and 25=
6 looks
> > a little bit tough so I choose a bigger value. No spec for it. I just h=
ope
>=20
> Tough? How? Not enough?
>=20
We have different CPER error type. For example, for processor error type,
it has following definition:

struct cper_sec_proc_generic {
        __u64   validation_bits;
        __u8    proc_type;
        __u8    proc_isa;
        __u8    proc_error_type;
        __u8    operation;
        __u8    flags;
        __u8    level;
        __u16   reserved;
        __u64   cpu_version;
        char    cpu_brand[128];
        __u64   proc_id;
        __u64   target_addr;
        __u64   requestor_id;
        __u64   responder_id;
        __u64   ip;
};

If we want to show it in string format, 256 bytes should be not enough. But
by now we don't use this macro for processor error type so I will shrink it
to 256 bytes and add a comment for it.

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTTiHbAAoJEI01n1+kOSLH+8YQALlWhMFsd3dnZN1nCDC5Yo6n
srqd+MQZMkigg4/pj8jCRdVYk0i4WfEWmBolu54d6HnnysjwYoB9v398j24bl6Gb
hVw98doOaH6mcsAYM+wHTOeLqHit2ewDLaBfl0ryxAPYjj4eawpYCYP2TruU3FaB
MWTbP0xS0HazrcfsW2t5n3YhVhj/c4xdiW8SQ3Vaps7Mg1fMixlwZo+NAo+F+kMq
m61yugZwuc+wVse62bdc5HhDGtqTjRTlStuzKMfkEx+nbSrfHdj9e1L8yNlS1FmI
IRpyA6pb85rOwpfTtccdpLpyQQsE5YIvNKCcdh1GcN6goF9n3HBDDuPPZjVhQxCb
+aj6Oca5XQzWfYl5B0qEFG14Y5UoBNDBHOgBy/fkL4TnBsWC2B1h93/YEd8eOowv
eQ6X0QEYJkWwgU51azZsU1A4pCYKX1kUiwuJZDW8w1x9nCk12Nn+qRRBU7FPW4HY
EeVgzECg66dthhfI49ytBH2WcZ9WCJSQW+2GKQnm0LvIv8BPhDZvWigvMmTz0I/j
/XhHhlToSrFiDNwRns0jzo0ovo+LEFl+tQwtdDb9JXB9ttpasOPkYU5AHz7Czpbv
6IRs00TL7rAM5/oN3ELupXKlaUIPGRWaELjdh09cvwl8heCGwGskym5xUTSMd5lG
CVdhgfYBrckpGwfB1WKX
=kDjG
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
