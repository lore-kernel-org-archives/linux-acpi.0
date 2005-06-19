From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Help with S3 on an Acer Travelmate c110
Date: Sun, 19 Jun 2005 14:25:11 +0000
Message-ID: <200506191425.11398.stefandoesinger@gmx.at>
References: <42B43B7B.8000402@mindzion.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42B43B7B.8000402-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>
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
Cc: Adam Olsen <adamo-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Adam,

> I was wondering if any of you could help me with suspend to ram on a
> travelmate c110.  I'm running kernel 2.6.10 on Hoary.
>
> It seems I can suspend, and sort of resume.   The machine seems to
> resume, but the display does not come back on.  I can issue commands
> like reboot, etc at the terminal I suspended from.  I cannot get the
> display to come back on whether or not I suspend from within X or just a
> plain terminal.
>
> Any ideas?
Read Documentation/power/video.txt in the kernel's source directory. This=20
should help you ;-)

Stefan D=F6singer


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
