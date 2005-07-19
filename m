From: moe <moe-9AEwkcPRwFQ@public.gmane.org>
Subject: make APM suspend call while acpi enabled?
Date: Wed, 20 Jul 2005 00:57:04 +0200
Message-ID: <20050719225703.GB8872@widecut.net>
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

hi,

is there a way to make APM standby/suspend calls even though
ACPI is enabled in the kernel?

i have a jvc 731 subnotebook that behaves like this:

with ACPI enabled in the kernel...

- battery status is reported fine (both batteries detected)
- button-/lid-events are reported
- suspend doesnt work (all modes lead to freeze)

with APM enabled...

- battery status is always reported as "On-line"
  no matter whether its plugged in
- no button or lid events
- apm -s (suspend) and -S (standby) work fine

obviously, i'd like the best of both worlds.

so, anyone know a utility that allows me to fire the necessary
apm calls for standby/suspend without kernel support?

is that even possible?


best regards
moe



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
