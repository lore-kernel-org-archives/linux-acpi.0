From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Re: ACPI buttons in 2.6.12-rc4-mm2
Date: Wed, 27 Jul 2005 17:40:14 +0800
Message-ID: <1122457215.16508.53.camel@neuromancer.home.net>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com>
	 <b6d0f5fb0505220425146d481a@mail.gmail.com>
	 <1122407079.13241.4.camel@toshiba.lenb.intel.com>
	 <E1DxVWb-0002Sx-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1DxVWb-0002Sx-00-QGMSyCZBOSwv4zxTlrOuLwNdhmdF6hFW@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-07-26 at 20:55 +0100, Matthew Garrett wrote:
> Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > I deleted /proc/acpi/button on purpose,
> > did you have a use for those files?
> 
> There are various cases where it's useful to know whether a laptop is
> shut or not, and /proc/acpi/button seems to be the only place where that
> information is made available at the moment.


I agree. Why was it deleted in the first place? 

In any case, please make them appear in /sys I'm sure there are more
people who uses it. :-)


-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 1.5GB RAM
98% Microsoft(tm) Free!! 
Neuromancer 17:39:22 up 3 days, 23:51, 6 users, load average: 1.22,
0.83, 0.90 




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
