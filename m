From: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: [Solved] Re: power-off (Acer TM632) / Filesystem-corruption
Date: Wed, 2 Jun 2004 12:12:41 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0406021204490.1486@frog.athome>
References: <20040531213726.GA3298@zimen.sk> <16572.19517.483958.68645@aber.ac.uk>
 <Pine.LNX.4.60.0406011854270.17375@frog.athome> <20040601182933.GA3046@zimen.sk>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040601182933.GA3046-VaXaUECoPuY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mizu <michal-VaXaUECoPuY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Mizu,
On Tue, 1 Jun 2004, mizu wrote:
> I can post this bug.
>
> I found some similar bug :
>
> Bugzilla Bug 2719:
> 	  	[ATI 9100IGP, Award/Phoenix BIOS]: halt becomes reboot
> 		when BIOS "Wake up on RTC" is enabled
>
> but, i don't think, that this is the same problem, or not ?
maybe it could be mentioned in the text... But I think a new report is 
required.
Boy I had a bad experience! Just tryed to reproduce your problems, by 
loading module-rtc. The machine was just started and waited at the 
KDM-prompt. Loading the module and shuting down crashed my 
ext2-filesystem, loosing some files. That is really bad! Of course it did 
not power-off, as you all experienced.

cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAvage9bBoTzOf1pMRAjk1AKCbmVUOsPE/0yc1Ok4V3Mk1KjMUjgCeMEUS
DLjv1OQbWHChqI7CEcpOAQY=
=wsqW
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
