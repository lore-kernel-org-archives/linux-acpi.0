From: Horms <horms-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: gnome-applets: battstat don't show correct values at startup on some hardware
Date: Thu, 10 Nov 2005 11:12:07 +0900
Message-ID: <20051110021207.GA14216@verge.net.au>
References: <20050309202119.GA8086@pc-innocenti.cineca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050309202119.GA8086-z9AggUaaQxwjA1nC/a+z+WLCm2T5Ec0j@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marco Innocenti <dot0037-p0aYb1w59bp+nBQpE4LXFjUZDU+1vuVT@public.gmane.org>
Cc: 298766-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Mar 09, 2005 at 09:21:19PM +0100, Marco Innocenti wrote:
> Battstat on my laptop (Toshiba P20-311) don't show the correct value
> of the charge of the battery at startup. I have to wait several
> minutes to get it.  I've made some test and discoveded that "cat
> /proc/acpi/battery/BAT1/*" give the wrong value the first few time.
> So I patched battstat_applet.c to get acpiinfo 10 times at startup.
> It works for me and don't think would harm others.

[snip]

Hi Marco,

As discussed breifly on http://bugs.debian.org/298766, this is probably
a problem better solved in the kernel than in user-space.  I have CCed
the ACPI maintainers on this message for their consideration, including
your patch, which is below.

-- 
Horms

diff -r -u gnome-applets-2.8.2.orig/battstat/battstat_applet.c gnome-applets-2.8.2/battstat/battstat_applet.c
--- gnome-applets-2.8.2.orig/battstat/battstat_applet.c	2005-03-09 20:58:00.302510520 +0100
+++ gnome-applets-2.8.2/battstat/battstat_applet.c	2005-03-09 17:24:47.000000000 +0100
@@ -232,7 +232,7 @@
 
 #ifdef __linux__
 struct acpi_info acpiinfo;
-gboolean using_acpi;
+gboolean using_acpi, started_now=TRUE;
 int acpi_count;
 #endif
 
@@ -310,6 +310,14 @@
    * Updated by David Moore <dcm-HInyCGIudOg@public.gmane.org> 5/29/2003 to poll less and
    *   use ACPI events. */
   if (using_acpi && acpiinfo.event_fd >= 0) {
+    /* By Marco Innocenti <m.innocenti-qooieK91W7JeoWH0uzbU5w@public.gmane.org> 09/03/2005
+     * Some hardware need several requests to warm up and give correct results. */
+    if (started_now) {
+	started_now=FALSE;
+	for (acpi_count=1; acpi_count < 10; acpi_count++) {
+	    acpi_linux_read(&apminfo, &acpiinfo);
+	}
+    }
     if (acpi_count <= 0) {
       /* Only call this one out of 30 calls to apm_readinfo() (every 30 seconds)
        * since reading the ACPI system takes CPU cycles. */


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
