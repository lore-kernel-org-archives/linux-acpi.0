From: kernel-UNdit3cmHfQ@public.gmane.org
Subject: Re: Fw: Re: 2.6.11.4: ACPI, IRQ 11 disabled, Ethernet/USB stops working
Date: Wed, 23 Mar 2005 07:38:11 -0800
Message-ID: <42418D63.4040507@zogi.de>
References: <20050323023704.502ecc6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050323023704.502ecc6a.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi Andrew,

Andrew Morton wrote:
> What could cause this??

I have some more infos:

I still get a bunch of error messages and really strange behavior.

The messages are basically like this:

Mar 22 19:50:46 thetis kernel:      osl-0958 [32] os_wait_semaphore 
: Failed to acquire semaphore[df7dd560|1|0], AE_TIME
Mar 22 19:50:46 thetis kernel:      osl-0958 [32] os_wait_semaphore 
: Failed to acquire semaphore[df7dd560|1|4095], AE_TIME
Mar 22 19:50:46 thetis kernel:  exmutex-0272: *** Error: Thread 12 
cannot release Mutex [MUT1] acquired by thread 1950
Mar 22 19:50:46 thetis kernel:  psparse-1138: *** Error: Method 
execution failed [\_SB_.RDEC] (Node c14698a8), AE_AML_NOT_OWNER
Mar 22 19:50:46 thetis kernel:  psparse-1138: *** Error: Method 
execution failed [\_TZ_.TZCR._TMP] (Node df683c28), AE_AML_NOT_OWNER
Mar 22 20:19:10 thetis kernel:      osl-0958 [37] os_wait_semaphore 
: Failed to acquire semaphore[df7dd560|1|0], AE_TIME
Mar 22 20:19:10 thetis kernel:      osl-0958 [37] os_wait_semaphore 
: Failed to acquire semaphore[df7dd560|1|4095], AE_TIME
Mar 22 20:19:10 thetis kernel:  exmutex-0272: *** Error: Thread 1950 
cannot release Mutex [MUT1] acquired by thread 12
Mar 22 20:19:10 thetis kernel:  psparse-1138: *** Error: Method 
execution failed [\_SB_.RDEC] (Node c14698a8), AE_AML_NOT_OWNER
Mar 22 20:19:10 thetis kernel:  psparse-1138: *** Error: Method 
execution failed [\_SB_.BAT1._BIF] (Node df6834e8), AE_AML_NOT_OWNER
Mar 22 20:19:10 thetis kernel: acpi_battery-0147 [24] 
acpi_battery_get_info : Error evaluating _BIF
Mar 22 20:19:10 thetis kernel: acpi_thermal-0463 [12] 
acpi_thermal_critical : Critical trip point
Mar 22 20:19:10 thetis kernel: Critical temperature reached (204 C), 
shutting down.
Mar 22 20:19:11 thetis kernel: Critical temperature reached (44 C), 
shutting down.

Monitoring for example the temperature, I see that there are spikes in 
the distribution, e.g. a jump from 45 to 5 degrees for very short time 
period (*one* update cycle ??). Or some times the battery capacity seems 
to fall to zero or jump to core-melt ;-)

This happens more likely in the moment I insert an USB device, but also 
without any changes...

I am not the only one how is experiencing this problem. The other 
persons how tried to install Linux on a Toshiba M45 S331 face the same 
problems.

One suggestion was a faulty ACPI / DSDT, which makes the ACPI & USB 
system unstable - but none of us is an expert in this field...

Thanks for any help,
Andreas


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
