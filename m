From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Look Ma, da kernel is b0rken
Date: Thu, 6 Dec 2012 07:57:21 +1100
Message-ID: <20121206075721.18c0c05aa767b330f47d77eb@canb.auug.org.au>
References: <20121205070901.GA12123@rhlx01.hs-esslingen.de>
	<20121205142935.GA12119@liondog.tnic>
	<20121205152756.5afec12c@pyramind.ukuu.org.uk>
	<20121205153121.GA28556@liondog.tnic>
	<20121205154749.2af4ef36@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__6_Dec_2012_07_57_21_+1100_tu00Vcn7E_X5rhhb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from haggis.pcug.org.au ([203.10.76.10]:58326 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab2LEU5e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Dec 2012 15:57:34 -0500
In-Reply-To: <20121205154749.2af4ef36@pyramind.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

--Signature=_Thu__6_Dec_2012_07_57_21_+1100_tu00Vcn7E_X5rhhb
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Wed, 5 Dec 2012 15:47:49 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> And yes btw we should turn this option on in -next, and get these sort of
> things out of the tree for good. More importantly it'll mean anyone
> adding another one gets a whine on the spot.

While I appreciate your confidence, I don't notice quite a few new
warnings (because there are so many of them already :-().  Is there some
reason to not turn this on in our "normal" builds?  Does it produce many
false positives?  What compiler version is required?

I also currently don't carry patches that only ever appear in linux-next
(well, not intentionally anyway).  I assume it would require a patch to
the Makefile(s) to turn this on.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__6_Dec_2012_07_57_21_+1100_tu00Vcn7E_X5rhhb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQv7UxAAoJEECxmPOUX5FEn3EP/jUAaiB0LFqa7ZuDRj1IvpGG
9qshPdPuYbJrwsYMJlZqDMrE5v+DhJrrqIga2jWMM2YqWxlczjMZXjMsKSCKIJ0g
RNohUww1oCuZRqNHLFx6kWFUASQUYrNJp5+AORTbzu5B48QGYnl+VeqbR2h+vD5G
pABE4ypkAqFtvO7ZWPj05E4aBJMpFOqfd54dLptSGfnJhPKfH59WFSHqOottMX2b
+RiWdBDefWQmldvFGNpC+jfBWPhCeDXx5GXPXvXLNv7kRvsMiEOWIZCQbqFEhx+/
rYBvX89gV5dNbQWCEVm/j2mcRzqYMJq/+yLQxmRo2CyZdw8NpZlmiEcVQPFn4eF7
JAr7CNTxbUZYFKELbQReOKpC8gCbUauwyFriWjnBsZ+Lv75nn3JrdppFaB+6fbuE
xZnpF3HmmAQhpA2RP6uwG/c3Olkahx4mrnfVONIcNRbmNE2cBg75dYjuzD5P1EYt
Jxz4RrKNKyre+uViJU/qGKoBA2WDA9wTKdw9Y3TeOxw8GjGz5OmXkzVsMeGCeoqF
dmBx+ZUQdLw9ZUfn5Ohk4mTxP57wz5xekJCW/XOLiHfU2RJnyQcIRMPFaEMfPPJx
YStbIW+XFhtk3maPU14J5TO+d9x/bnSyH7HuYnjsbAnZzzMbDdrQqDCUOB/fW1TH
9uVJjikt2Mj/MzMRfHnV
=/YOx
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Dec_2012_07_57_21_+1100_tu00Vcn7E_X5rhhb--
