From: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Subject: Re: Thinkpad A21m oops when go to sleep second time
Date: Thu, 14 Jul 2005 11:20:08 +0200
Message-ID: <42D62E48.3030306@mydatex.cz>
References: <16A54BF5D6E14E4D916CE26C9AD3057502A49971@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057502A49971-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Li, Shaohua napsal(a):
> Hi,
> 
>>>[<c020c9be>] uart_suspend_port+0xde/0xf0
>>
>>This is in the serial code. The problem seems to be that not all serial
>>ports are found on resume. Take a look at the following boot-time dmesg
>>output:
>>
>>[4294670.599000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>[4294670.599000] ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
>>[4294670.601000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>
>>Note that ttyS0 is found twice. After resume, ttyS0 is still available,
>>but ttyS2 now gives ENODEV. If the device was held open over suspend,
>>then the next suspend explodes when it tries to suspend the second
>>serial device.
> 
> How about disable pnpacpi?
> 
> Thanks,
> Shaohua
> 
I disable PNP ACPI ,disable detect Serial port via ACPI. Serial port 
is now detected right but system still oops after second sleep.


			Dan



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
