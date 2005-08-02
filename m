From: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>
Subject: [patch 2/2] ACPI: increase PCIBIOS_MIN_IO on x86
Date: Wed, 3 Aug 2005 03:09:03 +0400
Message-ID: <20050803030903.E18001@jurassic.park.msu.ru>
References: <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru> <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org> <20050802205023.B16660@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org> <20050803011337.A18001@jurassic.park.msu.ru> <20050802212143.GA8738@kroah.com> <20050803014757.B18001@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021456070.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508021456070.3341-hNm40g4Ew95AfugRpC6u6w@public.gmane.org>; from torvalds-3NddpPZAyC0@public.gmane.org on Tue, Aug 02, 2005 at 02:57:19PM -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>, Stelian Pop <stelian-ibX4/ixPftWsTnJN9+BGXg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Erik Waling <erikw-Z3oqqNSG8ADLoDKTGw+V6w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

We have increased PCIBIOS_MIN_IO to 0x4000, but still want
motherboard resources to be allocated properly. So we need
to state 0x1000 (according to the comment) limit explicitely.

Signed-off-by: Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>

--- 2.5.13-rc5/drivers/acpi/motherboard.c	Fri Jun 17 23:48:29 2005
+++ linux/drivers/acpi/motherboard.c	Wed Aug  3 02:54:05 2005
@@ -43,7 +43,7 @@ ACPI_MODULE_NAME		("acpi_motherboard")
  */
 #define IS_RESERVED_ADDR(base, len) \
 	(((len) > 0) && ((base) > 0) && ((base) + (len) < IO_SPACE_LIMIT) \
-	&& ((base) + (len) > PCIBIOS_MIN_IO))
+	&& ((base) + (len) > 0x1000))
 
 /*
  * Clearing the flag (IORESOURCE_BUSY) allows drivers to use


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
