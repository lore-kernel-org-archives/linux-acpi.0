From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Fix acpi video extensions documentation
Date: Sat, 25 Dec 2004 22:03:30 +0100
Message-ID: <20041225210330.GA20084@elf.ucw.cz>
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Well... this fixes it a bit, killing few typos. A lot better docs is
needed, but lets start small. Please apply,
								Pavel

--- clean/Documentation/power/video_extension.txt	2004-12-25 13:34:57.000000000 +0100
+++ linux/Documentation/power/video_extension.txt	2004-12-25 22:02:11.000000000 +0100
@@ -1,13 +1,16 @@
-This driver implement the ACPI Extensions For Display Adapters
-for integrated graphics devices on motherboard, as specified in
-ACPI 2.0 Specification, Appendix B, allowing to perform some basic
-control like defining the video POST device, retrieving EDID information
-or to setup a video output, etc.  Note that this is an ref. implementation only.
-It may or may not work for your integrated video device.
+ACPI video extensions
+~~~~~~~~~~~~~~~~~~~~~
+
+This driver implement the ACPI Extensions For Display Adapters for
+integrated graphics devices on motherboard, as specified in ACPI 2.0
+Specification, Appendix B, allowing to perform some basic control like
+defining the video POST device, retrieving EDID information or to
+setup a video output, etc.  Note that this is an ref. implementation
+only.  It may or may not work for your integrated video device.
 
 Interfaces exposed to userland through /proc/acpi/video:
 
-VGA/info : display the supported video bus device capability like ,Video ROM, CRT/LCD/TV.
+VGA/info : display the supported video bus device capability like Video ROM, CRT/LCD/TV.
 VGA/ROM :  Used to get a copy of the display devices' ROM data (up to 4k).
 VGA/POST_info : Used to determine what options are implemented.
 VGA/POST : Used to get/set POST device.
@@ -15,7 +18,7 @@
 	Please refer ACPI spec B.4.1 _DOS
 VGA/CRT : CRT output
 VGA/LCD : LCD output
-VGA/TV : TV output 
+VGA/TVO : TV output 
 VGA/*/brightness : Used to get/set brightness of output device
 
 Notify event through /proc/acpi/event:
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
