From: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Subject: Re: Thinkpad A21m oops when go to sleep second time
Date: Mon, 18 Jul 2005 00:18:36 +0200
Message-ID: <42DAD93C.4060602@mydatex.cz>
References: <16A54BF5D6E14E4D916CE26C9AD3057502A49971@pdsmsx402.ccr.corp.intel.com> <42D62E48.3030306@mydatex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42D62E48.3030306-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Daniel Smolik napsal(a):
> Li, Shaohua napsal(a):
> 
>> Hi,
>>
>>>> [<c020c9be>] uart_suspend_port+0xde/0xf0
>>>
>>>
>>> This is in the serial code. The problem seems to be that not all serial
>>> ports are found on resume. Take a look at the following boot-time dmesg
>>> output:
>>>
>>> [4294670.599000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>> [4294670.599000] ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
>>> [4294670.601000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>>
>>> Note that ttyS0 is found twice. After resume, ttyS0 is still available,
>>> but ttyS2 now gives ENODEV. If the device was held open over suspend,
>>> then the next suspend explodes when it tries to suspend the second
>>> serial device.
>>
>>
>> How about disable pnpacpi?
>>
>> Thanks,
>> Shaohua
>>
> I disable PNP ACPI ,disable detect Serial port via ACPI. Serial port is 
> now detected right but system still oops after second sleep.
I compile 2.6.13-rc3 with ACPI debuging and when I do echo 3 > 
/proc/acpi/sleep second time system freeze an on console I see this.

Stopping tasks:=======================|
osl-961 [35] os_wait_semaphore : Failed to acquire 
semaphore[cbfee4e0|1|0],AE_TIME

		Dan




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
