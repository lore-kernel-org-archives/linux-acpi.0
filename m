From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: ACPI thermal event causes brief freeze
Date: Fri, 25 Feb 2005 16:30:54 +0100
Message-ID: <20050225153054.GC22631@message-id.gmane0305.slipkontur.de>
References: <421E6D6C.2090906@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E6D6C.2090906-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
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

On Fri, Feb 25, 2005 at 01:12:28AM +0100, Lorenzo Colitti wrote:
> Hi,
> 
> since I upgraded to kernel 2.6.11-rc4, every time there is a thermal 
> event my machine (HP/compaq NC6000) freezes for about 1 second. Audio 
> stutters and pretty much everything, including the mouse pointer, stops 
> dead for a bit.
> 
> This did not happen with a similarly configured vanilla 2.6.9 kernel.
> 
> It's pretty irritating. Is there anything I can do to debug this?

it is probably caused by ACPI_DEBUG. I experienced the same - see my mails
from 4th and 14th february with subject "Bad Battery Regresion on Dell D600",
there are some workarounds to this.
-- 
Stefan Seyfried



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
