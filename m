From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: ethernet effectively hangs machine (2.4.22+acpi)
Date: Mon, 03 Nov 2003 18:33:53 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1067837633.1915.0.camel@laptop-linux>
References: <Pine.NEB.4.58.0311022050090.24086@panix1.panix.com>
 <Pine.NEB.4.58.0311022124330.3302@panix1.panix.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <Pine.NEB.4.58.0311022124330.3302-1rsecFGBr9VEIHK4WyZgrw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jonathan Gold <jgold-VmQCmMdMyN0AvxtiuMwx3w@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi.

PCMCIA does a similar thing for me, unless I use pci=noacpi. Perhaps
you'll find it makes the difference.

Regards,

Nigel

On Mon, 2003-11-03 at 15:26, Jonathan Gold wrote:
> On Sun, 2 Nov 2003, Jonathan Gold wrote:
> 
> > i tried manually bringing up eth0 and assigning it a static ip,
> > which worked, but when i tried to ping another machine, i froze up
> > again.
> 
> actually, i meant to say that the machine froze up. i was fine, and
> would say that i handled the situation okay, given the circumstances
> :)
> 
> jon
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?   SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
