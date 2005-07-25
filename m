From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Cannot take over thermal management
Date: Mon, 25 Jul 2005 18:10:57 +0200
Message-ID: <20050725161056.GC1046@openzaurus.ucw.cz>
References: <20050725112255.GA968@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050725112255.GA968-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

>   I'm here again with a question regarding my notebook Clevo D610SU.
>   I would like to let Linux do the thermal management, but it seems that it's
> totally impossible.

Yep, thats true :-).

You may have some luck with lm_sensors (dangerous!).

>   It seems that EC is hardly controlling the fans independently on anything I'm
> trying to do.
>   Totally independently on setting trip points or anything else, once the
> temperature increases above 55 C, the fans start (they start at full speed
> and about a second later they slow down to half speed) and they continue
> until the temperature is below 45 C.

Use passive cooling to make sure it never exceeds 54C :-). 
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
