From: pumpkin <pumpkin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: C2, C3 and bus master activity
Date: Thu, 21 Jul 2005 19:31:58 +0200
Message-ID: <200507211931.58172.pumpkin@gmx.de>
References: <200507192050.28343.pumpkin@gmx.de> <200507202129.33823.pumpkin@gmx.de> <42DEB3E8.6080601@tzi.de>
Reply-To: pumpkin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42DEB3E8.6080601-cGBD8117FJM@public.gmane.org>
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
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello

> This is interesting, I have a theory why the IBM laptops keep crashing
> when you use the the deeper sleep states.=20

Well,... i don't really understand what is going on here.=20

=46rom time-to-time Xorg tries to load and crashs even before starting the =
new=20
logfile. But if it gets past that point everything works fine. And even wit=
h=20
the stock kernel and every module (including ieee1394...) loaded the CPU=20
enters C4. The BIOS/CMOS/Laptop... whatever has changed it's behavior after=
=20
my first tests. Maybe it has something to do with running of AC or battery.

Once i have the time to an intensive test with all combinations (w/ and w/o=
=20
battery, w/ and w/o AC, w/ and w/o 1394 at startup ... ) i will send you my=
=20
results. Any logs/files that are important to you ?

> Can you try out something for=20
> me ?

Sure, but not today. I will recompile the kernel once again but with debugg=
ing=20
enabled.=20

cu

> First try to load or do something, that would cause your laptop to
> disable the C4 state. If this hapens, you shuld see in your logs (as
> long as you compiled your kernel with debug messages) something like
> \_SB.CPU0, 0x81. This means, that your laptop has changed the available
> C-States. (this should also appear, if you unload eee1394, eth1394 and
> ohic1394)
>
> I saw some places in the ACPI code, where the C-States are not correctly
> deleted after this event, and my theory is that this actually crashes
> some IBM laptops.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
