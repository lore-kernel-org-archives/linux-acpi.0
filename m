From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Wed, 3 Nov 2004 23:29:59 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411032322410.4984@frog.athome>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
 <200411031958.47910.christian.hesse@linuxob.de>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411031958.47910.christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Hesse <christian.hesse-5lmcC6f56PSELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Christian,
On Wed, 3 Nov 2004, Christian Hesse wrote:
> I'm using software suspend 2.1. For me suspend works fine, but the system
> freezes as soon as it is resumed, I only see a black screen then. Driver nv
> works without any problems. Any hints what could be the cause?
I did not patch in anything into the kernel. I used a vanilla 2.6.9 (only 
the Makefile was patched to show 2.6.9 instead of 8 ... maybe somebody 
watched a bit too much tv... :-)
So I did not use swsusp 2.1. And I could not manage to freeze on resume 
this time. So, why didn't you try the vanilla-kernel, with the 
Haggi' s patch for the nvidia driver?
When you test - be sure to sync before suspending. It's the second best, 
besides having a jung backup handy.

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBiVvr9bBoTzOf1pMRAlyYAKDMN861PRr34cB1fwhpq/l+bWDpkACeJ2yO
NJqtHOq5blb98z1bkTyD1x0=
=gBOM
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
