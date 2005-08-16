From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpidump replaces acpidmp
Date: Tue, 16 Aug 2005 14:23:25 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300456A26A@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Mats,
Does the latest acpidump work for you now?
can we obsolete /proc/acpi/fadt,dsdt?

thanks,
-Len=20

>-----Original Message-----
>From: Voluspa [mailto:voluspa-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org]=20
>Sent: Tuesday, July 26, 2005 1:24 PM
>To: Brown, Len
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: acpidump replaces acpidmp
>
>
>On 2005-07-23 0:35:38 Len Brown wrote:
>
>>ps. I shall delete /proc/fadt and /proc/dsdt when I return
>>from Ottawa unless somebody can convince me they should live.
>
>Please do not! Not until a reliable userspace program can be easily
>found for retrieving the dsdt on my pure X86_64 AMD system:
>
>loke:sleipner:/home/net/acer/acpi/len_brown/pmtools-20050722$ uname -r
>2.6.13-rc3
>loke:sleipner:/home/net/acer/acpi/len_brown/pmtools-20050722$ make
>for i in acpidump; do make -C $i all; done
>make[1]: Entering directory
>`/home/net/acer/acpi/len_brown/pmtools-20050722/acpidump'
>cc -Wall -Wstrict-prototypes -O2 -D_LINUX -DDEFINE_ALTERNATE_TYPES
>-I../include  acpidump.c -o acpidump
>In file included from acpidump.c:49:
>../include/acpi/actypes.h:115: error: parse error before
>"acpi_native_int"
>../include/acpi/actypes.h:115: warning: type defaults to `int' in
>declaration of `acpi_native_int'
>../include/acpi/actypes.h:115: warning: data definition has no type or
>storage class
>acpidump.c: In function `acpi_dump_RSDT':
>acpidump.c:222: warning: cast to pointer from integer of different size
>acpidump.c:246: warning: cast to pointer from integer of different size
>acpidump.c:259: warning: cast to pointer from integer of different size
>acpidump.c:266: warning: cast to pointer from integer of different size
>acpidump.c:308: warning: cast to pointer from integer of different size
>acpidump.c:350: warning: cast to pointer from integer of different size
>acpidump.c:357: warning: cast to pointer from integer of different size
>acpidump.c: In function `acpi_dump_XSDT':
>acpidump.c:425: warning: cast to pointer from integer of different size
>acpidump.c:438: warning: cast to pointer from integer of different size
>make[1]: *** [acpidump] Error 1
>make[1]: Leaving directory
>`/home/net/acer/acpi/len_brown/pmtools-20050722/acpidump'
>make: *** [all] Error 2
>
>Mvh
>Mats Johannesson
>--
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
