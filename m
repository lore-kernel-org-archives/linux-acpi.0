From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ACPI thermal event causes brief freeze
Date: Fri, 25 Feb 2005 11:34:25 +0100
Message-ID: <421EFF31.9060002@suse.de>
References: <421E6D6C.2090906@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Lorenzo Colitti wrote:
> Hi,
> 
> since I upgraded to kernel 2.6.11-rc4, every time there is a thermal 
> event my machine (HP/compaq NC6000) freezes for about 1 second. Audio 
> stutters and pretty much everything, including the mouse pointer, stops 
> dead for a bit.

Have you enabled ACPI_DEBUG?
If yes, try again without.

> 
> This did not happen with a similarly configured vanilla 2.6.9 kernel.

ACPI_DEBUG is incredibly slow since 2.6.11-rc2-bk10.
> 
> It's pretty irritating. Is there anything I can do to debug this?

You probably solve this by not debugging :)

       Thomas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
