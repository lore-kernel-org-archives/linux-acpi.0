From: Nico Schottelius <nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Subject: Re: [nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org: [BUG] pdc202xx_new and ACPI fails]
Date: Tue, 7 Dec 2004 00:02:38 +0100
Message-ID: <20041206230238.GD2266@schottelius.org>
References: <20041205211754.GB7695@schottelius.org> <1102286168.2308.13.camel@d845pe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1102286168.2308.13.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Len Brown [Sun, Dec 05, 2004 at 05:36:09PM -0500]:
> Nico,
> Please verify that you're running the latest system BIOS,

=46rom
http://www.asrock.com/support/download/dl_k7vm2.htm#bios

it looks like I have the latest one.

> then re-test with 2.6.10-rc3.

eiche# uname -r
2.6.10-rc3

> In the bug report, please attach the 2.6.10-rc3 dmesg
> and include the /proc/interrupts for:
>=20
> A. no kernel parameters (the failure)

done (fails)

> B. "noapic" (may work, may fail)

done (fails)

> C. "acpi=3Dnoirq". (success case)

done (he's right, it really works)

> Also attache the output from "lspci -vv" and the output

done

> from acpidmp, available in /usr/sbin or in pmtools here:
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

done.

Is it somehow possible to upload files? Copy and paste to mozilla
is just cruel.

> It is possible that this failure is isolated to IOAPIC mode,
> which ACPI enablds by default.  So it may be that config B
> above with the IOAPIC manually disabled will run ACPI
> just fine, including power-button interrupts etc.

No, does not.

I hope you guys will be able to read the bug report, I just pasted
some KiB of data into it.

AAAAAAAARGH: Comments cannot be longer than 65,535 characters.

Use this URL:=20
http://schotteli.us/~nico/eiche-acpi-promise.bug-report

(its a cut and paste from the textbox)

Please tell me if you need more information.

Btw, there is a silly error presented by the controler, when
attaching devices to the ide3/ide4 ports, if
I set "pci bus master" to on in the mainboard bios. If it
is disabled, the controller only complains about the 'bad' cable :)

I don't know what this is, anyone a hint?

Have a good night,

Nico, beeing tired and hopes his research clearifies some things.

--3Pql8miugIZX0722
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQbTlDLOTBMvCUbrlAQIZpw/8DldVZACOjdovbZHtzlGV1nAD6KYCgP7Z
kHnf4ClOImIDSfO0kH+yWqeRrwDnNgyQ6khDprZ+qOV84ZBSgc/HgfYhnLexQ/BS
yXGH86bn04/jwb/XCG6FjOOSStGXSduJPtPqAkEHfM3+TJBFRlrYYoVduCx+w5qs
xORqh0u4q4sGfvgfh6Leh8Dzpl96oR6hhtrJ+k6v2s5jm6k27EUrkESqdeXQwRCG
Cf8vu8KjnG2FPB0YKawsTGPxrachrfkf3sUII1Fi/q95lCp64h0ptd5FRjREuQNf
uiHDhyOh++cGjO+3yUUnN2fa8s80cGFoH63ivWZS6+o48g3gT/1X6jg07MIAcOTY
zuGu3G2vilHg1EI78ILhcYHqPm0JINl3Vfy8bkC9KatmoArA1gGOFqAqi17DKT0Z
07A5Y/TusnG70jnzpkig9ayvQNbzl6ufg8bytr7EDHyTOIdVwe+2Nqtye8cv2SYz
Gv84SQYiMTvan8vJURlBfkhbaMf0K8+MSZcLlTk3RKsBupg8k6N3UrGbixA+RCoO
AvApOUuMsIKxodCzwQCikv5HgPOKkIeiXFLUA69E0Y4Fx67SZY6VXCqUCTFPzH4A
eoUUxdMqeJD3GL5pCrN1ZwhP97iGWmaMax6FKGcOeYz11L1R3x6pCfMjrMG2eBjY
fYwvwCDnz0w=
=urgx
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
