From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: 2.6 won't poweroff
Date: Thu, 27 May 2004 19:07:58 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0405271903070.4655@frog.athome>
References: <20040525044514.GC2217@smeagol> <Pine.LNX.4.60.0405251112580.1337@frog.athome>
 <1085638695.17686.64.camel@dhcppc4> <Pine.LNX.4.60.0405271714330.4143@frog.athome>
 <20040527160436.GE2810@smeagol>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040527160436.GE2810-Kz9ENIl45+A@public.gmane.org>
Content-ID: <Pine.LNX.4.60.0405271903361.4655-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>, Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Emma & Fred,
On Thu, 27 May 2004, Emma Jane Hogbin wrote:
> I was thinking some more about this...I read somewhere that the 2.4 
> kernel uses /proc events and the 2.6 kernel uses /sys events and that if 
> you're using old scripts with a new kernel "halt" won't work because 
> it's trying to turn off /proc events. Does that make sense? How would I 
> know what my system is doing? (Debian unstable.)
I would check the software as a last resort...

>> Emma, does your TM634 has the latest BIOS from Acer, i.e. R01-C0O?
> I'm not sure how I'd check. :/
On startup press F2 to enter the CMOS-Setup. There you will be on the page 
Information, where you can find on the line, starting with
  SystemBIOS version: V4.R6.1-C0O
So no need to hurry Fred ;-))))

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAtiB29bBoTzOf1pMRAm1BAKCzhn1cif/dB0NxOMacD+6g1FqcQACgk4Y6
pC6bvpwg9ZQSe+cvzny9CiA=
=AlCZ
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
