From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] eeepc-laptop: add base driver
Date: Wed, 23 Apr 2008 00:57:11 -0400
Message-ID: <200804230057.11842.lenb@kernel.org>
References: <200803131254.01518.corentincj@iksaif.net>
	<200803131255.47155.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200803131255.47155.corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eeecommunity-donated-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 13 March 2008, Corentin CHARY wrote:
> From: Eric Cooper <ecc-D+Gtc/HYRWM@public.gmane.org>
> 
> This patch is based on Eric Cooper's work to clean the original asus_acpi
> given by Asus.  It's a platform driver (/sys/devices/platform/eeepc/)
> wich support:
>      - hotkeys - wlan on/off - camera on/off - cardr on/off
> 
> Signed-off-by: Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
> ---
> 
>  Kconfig        |   11 +
>  Makefile       |    1 
>  eeepc-laptop.c |  442 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 454 insertions(+)

Why no MAINTAINERS entry?

scripts/checkpatch.pl ~/src/linus/eeepc1.patch
WARNING: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
#94: FILE: drivers/misc/eeepc-laptop.c:26:
+#include <asm/uaccess.h>

total: 0 errors, 1 warnings, 461 lines checked

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
