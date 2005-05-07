From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Sun, 08 May 2005 00:57:28 +0200
Message-ID: <427D47D8.60104@kernelconcepts.de>
References: <427CC869.1050506@kernelconcepts.de> <20050507195946.GA8212@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050507195946.GA8212-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
> Hi!

Hi!

>>Before suspend I usually see a power consumption of about 16W including
>>WLAN, which is nicely low.
>>But strangely after resume from either S3 or S4 I have see a power
>>consumption of 19W+. This means ~3W more or in other words, roughly 20%
>>less runtime.
>>This is pretty annoying - not a real show-stoppper but it would be nicer
>>without ;)
>>
>>I have no idea how to diagnose this. My first guess is that some devices
>>are not resumed correctly but I have no real idea how for example gather
>>device states before and after suspend, or other means to diagnose this.
>>
>>So, if anyone has an idea how I can diagnose this and help this issue to
>>be solved, let me know. Or is there already a solution floating around?
> 
> Is cpufreq working correctly after resume?

As to all I can observe, yes.
I have powernowd running and it nicely changes frequency up and down and
changes show up in /proc/cpuinfo accordingly (as well as in gkrellm's
cpu frequency monitor).
So I guess, yes, it works.

Any other ideas what to check for?

> 									Pavel
CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCfUfYJXeIURG1qHgRAoPSAKCBFTkCPSTUyPBCgsV33iwYZSaprQCfWVp/
6mgly24OKJyMbgcW+twdq54=
=BQFP
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
