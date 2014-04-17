From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Wed, 16 Apr 2014 23:00:31 -0400
Message-ID: <20140417030031.GA4303@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140415091944.GB29868@gchen.bj.intel.com>
 <20140415180553.GF4826@pd.tnic>
 <20140416062323.GB11297@gchen.bj.intel.com>
 <20140416132818.GE16741@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:57428 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390AbaDQDZt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2014 23:25:49 -0400
Content-Disposition: inline
In-Reply-To: <20140416132818.GE16741@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 03:28:18PM +0200, Borislav Petkov wrote:
> Yeah, we don't have to always adhere to the spec if we feel it doesn't
> make any sense. A lot of those fields above are purely useless and we
> shouldn't carry them blindly to the outside.
>=20
> For example, we don't need to carry cpu_brand[128] to the outside for
> *every* error. Who even came up with this crap, is beyond me??? It's
> like the cpu changes brand on every other error or what? You harvest
> this info only *once* from /proc/cpuinfo. cpu_version too. And so on and
> so on...
>=20
> Please sanity-check stuff like that before hardcoding it into the
> tracepoint. If it is in the spec it doesn't always mean it makes sense.
> We need to carry out only the minimum amount of information of each
> error which is actually getting used in userspace, for additional RAS
> actions. Carrying fat blobs just because the spec says so is simply
> wrong.
>=20
I agree. But at least for memory, I want to show them all. Maybe
requestor_id/responder_id/target_id are not so important. But in
reality, I've never seen they are valid. So just leave them there.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTT0PPAAoJEI01n1+kOSLHehgP/1Al+5ow7vcs1O3/KFQMNizb
vuL314kOIKKfVbDLuYUCSiThaXo3wXmTSefTTDa6KsKz0dna7ESXAmbr9ioddjj5
6kaZn8Mz+vmsz3gnAArV44KiGuXpiam8U837X4N/oCOZrWjPF007jhTEEa0YELw3
xLANBmuKlqvFl4IMSA9Zo6/LquTokvnWWRAVwYPGIwEhxtVGK2Tvhdx8INU9XvSR
FN476ZBKIcy1ocsVMhSfnYCN/Ng7SSyXsHrT5kkAGkQJMrUEjeXoLB8R7yIn7e0+
G5VrhUI32WkyYUhtGWsiKbRfljJ0TgJNO9uMNX2I5XtF0nxyODT1RlZN0s0hCLmE
8Q1tkieAgfddt7+19eSMjILZ9wjuE6+oasZqtNarCIyZqvJ5+biSX6wUT+COj/lg
A2eZdjMOxC5zlxuhMDQuxfco/QRoOjPpNduMaub8YofFHkFRFbgQ8Ujrcv9VGwER
WP6Q6KqJvm8o0ForcK1iEGZN8C6fmU5mcwccjJGXRz0ux+y5ITaG+g1Yq0DRiMwG
oEiZmxW9OEPNVRwltLS1bR7xU6lZDi8ziGe7i5R2fPwi0qJeQ+j4b5VTgNuVvPnE
aYNnww/A3vhf3sxTI+oo3inT1dYrrsbG0IU14qsxm7sDPjcA6CFIlBUQXHoo4g/c
rzgTByj5dYnVxz549bxA
=vMYg
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
