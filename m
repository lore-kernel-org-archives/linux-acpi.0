From: Andrew Haninger <ahaning-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: hp omnibook xe4500 fan control
Date: Sun, 26 Jun 2005 22:52:18 -0400
Message-ID: <105c793f050626195219bb787c@mail.gmail.com>
References: <42BE53EB.5050601@perli.net>
Reply-To: Andrew Haninger <ahaning-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: thp-MhksZLCqGG5eoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 6/26/05, Thomas Perl <thp-MhksZLCqGG5eoWH0uzbU5w@public.gmane.org> wrote:
> I'd like to set the trip_points to some values so that the fan doesn't
> come on so often. Any hints on where to start? Or it is not possible
> on Linux anyway?
FWIW, here are the lines I use to turn the fan on and off on my
Gateway SOLO 2500 (~5-6 years old so it requires acpi=3Dforce in the
boot parameters):

This one makes the fan turn on when the CPU is at 20degC (so, all the
time since it idles around 30degC):
echo "80:0:70:20:0" > /proc/acpi/thermal_zone/THRM/trip_points

This one makes the fan turn on when the CPU is at 60degC; so only
under with long CPU-intensive stuff (default):
echo "80:0:70:60:0" > /proc/acpi/thermal_zone/THRM/trip_points

This turns on the fan immediately:
echo 0 > /proc/acpi/fan/FAN/state

This turns off the fan immediately:
echo 3 > /proc/acpi/fan/FAN/state


I don't know why you echo 3 to turn off the fan and 0 to turn on the
fan and not 0 to turn off the fan and 1 to turn on the fan; or, better
"on" and "off". That's what works for me. I have these in tiny scripts
so I don't have to remember them.

They don't always work, though, so sometimes I have to run my script
to turn on the fan, then the one to turn off the fan, and then the one
to turn on the fan to get the fan to turn on. Very confusing, but it
works.

Hope this helps.

-Andy


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
