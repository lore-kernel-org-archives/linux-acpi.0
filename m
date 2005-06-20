From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Help with S3 on an Acer Travelmate c110 [SOLVED]
Date: Mon, 20 Jun 2005 22:45:15 +0200
Message-ID: <20050620204515.GB1873@elf.ucw.cz>
References: <42B43B7B.8000402@mindzion.com> <200506191425.11398.stefandoesinger@gmx.at> <42B59E95.1070408@mindzion.com> <200506192200.05982.stefandoesinger@gmx.at> <20050620094248.GA3121@elf.ucw.cz> <42B6DF19.9020103@mindzion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42B6DF19.9020103-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Olsen <adamo-VDTgcPsuuaZWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!
> >Can you provide documentation patch?
> 
> How's this?  I changed the Travelmate C300 entry because the 
> documentation I found to get the C110 working was actually for the C300 
> - it just happened to work for the C110 too 
> (http://www.umich2.com/files/2004/12/linux_on_the_ac.html).

I don't like to group various machines together, so I ended up with:

								Pavel

diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -46,6 +46,12 @@ There are a few types of systems where v
   POSTing bios works. Ole Rohne has patch to do just that at
   http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2.
 
+(8) on some systems, you can use the video_post utility mentioned here:
+  http://bugzilla.kernel.org/show_bug.cgi?id=3670. Do echo 3 > /sys/power/state
+  && /usr/sbin/video_post - which will initialize the display in console mode.
+  If  you are in X, you can switch to a virtual terminal and back to X using
+  CTRL+ALT+F1 - CTRL+ALT+F7 to get the display working in graphical mode again.
+
 Now, if you pass acpi_sleep=something, and it does not work with your
 bios, you'll get a hard crash during resume. Be careful. Also it is
 safest to do your experiments with plain old VGA console. The vesafb
@@ -64,7 +70,8 @@ Model                           hack (or
 ------------------------------------------------------------------------------
 Acer Aspire 1406LC		ole's late BIOS init (7), turn off DRI
 Acer TM 242FX			vbetool (6)
-Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6)
+Acer TM C110			video_post (8)
+Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6) or video_post (8)
 Acer TM 4052LCi		        s3_bios (2)
 Acer TM 636Lci			s3_bios vga=normal (2)
 Acer TM 650 (Radeon M7)		vga=normal plus boot-radeon (5) gets text console back


								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
