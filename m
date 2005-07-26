From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Fw: [PATCH]: Correctly locate RSDP in EBDA
Date: Tue, 26 Jul 2005 10:53:57 +0100
Message-ID: <1122371637.1101.12.camel@localhost.localdomain>
References: <20050725151313.730257bd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050725151313.730257bd.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Udo A. Steinberg" <us15-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Llu, 2005-07-25 at 15:13 -0700, Andrew Morton wrote:
>          * Scan memory looking for the RSDP signature. First search EBDA (low
>          * memory) paragraphs and then search upper memory (E0000-FFFFF).
>          */
> -       rsdp_phys = acpi_scan_rsdp (0, 0x400);
> +       rsdp_phys = acpi_scan_rsdp (*(u16*) 0x40E << 4, 0x400);

Close but no cookie. You need to read 0x40E from physical memory not
kernel virtual address space. It may also be zero which indicates that
there isn't an EBDA, sometimes interpreted as an EBDA in the top 1K or
so.




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
