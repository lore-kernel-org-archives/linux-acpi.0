From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Tue, 11 Mar 2014 03:03:04 -0400
Message-ID: <20140311070304.GA12635@gchen.bj.intel.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic>
 <20140310082241.GA873@gchen.bj.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F31DE8B0D@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19175 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbaCKHdj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2014 03:33:39 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31DE8B0D@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "m.chehab@samsung.com" <m.chehab@samsung.com>, "arozansk@redhat.com" <arozansk@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 05:42:45PM +0000, Luck, Tony wrote:
> I can't imagine a reason why we'd want them to be different though.
> If a reason does come up in the future, then we can clone & edit
> the function to do different things - but until then we should share code.
>=20
> Note: there will be changes periodically when UEFI changes the error
> record format (they have added new fields in the past - I expect they
> will add more in the future).  We should be able to add more stuff to
> the end of the "mem_loc[]" string as long as we write user-mode
> parsers that won't be surprised by extra fields there.
>=20
> -Tony

OK, I will follow you guys suggestion for next version, like code
sharing, trace/printk switching

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTHrUoAAoJEI01n1+kOSLH24gQAKsjA5AfVj8CqMjqDRDHWove
A9Nk7B3cMrIYX/eCTlhnBO6A3HLmHkgZ70pf430tvmz7pwEJuJU542Ly5ZeE+PKX
bjwMXiX22LvYIz4De2JxDc12pODt6dTnXFo0qh14YbIxwQI8S1gsbJTTT/pnh7rc
pSVVCw2p77pdsm7eT+QmpQ9M2qtWJYKdRPdvLEEWEHslmFm9xcT6EyGcJunb246s
bTGT9AldQkMlEv/M7FEDXMawZxXl/cA6I7wIuRNaMVUZNEgqCr0Xb2degN4gy/16
+WeDQDwBVX/Ta6eq7T26+MvOCe1nKP/5l7RTI/AlB3KpLaE87qO7eGLycasXA0rk
21rvMU2gTlh6sNiK4IyTs7TekaQ8cczxkKV5UxGdllwqRYHpuvU95CE6GBSMfsy4
0bxJBckn83rCBTA0dFXTyRIpRDqgC7AGaz05CBbkDOxXhYQ4SV2iYFgW5PptZ7lw
pE4ISjrJRHH7oIHl1B9cQL6vsC5uoH0mJk9fc5sTufXoT/4JIvmFqRaCwK8UU9RJ
GwEi2S9fkDiDMDwuwvgXYy8gbVPpZ8U/5U0eqXNkph/G/Kozornztuj1PrAIQB96
GsWBErdunIWoODx02nVECvEK4xzvYK9kv8LgSPvFAosO5PfIvPnUKG4xhNheZomR
Q/fW3n/KiU/ylFUXHKNe
=CIHR
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
