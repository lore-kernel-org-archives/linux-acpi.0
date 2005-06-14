From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: /proc/acpi/alarm not working
Date: Tue, 14 Jun 2005 20:22:27 +0200
Message-ID: <42AF2063.3050104@kernelconcepts.de>
References: <42A7842C.2060207@colitti.com> <20050609134938.GA4478@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050609134938.GA4478-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
> Hi!
Hi!

>>I am trying to use /proc/acpi/alarm to wake my laptop from S3 and go 
>>into S4 after a fixed amount of time. But I can't get 
>>/proc/acpi/alarm to work.
> That sounds dangerous to me... drive might spin up during bad time when being
> transported...

I am also missing that functionality!
My older Lifebook was able to do that automatically using APM. This was
very convenient because you never had to care about usign one over the
other suspend method. You simply close the lid - dot.
When you turn the machine back on it will still have almost the same
battery power left.
The idea is that if you do not use the machine for several minutes
(hour) the probability is high that you will not do so for another
extended period of time which makes suspend to RAM a bad thing, sucking
your battery to empty (and we all know that batteries do not like to get
drained).
For the short term suspend the machine will simply suspend to RAM and
come back on quite quickly.

I always had the timeout to 30 minutes and was very hapy with it.

And I also have not had any problem with my harddisk at all - I just
sometimes wondered what would happen if I close the lid and the machine
starts to suspend to disk while sitting in an airplane ;) but that's
another problem.

> Why not enter S3 but save image to disk in case battery runs out?

Two reasons:
1. Not necessary in most cases (at least it does not give a huge benefit).
2. Too much battery drain causing battery to wear out too early.

> 				Pavel
CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCryBiJXeIURG1qHgRApdTAJsEMKyg2kDioxZyC9/i91PXaONjOgCfcAFm
ZFPY+mt6fLWST+U0SfBzekc=
=QpoI
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
