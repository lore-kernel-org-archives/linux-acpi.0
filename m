From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 5/7 REVISION] trace, RAS: Add eMCA trace event interface
Date: Mon, 16 Jun 2014 22:09:37 -0400
Message-ID: <20140617020937.GA14404@gchen.bj.intel.com>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
 <1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
 <20140612092808.5f7bec5e@gandalf.local.home>
 <20140613021956.GA17509@gchen.bj.intel.com>
 <20140612230117.46758e3c@gandalf.local.home>
 <20140612230833.3c0f41b2@gandalf.local.home>
 <20140613070928.GA29351@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16811 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbaFQCit (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jun 2014 22:38:49 -0400
Content-Disposition: inline
In-Reply-To: <20140613070928.GA29351@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2014 at 03:09:28AM -0400, Chen, Gong wrote:
> On Thu, Jun 12, 2014 at 11:08:33PM -0400, Steven Rostedt wrote:
> > > > > The above array works, but I'm wondering why you don't just use t=
he
> > > > > types themselves?
> > > > >=20
> > > > > That is:
> > > > >=20
> > > > > 		__field(uuid_le, fru_id)
> > > > > 		__field(struct cper_mem_err_compact, data)
> > > > >=20
> > > > Every time when I use above codes I will hit some compiler error li=
ke
> > > > "error: conversion to non-scalar type requested". It looks some
> > > > data types like above (unless typedef) can't be used in __field.
> > > > Is it true? How to fix that?
> > > >=20
> > >=20
> > > Ah, that's a bug in the ftrace.h file. I'll need to test this against
> > > it to see what error it gives. I'll work on that tomorrow as it's
> > > bedtime for me now.
> >=20
> > Wait, I take that back. I was thinking the error was with the
> > __array(). A __field() should work fine!
> >=20
> > Can you post me the patch you did and the error you get when you
> > compile.
>=20
> Here is the incremented patch & compiler error.
> PS: the same issue for __field(struct cper_mem_err_compact, data)
>=20
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index a794691..174aac1 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -35,7 +35,7 @@ TRACE_EVENT(extlog_mem_event,
>                 __field(u8, sev)
>                 __field(u64, pa)
>                 __field(u8, pa_mask_lsb)
> -               __array(u8, fru_id, sizeof(uuid_le))
> +               __field(uuid_le, fru_id)
>                 __string(fru_text, fru_text)
>                 __array(u8, data, sizeof(struct cper_mem_err_compact))
>         ),
> @@ -56,7 +56,7 @@ TRACE_EVENT(extlog_mem_event,
>                         __entry->pa_mask_lsb =3D (u8)__ffs64(mem->physica=
l_addr_mask);
>                 else
>                         __entry->pa_mask_lsb =3D ~0;
> -               memcpy(__entry->fru_id, fru_id, sizeof(uuid_le));
> +               __entry->fru_id =3D *fru_id;
>                 __assign_str(fru_text, fru_text);
>                 cper_mem_err_pack(mem, __entry->data);
>         ),
> @@ -68,7 +68,7 @@ TRACE_EVENT(extlog_mem_event,
>                   __entry->pa,
>                   __entry->pa_mask_lsb,
>                   cper_mem_err_unpack(p, __entry->data),
> -                 __entry->fru_id,
> +                 &__entry->fru_id,
>                   __get_str(fru_text))
>  );
>=20
>=20
> In file included from include/trace/define_trace.h:90:0,
>                  from include/ras/ras_event.h:226,
>                  from drivers/ras/ras.c:13:
> include/trace/../../include/ras/ras_event.h: In function =E2=80=98ftrace_=
define_fields_extlog_mem_event=E2=80=99:
> include/trace/ftrace.h:330:9: error: conversion to non-scalar type reques=
ted
>   struct ftrace_raw_##call field;     \
>          ^
> include/trace/ftrace.h:32:2: note: in expansion of macro =E2=80=98DECLARE=
_EVENT_CLASS=E2=80=99
>   DECLARE_EVENT_CLASS(name,          \
>   ^
> include/trace/../../include/ras/ras_event.h:23:1: note: in expansion of m=
acro =E2=80=98TRACE_EVENT=E2=80=99
>  TRACE_EVENT(extlog_mem_event,
>  ^
> include/trace/ftrace.h:330:9: error: conversion to non-scalar type reques=
ted
>   struct ftrace_raw_##call field;     \
>          ^
> include/trace/ftrace.h:32:2: note: in expansion of macro =E2=80=98DECLARE=
_EVENT_CLASS=E2=80=99
>   DECLARE_EVENT_CLASS(name,          \
>   ^
> include/trace/../../include/ras/ras_event.h:23:1: note: in expansion of m=
acro =E2=80=98TRACE_EVENT=E2=80=99
>  TRACE_EVENT(extlog_mem_event,
>  ^
> scripts/Makefile.build:318: recipe for target 'drivers/ras/ras.o' failed
>=20


Any update, Steven?

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTn6NhAAoJEI01n1+kOSLHpuUP+gOtceWYCL9FwuZn7FdThAzg
oYS/1n0rZiIXgr3xtmj/2ODvKAFMWFp8M+6bnHJ+vtXPYqA3fDvNajwAFBeDpNQS
ueGIf1OKfUdnzhzwpVREYuIH7Vi1e2dQQZW4pWY8juNETnsobcARH7kHIhFW+v5T
e/xufltuHeB0uZ+wymFrvfnmFe0F9SuKM88tmyrGUmpp2n89sVXgES8Sr42rxN+T
LrzgQNQNgJ93UeBhgG8zj64FgrFUh9YBozF1b5OX9e7AdRTD5XXhoBwxbShdibgW
5PXksW1ZBHeEokCqEkkJj5jTlTsMJzBwxYmRdkSaZYJ8ykAMphLOIV48CvmsKDgI
gBSQBXGf+pG2pBuGAG0od9pB5s0HPvemsh3znDQ38hfihTyrdjwE70qYypUv7nBO
widgZbtdhM4r3w5WU6T9Ljymabd3d8gX7WcdlRPfmnlw4cPqBzS56h1jbqMcMKvO
JRd3pOoDGYLIYG6+C7gsM9NzgbKHcH6XGDu09Kf0UM/DLaea2e57TGRcu5rHHAw3
qEZmt6u+uct0RH3oK7I7FU6h5lbqD4U/Gm40XxAxNoPd3uvay/JibFvrhFooTDOC
8LQPc8Zxbd2fO+tDV42JXaOttZg82kcyeOCOgKjVR5fGQA7w6CyGzDbjhGbA5Pp8
VRIK/6dNwbSt8SBidSre
=Tx8/
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
