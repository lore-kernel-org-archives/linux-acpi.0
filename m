From: pumpkin <pumpkin-Mmb7MZpHnFY@public.gmane.org>
Subject: C2, C3 and bus master activity
Date: Tue, 19 Jul 2005 20:50:28 +0200
Message-ID: <200507192050.28343.pumpkin@gmx.de>
Reply-To: pumpkin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello

My CPU does not enter C3 if i run the stock configuration. Way too much bus 
master activity. I want to find out what is causing it. Any hints how to do 
that ?

I found one possible cause for some of the activity. Without X i have a 50:50 
mix between C2 and C3. Using the vesa-driver the mix stays at 50:50. Using 
the radeon-driver (dri disabled) the CPU stops using C3.

the facts in case somebody already has a idea:
- ibm R51
- PentiumM 725 (1.6GHz)
- Intel 855PM chipset
- radeon 7500 mobil
- xorg 6.8.2
- kernel 2.6.11-1-686 (debian stock-kernel)

thanks.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
