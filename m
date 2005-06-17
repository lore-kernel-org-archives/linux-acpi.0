From: =?iso-8859-1?q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Subject: Re: cpu hog reading battery info
Date: Fri, 17 Jun 2005 14:36:54 +0100
Message-ID: <200506171436.55157.destynova@esatclear.ie>
References: <42B2C9B6.2080400@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42B2C9B6.2080400-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Content-Disposition: inline
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

On Friday 17 June 2005 14:01, Pippo Caloggero wrote:
> Hi after upgrading to 2.6.11 doing a
> cat /proc/acpi/battery/BAT0/info
> hogs my cpu to the point that X and the mouse block for 1 second.
> This is especially annoyng as for example kde battery monitor do that
> every 20 secs to read battery capacity.
>
> Is it a known bug? Is there some way to dig into it?

There's the EC burst mode patch out there which replaces the busy-wait=20
spinlocks in drivers/acpi/ec.c with semaphores:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/to-akpm/a=
cpi-20050601041442-dtor-KwM2v4JqSEzeGshsqgM8IUPJkLQgvAqAJm6DLlPSJJU@public.gmane.org

Maybe that'll apply for you.

Ois=EDn


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
