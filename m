From: Adam Olsen <adamo-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>
Subject: Re: Help with S3 on an Acer Travelmate c110 [SOLVED]
Date: Sun, 19 Jun 2005 10:34:29 -0600
Message-ID: <42B59E95.1070408@mindzion.com>
References: <42B43B7B.8000402@mindzion.com> <200506191425.11398.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506191425.11398.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan D=F6singer wrote:
> Read Documentation/power/video.txt in the kernel's source directory. Th=
is=20
> should help you ;-)

Thanks for the response.  I followed the documentation, but none of the=20
methods worked.  I did, however, find something in someone's blog=20
concerning a Travelmate c300 that mentioned a utility called video_post.=20
  This works - you have to switch to a VT and back to X to get it to=20
start working, but this is scriptable with chvt.

video_post wasn't easy to find via google - there are lots of posts=20
about it, but most links are broken... a forum post finally led me to=20
this link: http://bugzilla.kernel.org/show_bug.cgi?id=3D3670 and download=
=20
"attachment.cgi", which is actually a .tar.gz package.  I guess this is=20
just an FYI for anyone who might come accross the archive searching for=20
Travelmate c110.

Thanks,

Adam


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
