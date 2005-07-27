From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Re: acpidump replaces acpidmp
Date: Wed, 27 Jul 2005 13:05:29 +0200
Message-ID: <42E76A79.2040702@suse.de>
References: <20050726192423.216b4be8.voluspa@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050726192423.216b4be8.voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Voluspa <voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Voluspa wrote:
> On 2005-07-23 0:35:38 Len Brown wrote:
> 
>>ps. I shall delete /proc/fadt and /proc/dsdt when I return
>>from Ottawa unless somebody can convince me they should live.
> 
> Please do not! Not until a reliable userspace program can be easily
> found for retrieving the dsdt on my pure X86_64 AMD system:
> 
> loke:sleipner:/home/net/acer/acpi/len_brown/pmtools-20050722$ uname -r
> 2.6.13-rc3
> loke:sleipner:/home/net/acer/acpi/len_brown/pmtools-20050722$ make
> for i in acpidump; do make -C $i all; done
> make[1]: Entering directory
> `/home/net/acer/acpi/len_brown/pmtools-20050722/acpidump'
> cc -Wall -Wstrict-prototypes -O2 -D_LINUX -DDEFINE_ALTERNATE_TYPES
> -I../include  acpidump.c -o acpidump
> In file included from acpidump.c:49:
> ../include/acpi/actypes.h:115: error: parse error before
> "acpi_native_int"
> ../include/acpi/actypes.h:115: warning: type defaults to `int' in
> declaration of `acpi_native_int'
> ../include/acpi/actypes.h:115: warning: data definition has no type or
> storage class
> acpidump.c: In function `acpi_dump_RSDT':
> acpidump.c:222: warning: cast to pointer from integer of different size
> acpidump.c:246: warning: cast to pointer from integer of different size
> acpidump.c:259: warning: cast to pointer from integer of different size
> acpidump.c:266: warning: cast to pointer from integer of different size
> acpidump.c:308: warning: cast to pointer from integer of different size
> acpidump.c:350: warning: cast to pointer from integer of different size
> acpidump.c:357: warning: cast to pointer from integer of different size
> acpidump.c: In function `acpi_dump_XSDT':
> acpidump.c:425: warning: cast to pointer from integer of different size
> acpidump.c:438: warning: cast to pointer from integer of different size
> make[1]: *** [acpidump] Error 1
> make[1]: Leaving directory
> `/home/net/acer/acpi/len_brown/pmtools-20050722/acpidump'
> make: *** [all] Error 2
> 
../include/acpi/actypes.h:115
Replace s64 with u64 and it at least compiles.
I tried it out on two (x86_64) machines.
On the one I got no output at all, on the other I got a segfault in
acpidump.c:104.

Why is acpidmp replaced?

Thanks,

       Thomas


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
