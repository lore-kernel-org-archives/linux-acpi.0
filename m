From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Help with S3 on an Acer Travelmate c110 [SOLVED]
Date: Mon, 20 Jun 2005 11:42:48 +0200
Message-ID: <20050620094248.GA3121@elf.ucw.cz>
References: <42B43B7B.8000402@mindzion.com> <200506191425.11398.stefandoesinger@gmx.at> <42B59E95.1070408@mindzion.com> <200506192200.05982.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200506192200.05982.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Adam Olsen <adamo-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Read Documentation/power/video.txt in the kernel's source directory. This
> > > should help you ;-)
> >
> > Thanks for the response.  I followed the documentation, but none of the
> > methods worked.  I did, however, find something in someone's blog
> > concerning a Travelmate c300 that mentioned a utility called video_post.
> >   This works - you have to switch to a VT and back to X to get it to
> > start working, but this is scriptable with chvt.
> >
> > video_post wasn't easy to find via google - there are lots of posts
> > about it, but most links are broken... a forum post finally led me to
> > this link: http://bugzilla.kernel.org/show_bug.cgi?id=3670 and download
> > "attachment.cgi", which is actually a .tar.gz package.  I guess this is
> > just an FYI for anyone who might come accross the archive searching for
> > Travelmate c110.
> This method should be listed there. Well, it's not listed under this name, but 
> there's a link to my(again outdated) Acer TM 800 howto which lists a few 
> simmilar tools

Can you provide documentation patch?

For now I did:

...but better solution would be welcome.

diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -64,6 +64,7 @@ Model                           hack (or
 ------------------------------------------------------------------------------
 Acer Aspire 1406LC		ole's late BIOS init (7), turn off DRI
 Acer TM 242FX			vbetool (6)
+Acer TM C110			http://bugzilla.kernel.org/show_bug.cgi?id=3670
 Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6)
 Acer TM 4052LCi		        s3_bios (2)
 Acer TM 636Lci			s3_bios vga=normal (2)

									Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
