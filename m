From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: /proc/acpi/alarm not working
Date: Fri, 17 Jun 2005 14:43:24 +0200
Message-ID: <42B2C56C.9010306@kernelconcepts.de>
References: <42A7842C.2060207@colitti.com> <20050609134938.GA4478@openzaurus.ucw.cz> <20050617101604.GA22108@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050617101604.GA22108-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karol Kozimor wrote:
> Thus wrote Pavel Machek:
>>>I am trying to use /proc/acpi/alarm to wake my laptop from S3 and go 
>>>into S4 after a fixed amount of time. But I can't get 
>>>/proc/acpi/alarm to work.
>>That sounds dangerous to me... drive might spin up during bad time when being
>>transported...
> Why use S3 if you intend to transport the laptop in the first place?

Because you do not necessarily know that you are going to transport it.

My typical use case is that I use the machine at some point of day, then
simply close the lid, it goes to S3. Then I find that I forgot something
or such, open the lid and it resumes almost instantaniously. I close it
again after work is done.
And this can happen several times a day, my brain is sometimes a mess ;)

But if I do not resume it in time it will simply fall to deep sleep
(S4), saving battery power and lifetime. And I do not have to waste a
single moment thinking about "Do I want to use again soon or not?".

>>Why not enter S3 but save image to disk in case battery runs out?

As I said, the point of battery running out is IMHO too late. Cycling
Li-* batteries a lot reduces their lifetime significantly.

> Best regards,
Kind regards
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCssVsJXeIURG1qHgRAj3JAJ0eBZ9iNg1IWZDQtZL/xeGLv4OZKwCfaViy
Jxo8Zs0HNvF1XToHvLENU3I=
=q3YT
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
