From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Re: 2.6.12-rc2-mm2
Date: Fri, 8 Apr 2005 16:45:18 -0700
Message-ID: <20050408164518.1f12e35c.akpm@osdl.org>
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



Begin forwarded message:

Date: Sat, 9 Apr 2005 01:28:47 +0200 (CEST)
From: Jesper Juhl <juhl-lkml-poRShpWsAiE@public.gmane.org>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: 2.6.12-rc2-mm2


On Fri, 8 Apr 2005, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> 

Still doesn't build for me with my usual config (available upon request) 
unless I enable ACPI :

...
  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:96: error: parse error before "acpi_sci_flags"
arch/i386/kernel/setup.c:96: warning: type defaults to `int' in declaration of `acpi_sci_flags'
arch/i386/kernel/setup.c:96: warning: data definition has no type or storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:811: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:814: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:817: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c:820: error: request for member `polarity' in something not a structure or union
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2



-- 
Jesper Juhl


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
