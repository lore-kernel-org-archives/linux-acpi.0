From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: hp omnibook xe4500 fan control
Date: Mon, 27 Jun 2005 09:35:52 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575026989E9@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: thp-MhksZLCqGG5eoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>Hello, List!
>
>I'm having a problem with HP's Omnibook XE4500.
>
>I cannot control the fan using its /proc/acpi interface. There is a fan
>entry and I can try to set some options, however - they are not set
>effectively (seems like Linux isn't in control of the fan). I'd like to
>set the trip_points to some values so that the fan doesn't come on so
>often. Any hints on where to start? Or it is not possible on Linux
anyway?
>
>There is a fan.exe on the diagnostic partition which switches the fan
on
>and then off for diagnose purposes, so it _should_ be possible to
>control the fan by software.
IIRC, fan device is a dummy device in many systems. That is acpi can't
really control fan. Your system might be such one. Sure, it's just my
guess :), did you see any error messages printed out? fan.exe might use
other methods like i2c.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
