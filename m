From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: C2, C3 and bus master activity
Date: Wed, 20 Jul 2005 21:05:16 +0200
Message-ID: <m23bq98fir.fsf@phoenix.squirrel.nl>
References: <200507192050.28343.pumpkin@gmx.de>
	<200507192118.37528.bob@diamond.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507192118.37528.bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org> (Bob Lees's
 message of "Tue, 19 Jul 2005 21:18:37 +0100")
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

Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org> writes:

> In a word USB.  I don't fully understand why, but if I disable USB then both 
> my laptops will go into C3 or C4, with USB enabled stays in C2.

On my laptop (Acer Travelmate 4001WLMi[1]) it's just the uhci-hcd driver.
Unloading it enables C3 again.

-- Johan

[1] http://www.squirrel.nl/people/jvromans/articles/TM4001WLMi/


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
