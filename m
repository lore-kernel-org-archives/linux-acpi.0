From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Sun, 25 May 2014 21:59:44 -0400
Message-ID: <20140526015944.GA31035@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
 <20140523014910.GB16945@gchen.bj.intel.com>
 <20140523093703.GB21332@pd.tnic>
 <20140523101143.GC21332@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7135 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbaEZKK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2014 06:10:57 -0400
Content-Disposition: inline
In-Reply-To: <20140523101143.GC21332@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 12:11:43PM +0200, Borislav Petkov wrote:
> +	TP_printk("%d %s error: %s %s %llx (mask lsb: %x), %s%s",
What if pa_mask_lsb not existing? It will show something like:

extlog_mem_event: 1 corrected error: unknown DIMM location:
Memriser1 CHANNEL A DIMM 0 0x0000000074516000 (mask lsb: ), node: 0 card: 0
module: 0 rank: 0 bank: 0 row:
7329 column: 656 FRU: 00000000-0000-0000-0000-000000000000

even worse, if pa not existed, it will show:

extlog_mem_event: 1 corrected error: unknown DIMM location:
Memriser1 CHANNEL A DIMM 0  (mask lsb: ), node: 0 card: 0
module: 0 rank: 0 bank: 0 row:
7329 column: 656 FRU: 00000000-0000-0000-0000-000000000000

What I want to do is to make output format more graceful.

> +		  __entry->error_number,
> +		  cper_severity_str(__entry->severity),
> +		  cper_mem_err_type_str(__entry->etype),
> +		  __get_str(dimm_info),
> +		  __entry->pa,
> +		  __entry->pa_mask_lsb,
> +		  __get_str(mem_loc),
> +		  __get_str(fru))
> +);
> =20

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJTgqAQAAoJEI01n1+kOSLHXC4P8wekfqd88lW95OO7RxgfQSzh
VZ/oxafBXdFzxeequYeTsS/gMtV8BZdjBPvuK5DRZi9EKUGdpUAqwd/Q9KRpCiNr
UNnO9TerORKiTywd4CYFE5v8/Ph3fvH2/9U6Sb1H/AR57b3JWufWNanGFAYT33jQ
+4h1lMNbacXEkUjaG0RRwtUqFa/pPXB56vj+eDF9T6KRsUL+4i01K3L1oW1OHt5s
dy1tsKKxjg8ZI9Movt/sSD6kna1pAuH5bd/g2YSQsufkqDs0gI8CeEh+AyBsd/BT
43MqSVtCgUSqr4Vs+fqR7uVFjPiU8uc7LXIlMXvpcFQhypkOOxRU4317Yrq7/BVl
jZwYuYJtZhJwoIhQLaFRvQpwfT9tnYAYqu5SJcCAe2lKvSHAgChspVV5pclD6DHN
yNdH97aKzgDRJ7zOBc3wgSHEPA50nilwnIdxICcPW7wW037VevqG7a+gytRHCHqf
kCLFc3KgU7jTIM+ZiSI7uZBcKlOCi0ICiAWfjpkYCmuYjvYzq0H3s6xap/LTfN+G
vb2qk7S8N+EeKKl/L7acaTkhfdYNsxxt8sEXg4CkL/xRJqFVsaWecUkhB+ZsQqgL
HfnnAurtxtE7y2sJhYOz0IZXbibkiFfEzWPnst5Bd4SvlQovBmk3TAEB5Ue/7Pko
3CM3RsapYB3cMBIDmh4=
=cN6q
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
