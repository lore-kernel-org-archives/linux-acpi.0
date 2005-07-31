From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: 2.6.13-rc4: /proc/acpi/event doesn't report any events - SOLVED (ec_polling needed)
Date: Sun, 31 Jul 2005 09:13:26 +0200
Message-ID: <20050731071326.GA12293@tangens.sinus.cz>
References: <20050730190341.GA4108@miro.sinus.cz> <E1DyxVU-000202-00@skye.ra.phy.cam.ac.uk> <20050731052525.GA4649@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050731052525.GA4649-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
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


Hi!
  I've finally found why I had so strong intuition that the solution is very
near :-).
  The problem is that -in -rc4 there is not the famous ec_polling patch which
I need... After patching it again it started to work again.
  I've found that the deferred function is really called and that it is
acpi_ce_gpe_query(). Without the ec_polling patch, a "burst variant" of the
query is called, which doesn't work here.
  So I vote for inserting ec_polling patch to 2.6.13-final..

                              WIth regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
