From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: 2.6.12-rc2-mm1 fails to build with my config - acpi related
Date: Tue, 5 Apr 2005 18:40:36 -0700
Message-ID: <20050405184036.232068c6.akpm@osdl.org>
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


urgh.  My patch isn't extensice enough to fix all of this.


Begin forwarded message:

Date: Tue, 5 Apr 2005 22:46:24 +0200 (CEST)
From: Jesper Juhl <juhl-lkml-poRShpWsAiE@public.gmane.org>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: 2.6.12-rc2-mm1 fails to build with my config - acpi related



I get this when trying to build 2.6.12-rc2-mm1 : 

  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:96: error: parse error before "acpi_sci_flags"
arch/i386/kernel/setup.c:96: warning: type defaults to `int' in declaration of `acpi_sci_flags'
arch/i386/kernel/setup.c:96: warning: data definition has no type or storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:811: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:814: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:817: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c:820: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c: In function `setup_arch':
arch/i386/kernel/setup.c:1571: warning: implicit declaration of function `acpi_boot_table_init'
arch/i386/kernel/setup.c:1572: warning: implicit declaration of function `acpi_boot_init'
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2

If I enable CONFIG_ACPI all is well - it seems some things get enabled by 
CONFIG_ACPI_BOOT regardless of CONFIG_ACPI being defined, this causes 
things to break since some of the stuff CONFIG_ACPI_BOOT enables depends 
on things only enabled in include/linux/acpi.h when CONFIG_ACPI is set...


-- 
Jesper Juhl


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
