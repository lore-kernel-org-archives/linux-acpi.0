From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 5/7 REVISION] trace, RAS: Add eMCA trace event interface
Date: Fri, 13 Jun 2014 03:09:28 -0400
Message-ID: <20140613070928.GA29351@gchen.bj.intel.com>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
 <1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
 <20140612092808.5f7bec5e@gandalf.local.home>
 <20140613021956.GA17509@gchen.bj.intel.com>
 <20140612230117.46758e3c@gandalf.local.home>
 <20140612230833.3c0f41b2@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58125 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752410AbaFMHiV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2014 03:38:21 -0400
Content-Disposition: inline
In-Reply-To: <20140612230833.3c0f41b2@gandalf.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2014 at 11:08:33PM -0400, Steven Rostedt wrote:
> > > > The above array works, but I'm wondering why you don't just use the
> > > > types themselves?
> > > >=20
> > > > That is:
> > > >=20
> > > > 		__field(uuid_le, fru_id)
> > > > 		__field(struct cper_mem_err_compact, data)
> > > >=20
> > > Every time when I use above codes I will hit some compiler error like
> > > "error: conversion to non-scalar type requested". It looks some
> > > data types like above (unless typedef) can't be used in __field.
> > > Is it true? How to fix that?
> > >=20
> >=20
> > Ah, that's a bug in the ftrace.h file. I'll need to test this against
> > it to see what error it gives. I'll work on that tomorrow as it's
> > bedtime for me now.
>=20
> Wait, I take that back. I was thinking the error was with the
> __array(). A __field() should work fine!
>=20
> Can you post me the patch you did and the error you get when you
> compile.

Here is the incremented patch & compiler error.
PS: the same issue for __field(struct cper_mem_err_compact, data)

diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index a794691..174aac1 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -35,7 +35,7 @@ TRACE_EVENT(extlog_mem_event,
                __field(u8, sev)
                __field(u64, pa)
                __field(u8, pa_mask_lsb)
-               __array(u8, fru_id, sizeof(uuid_le))
+               __field(uuid_le, fru_id)
                __string(fru_text, fru_text)
                __array(u8, data, sizeof(struct cper_mem_err_compact))
        ),
@@ -56,7 +56,7 @@ TRACE_EVENT(extlog_mem_event,
                        __entry->pa_mask_lsb =3D (u8)__ffs64(mem->physical_=
addr_mask);
                else
                        __entry->pa_mask_lsb =3D ~0;
-               memcpy(__entry->fru_id, fru_id, sizeof(uuid_le));
+               __entry->fru_id =3D *fru_id;
                __assign_str(fru_text, fru_text);
                cper_mem_err_pack(mem, __entry->data);
        ),
@@ -68,7 +68,7 @@ TRACE_EVENT(extlog_mem_event,
                  __entry->pa,
                  __entry->pa_mask_lsb,
                  cper_mem_err_unpack(p, __entry->data),
-                 __entry->fru_id,
+                 &__entry->fru_id,
                  __get_str(fru_text))
 );


In file included from include/trace/define_trace.h:90:0,
                 from include/ras/ras_event.h:226,
                 from drivers/ras/ras.c:13:
include/trace/../../include/ras/ras_event.h: In function =E2=80=98ftrace_de=
fine_fields_extlog_mem_event=E2=80=99:
include/trace/ftrace.h:330:9: error: conversion to non-scalar type requested
  struct ftrace_raw_##call field;     \
         ^
include/trace/ftrace.h:32:2: note: in expansion of macro =E2=80=98DECLARE_E=
VENT_CLASS=E2=80=99
  DECLARE_EVENT_CLASS(name,          \
  ^
include/trace/../../include/ras/ras_event.h:23:1: note: in expansion of mac=
ro =E2=80=98TRACE_EVENT=E2=80=99
 TRACE_EVENT(extlog_mem_event,
 ^
include/trace/ftrace.h:330:9: error: conversion to non-scalar type requested
  struct ftrace_raw_##call field;     \
         ^
include/trace/ftrace.h:32:2: note: in expansion of macro =E2=80=98DECLARE_E=
VENT_CLASS=E2=80=99
  DECLARE_EVENT_CLASS(name,          \
  ^
include/trace/../../include/ras/ras_event.h:23:1: note: in expansion of mac=
ro =E2=80=98TRACE_EVENT=E2=80=99
 TRACE_EVENT(extlog_mem_event,
 ^
scripts/Makefile.build:318: recipe for target 'drivers/ras/ras.o' failed


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTmqOoAAoJEI01n1+kOSLHZ4EP/1+wh6UXbgJQWzEytLJxxnpl
+nIFP1RCbZD+fhe+2TE6dAdQOFLXizo0a3j7F8YSm/a7mspbIxMvgXmj/P+/bZ4P
06kXnX07ZCDXP/eDCyVEN4qpA3c5id0YC3jyVugafWPWPw5Pz9vHx0eViV8RraD0
nOA4emAeOEXk7Br1VuUi5dQPpqQxtVcqJq5toXzkdLF6U6yiZdFmD91+eNigZK8T
qOA4MWyGixzdgvLmmdj8GE5VAlMgy4uisKE4lPlrto01BjLw0Bn5TwjrMTJ3bJtP
TObMxK1cCz0HbmxCJUAld9T70AjekNU9GGZ3LI+x0hVtG/uhj6hZEZ4pgwrKtkJ8
HpRYXkLM085iaDEyFpcpIkqaO3Wp/w5Cslge9bcVBIdV6P8BExJRIwLGAuBw2COJ
M1UuQ8IXByl5OpacyhiUTEmuY/636yJ0gtIGvcQpZU5pKtUE8hbzDxXZ4i1Db4l2
qPJfM+qOjAlOoE5B6VfBWfFmvpNScRdORq528XJ8ydBxhMd9rSbeZhKd/xI7K2Jp
9cg2aSFihMl4YhCJ09s1FGNkTI1pD0r3G8HUh5ROf3wgXSA682t85NzhqEUIUTnB
wF05l3FqH9JhoIOgk9FNusNZRuct2279O5OMtzE3UWIE0yJ3J8JSXGh1W5bwHHiA
itYX2D+PswweOwoButEy
=h4vQ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
