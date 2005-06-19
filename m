From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Help with S3 on an Acer Travelmate c110 [SOLVED]
Date: Sun, 19 Jun 2005 22:00:05 +0000
Message-ID: <200506192200.05982.stefandoesinger@gmx.at>
References: <42B43B7B.8000402@mindzion.com> <200506191425.11398.stefandoesinger@gmx.at> <42B59E95.1070408@mindzion.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42B59E95.1070408-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>
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

On Sunday 19 June 2005 16:34, Adam Olsen wrote:
> Stefan D=F6singer wrote:
> > Read Documentation/power/video.txt in the kernel's source directory. Th=
is
> > should help you ;-)
>
> Thanks for the response.  I followed the documentation, but none of the
> methods worked.  I did, however, find something in someone's blog
> concerning a Travelmate c300 that mentioned a utility called video_post.
>   This works - you have to switch to a VT and back to X to get it to
> start working, but this is scriptable with chvt.
>
> video_post wasn't easy to find via google - there are lots of posts
> about it, but most links are broken... a forum post finally led me to
> this link: http://bugzilla.kernel.org/show_bug.cgi?id=3D3670 and download
> "attachment.cgi", which is actually a .tar.gz package.  I guess this is
> just an FYI for anyone who might come accross the archive searching for
> Travelmate c110.
This method should be listed there. Well, it's not listed under this name, =
but=20
there's a link to my(again outdated) Acer TM 800 howto which lists a few=20
simmilar tools

> * radeon systems, where X can soft-boot your video card. You'll need
>  patched X, and plain text console (no vesafb or radeonfb), see
>  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)

Well, it's fine that you got it working!

Stefan


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
