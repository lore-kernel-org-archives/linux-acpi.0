From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: Thu, 28 Sep 2006 09:04:57 +0200
Message-ID: <200609280904.57941.eike-kernel@sf-tec.de>
References: <200609271424.47824.eike-kernel@sf-tec.de> <p73k63pje1w.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2076128.VkdI0OZa2Q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:45772 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751650AbWI1HEP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 03:04:15 -0400
In-Reply-To: <p73k63pje1w.fsf@verdi.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org

--nextPart2076128.VkdI0OZa2Q
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 27. September 2006 21:38 schrieb Andi Kleen:
> Rolf Eike Beer <eike-kernel@sf-tec.de> writes:
> > I get this on my machine. SMP kernel, linus git from this morning.
> > .config and test available on request.
>
> What gcc do you use?

4.1.0 (SuSE 10.1)

> Anyways, does this patch fix it? This might have been Andrew's vaio probl=
em
> too.

Looks good, now it hangs because the init skript seems to have problems=20
activating the root volume group. But that's a different story.

Eike

--nextPart2076128.VkdI0OZa2Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFG3QZXKSJPmm5/E4RAjGqAJ9aYx5qaUFZANYaJ3NggqWR6Hv4aQCfVels
E1dQ9M7lG9TOvMKUwmt3xYg=
=09zf
-----END PGP SIGNATURE-----

--nextPart2076128.VkdI0OZa2Q--
