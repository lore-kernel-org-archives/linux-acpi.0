From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: [Solved] Re: power-off (Acer TM632)
Date: Tue, 1 Jun 2004 10:28:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16572.19517.483958.68645@aber.ac.uk>
References: <20040531213726.GA3298@zimen.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040531213726.GA3298-VaXaUECoPuY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mizu <michal-VaXaUECoPuY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

mizu writes:
 > salut
 > 
 >   :) Yes !
 > 
 >   now, it works wery well for me.

YESSSSS

Worked for me too.  Replaced the enhanced by the generic with extended, and
it worked.

How did you spot that?  Anyway, it was well spotted indeed.  Might be worth
reporting to people responsible for that (?).

Thanks.

Fred


 > 
 >   I played with kernel configuration, i found this:
 >   
 >   I guess, Problem was in "Enhanced RTC driver". If i have this driver
 >   inside a kernel (or like module), my laptop will never poweroff().
 >   last message was like this:
 >   		...
 > 		call_power_off()   
 > 		...HANG...
 > 		
 > 		
 > 
 >   
 >   (also i have inserted HPET timer inside kernel, not like module)
 > 
 > 
 >   Is this some unresolved dependency with RTC ?
 >   Can i have both timers ? (RTC, HPET )
 >   
 > 
 >   Thanks a lot.
 > 
 > 
 >   				mizu
 > 
 >   
 > On Fri, May 28, 2004 at 09:44:18PM +0200, hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
 > > -----BEGIN PGP SIGNED MESSAGE-----
 > > Hash: SHA1
 > > 
 > > Salut Mizu,
 > > I forward you a mail, that I sent Emma, with my settings.
 > > 
 > > please give them a try.
 > >   hartwig felger
 > > 
 > > Hartwig Felger informatics
 > > 
 > > - -- 
 > > 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
 > > Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
 > > For the pulic keys, please visit my page.
 > > 
 > > - ---------- Forwarded message ----------
 > > Date: Thu, 27 May 2004 17:27:58 +0200 (CEST)
 > > From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
 > > To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
 > > Subject: power-off
 > > 
 > > Salut Emma,
 > > as I asked you in the mail on the list, do you have the latest BIOS R01-C0O?
 > > 
 > > I attached you my .config file. As I also recently patched my kernel with 
 > > swsusp2, pwcx and packet-cdvdrw you will want to run
 > >  make oldconfig
 > > on an vanilla 2.6.6 kernel. If it does not let you shutdown your notebook, 
 > > than it will be a problem with your software, but not the kernel, or acpi.
 > > 
 > > Just let me know, how you story continues...
 > >   hartwig felger
 > > 
 > > Hartwig Felger informatics
 > > 
 > > - - -- 1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
 > > Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
 > > For the pulic keys, please visit my page.
 > > - -----BEGIN PGP SIGNATURE-----
 > > Version: GnuPG v1.2.2 (GNU/Linux)
 > > 
 > > iD8DBQFAtgkG9bBoTzOf1pMRArl2AKDYY/QD7sKsspJTLA0j7bMcx0Eb/wCeLe2R
 > > Ixw4Q+QT+LhtZWlHqPGksWA=
 > > =6d1v
 > > - -----END PGP SIGNATURE-----
 > > -----BEGIN PGP SIGNATURE-----
 > > Version: GnuPG v1.2.2 (GNU/Linux)
 > > 
 > > iD8DBQFAt5aX9bBoTzOf1pMRAi3AAKCOHCR0Yived3OfMVhdoFP8wpOg8gCghppJ
 > > 6XeMFlU7QEWJbAuhW5uMvo0=
 > > =MatN
 > > -----END PGP SIGNATURE-----
 > 
 > -- 
 >               mizu
 > =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 > [-> E-mail:michal_AT_zimen_DOT_sk    
 > [-> ICQ:97165392
 > [-> WWW: http://michal.zimen.sk
 > =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
