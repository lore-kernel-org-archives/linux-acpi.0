From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: About DSDT fixing and debugging
Date: Thu, 23 Sep 2004 13:50:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4152B880.6050001@pca.it>
References: <I4HK00$27530FB661DF79A95160CDA9EDFBAE18@libero.it> <20040923125525.GA19982@laptop>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040923125525.GA19982@laptop>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 09/23/04 14:55, Andreas Leppert wrote:
> just want to say that these are exactly the same problems i have with my fujitsu amilo D 7830!
> no throttling (always C1 = 12%), no cooling (always 75° C). i have already disassembled with a few 
> errors, but couldn't fix it correctly.
about the C1 states: does your DSDT have a PBLK_lenght != [0|6]? Please
see post [1] on ACPI-devel (sorry, I don't know how you can see the
whole thread with gmane.com) and the first integration _CST method [2].

Thx, bye,
Gismo / Luca

[1] http://article.gmane.org/gmane.linux.acpi.devel/8588
[2] http://bugme.osdl.org/show_bug.cgi?id=1958
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBUrh/VAp7Xm10JmkRAig5AJ9+T/OpY63gISuGo94BobToRioz6QCfVszN
Iha3TwtcsYIbHUCUWIHfr1c=
=0Rrl
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
