From: nbs_r <nbs_r-gGZFqZ9RcmRmR6Xm/wNWPw@public.gmane.org>
Subject: Re: NEC RX LR700/8E support
Date: Sun, 26 Jun 2005 15:37:02 +0900
Message-ID: <42BE4D0E.1010604@gazeta.pl>
References: <42B44E9A.5010502@gazeta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42B44E9A.5010502-gGZFqZ9RcmRmR6Xm/wNWPw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Is this a valid mailing list for such an end-user support? Where should
I ask for help?

Regards,
\R.

nbs_r wrote:

> I have problems with a NEC RX-series's LR700/8E notebook running Linux
> version 2.6.11-1.27_FC3 (Fedora Core 3).
>
> The most important one (overheating) was solved by adding
> acpi_os_name="Windows 2001 SP1" option in grub.conf. Nevertheless,
> DSDT contains other errors as well:
>
> ASL Input:  dsdt.dsl - 4064 lines, 146078 bytes, 2275 keywords
> Compilation complete. 21 Errors, 1 Warnings, 0 Remarks, 494 Optimizations
>
> Although I'm unable to fix these errors on my own, I'll happily help
> with testing.
>
> Attached data:
> cat /proc/acpi/dsdt > dsdt.dat
> dmesg -s40000 > dmesg.out
> dmidecode > dmidecode.out
> lspci -vv > lspci.out
>
> Best Regards,
> \R.
>
>


-- 

Dodawaj ZA DARMO og³oszenia do Aaaby.pl i Gazety Sto³ecznej: Dla dziecka, Fotografia, Hobby, Ksi±¿ki, Odzie¿, RTV i AGD, Meble, Telefony

http://www.aaaby.pl


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
