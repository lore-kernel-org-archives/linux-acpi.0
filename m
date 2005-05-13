From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Re: 2.6.12-rc4-mm1
Date: Fri, 13 May 2005 13:20:27 -0700
Message-ID: <20050513132027.239e0af4.akpm@osdl.org>
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

Date: Fri, 13 May 2005 21:40:16 +0200
From: Johannes Stezenbach <js-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: 2.6.12-rc4-mm1


Does not compile for CONFIG_ACPI=n & CONFIG_X86_HT=y (thus CONFIG_ACPI_BOOT=y):

  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:97: error: syntax error before "acpi_sci_flags"
arch/i386/kernel/setup.c:97: warning: type defaults to `int' in declaration of `acpi_sci_flags'
arch/i386/kernel/setup.c:97: warning: data definition has no type or storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:812: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:815: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:818: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c:821: error: request for member `polarity' in something not a structure or union
make[1]: *** [arch/i386/kernel/setup.o] Error 1


Johannes


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
