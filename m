From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Fix xconfig in 2.4-ACPI latest
Date: Thu, 20 Nov 2003 21:51:08 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031120215108.GP30485@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0311200838380.17057-100000@v8.miniserver.de> <20031120163200.GK30485@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031120163200.GK30485-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 20, 2003 at 04:32:00PM +0000, Matthew Wilcox wrote:
> Maybe the tk program is having trouble parsing this:
> 
> +  else if [ "$CONFIG_SMP" = "y" ]; then

I just figured out why I couldn't reproduce this problem.  Oops.
Len, can you apply this patch for 2.4 ASAP?  Otherwise people
using xconfig won't be able to configure their kernels.

diff -u b/drivers/acpi/Config.in linux-2.4/drivers/acpi/Config.in
--- b/drivers/acpi/Config.in    Wed Oct  1 01:10:29 2003
+++ linux-2.4/drivers/acpi/Config.in    20 Nov 2003 21:45:57 -0000
@@ -32,7 +32,8 @@
     tristate     '  Toshiba Laptop Extras'     CONFIG_ACPI_TOSHIBA
     bool         '  Debug Statements'  CONFIG_ACPI_DEBUG
     bool         '  Relaxed AML Checking'      CONFIG_ACPI_RELAXED_AML
-  else if [ "$CONFIG_SMP" = "y" ]; then
+  else
+    if [ "$CONFIG_SMP" = "y" ]; then
       define_bool CONFIG_ACPI_BOOT             y
     fi
   fi

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
