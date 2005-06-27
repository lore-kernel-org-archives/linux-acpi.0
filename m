From: Danny Kukawka <dkukawka-l3A5Bk7waGM@public.gmane.org>
Subject: Re: hp omnibook xe4500 fan control
Date: Mon, 27 Jun 2005 11:41:44 +0200
Message-ID: <200506271141.45275.dkukawka@suse.de>
References: <42BE53EB.5050601@perli.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42BE53EB.5050601-MhksZLCqGG5eoWH0uzbU5w@public.gmane.org>
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

On Sunday 26 June 2005 09:06, Thomas Perl wrote:
> I'm having a problem with HP's Omnibook XE4500.
>
> I cannot control the fan using its /proc/acpi interface. There is a fan
> entry and I can try to set some options, however - they are not set
> effectively (seems like Linux isn't in control of the fan). I'd like to
> set the trip_points to some values so that the fan doesn't come on so
> often. Any hints on where to start? Or it is not possible on Linux anyway?
>
> There is a fan.exe on the diagnostic partition which switches the fan on
> and then off for diagnose purposes, so it _should_ be possible to
> control the fan by software.

Did you tried the omnibook kernel modules [1] ? They should also support th=
e =A0
XE4500. =A0=20

Danny

[1] http://sourceforge.net/projects/omke/

=2D-=20
Danny Kukawka
dkukawka-l3A5Bk7waGM@public.gmane.org
Mobile Devices
SUSE LINUX a Novell Business
Maxfeldstr. 5, D-90409 Nuernberg, Germany


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
