From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Bad battery regression on Dell D600 from 2.6.10-rc2-bk9 to 2.6.10-rc2-bk10
Date: Mon, 14 Feb 2005 08:49:05 +0100
Message-ID: <20050214074905.GB9045@message-id.gmane0305.slipkontur.de>
References: <20050204160020.GB10316@message-id.gmane0305.slipkontur.de> <1108214082.19498.53.camel@neuromancer.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108214082.19498.53.camel-/ZsuMndpQpsb5wn6fCfWY+TW4wlIGRCZ@public.gmane.org>
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

On Sat, Feb 12, 2005 at 10:36:22PM +0800, Ow Mun Heng wrote:
 
> > 0.2 seconds where the system is basically dead (cpu at 600 mhz, with full
> > speed CPU it gets faster, but i don't want to burn my battery just to read
> > out the info) is a long time to read out the battery info.
> 
> This is on Gentoo 2.6.10-gentoo-r6

Yes, i realize that i had a typo in the subject, it is on 2.6.11-rc2-bk10.
We have now tracked this down (thanks to Thomas Renninger) to a combination
of ACPI_DEBUG and !(#define ACPI_ENABLE_OBJECT_CACHE). Either turning off
ACPI_DEBUG (then it is pretty fast, like yours) or enabling the object cache
solved this. Unfortunately, disabling DEBUG is bad, since it can give really
useful information.
 
> ACPI Code is 20041105

Yes, the regression happened probably from 20041210 to 200501??.
Now, if i only knew what bad things will happen to me because of 
#define ACPI_ENABLE_OBJECT_CACHE 1 ... ;-)

> 98% Microsoft(tm) Free!! 

100% ;-P
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
