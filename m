From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Problems with Kernel 2.6.13.2 and Acer Travelmate 4002lmi
Date: Wed, 28 Sep 2005 15:49:27 +0800
Message-ID: <200509281549.27119.luming.yu@intel.com>
References: <43398299.80809@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43398299.80809-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Content-Disposition: inline
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
Cc: Simon <SimonLa-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 28 September 2005 01:34, Simon wrote:
	> Hallo everybody,
>
> I have a problem with kernel 2.6.13.2 and my notebook Acer Travelmate
> 4002lmi(SBS battery). I have used Suse 9.3 with Kernel 2.6.8 and a patched
> DSDT from the https://sourceforge.net/projects/sbs-linux/ package. All work
> fine. Now I have install Opensuse 10.0 RC1 with Kernel 2.6.13 and when I am
> activate ACPI the kernel needs 20 seconds to boot and the following Warning
> appears in the boot log and in the kernel log:
>
> <6>ACPI: Embedded Controller [EC0] (gpe 29)
> <4>    ACPI-1048: *** Warning: Failed to acquire semaphore[dfec5960|1|0],
> AE_TIME

Please test 2.6.14-rc1 or later, boot kernel with ec_burst=1.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
