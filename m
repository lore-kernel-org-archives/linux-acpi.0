From: <liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: 2.5.75 - ACPI and sound lockups
Date: Sun, 13 Jul 2003 12:43:24 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0307131238520.561-100000@frog.athome>
References: <200307122306.14036.ivg2@cornell.edu>
Reply-To: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307122306.14036.ivg2-HmMyXyqgL2CVc3sceRu5cw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ivan Gyurdiev <ivg2-HmMyXyqgL2CVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Ivan,
my first look says, that IRQ 3,7,10 and 11 (which is the one, that bit
you, I think) has to be level and not edge.
As irq 11 is shared, this is no good!

May you please get the information you provided for 2.5.74 for the
2.4-kernel you mentioned, too (including ACPI-version from
/proc/acpi/info)?

On Sat, 12 Jul 2003, Ivan Gyurdiev wrote:
> Hello, I've been posting this bug report for a while on LKML, and I decided to
> send it here as well. I'd like to help testing and tracking down the problem,
> but I've had no replies so far.
>
> Here's a link to the original LKML post:
>
> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0532.html
>
> This is the ACPI code including with the 2.5.75 kernel.

cheers
  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ETfR9bBoTzOf1pMRAoa7AKDuleSOUyLpSOUOAOyIlF9GoZ4K/wCaAvtR
5r7l//k2f93SIheNLmcs004=
=WX8h
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
