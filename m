From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Cannot take over thermal management
Date: Mon, 25 Jul 2005 13:22:55 +0200
Message-ID: <20050725112255.GA968@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi!
  I'm here again with a question regarding my notebook Clevo D610SU.
  I would like to let Linux do the thermal management, but it seems that it's
totally impossible.
  It seems that EC is hardly controlling the fans independently on anything I'm
trying to do.
  Totally independently on setting trip points or anything else, once the
temperature increases above 55 C, the fans start (they start at full speed
and about a second later they slow down to half speed) and they continue
until the temperature is below 45 C.
  The DSDT implements a THM0 thermal zone, which allows to read a CPU temp.
Its contents is the following:
root@miro:/proc/acpi/thermal_zone/THM0# cat *
cooling mode:   active
polling frequency:       5 seconds
state:                   ok
temperature:             47 C
critical (S5):           90 C
passive:                 80 C: tc1=4 tc2=10 tsp=50 devices=0xdbeedae8
The polling freq and trip points are set by me but as written above, they
are ignored. I cannot modify these tc1=4 tc2=10 tsp=50.
  The DSDT doesn't implement any FAN object. I see fields called FAN0 and
FAN1 in EC's RAM but they always read as 0 regardless of whether the fans
are on or off.
  My friend having the same NB with windoze told me (unverified) that he can
control the fans and thermal management from windoze.
  I'm sorry for my maybe naive questions :-).
                                     With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
