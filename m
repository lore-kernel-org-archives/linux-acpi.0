From: Colin Leroy <colin-5s/l0yV9g/OsTnJN9+BGXg@public.gmane.org>
Subject: Strange speedstep-related code in some DSDT
Date: Wed, 2 Nov 2005 15:00:10 +0100
Message-ID: <20051102140113.4B8E510334@paperstreet.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

After I upgraded the BIOS on an Asus M6B600C laptop, I found it to be
stuck at 600MHz. After investigating for a while using debug.cpufreq=3,
I found out that the DSDT looked strange, and after I fixed it, cpufreq
worked again.

The things I had to fix were mainly:
-            Name (APCT, Package (0x02)
+            Name (_PCT, Package (0x02)

and
-            Name (NPSS, 0x00)
-            Name (APSS, Package (0x0A)
+            Name (NPSS, 0x05)
+            Name (_PSS, Package (0x0A)

I am wondering whether such objects should be recognized, or is it
Asus' fault? I read somewhere that they ship a (windows-based)
proprietary speed controller software for their laptops, so they
probably don't care about specs in this regard.

Do you think a patch would be ok to handle these in
processor_perflib.c? 

Thanks,
(Please Cc: me on replies, as I'm not subscribed...)
-- 
Colin


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
