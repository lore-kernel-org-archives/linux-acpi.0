From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Information regarding C3 cpu state and bus mastering activity
Date: Mon, 12 Dec 2005 13:51:58 +0100
Message-ID: <439D726E.4020704@tzi.de>
References: <da5cd1900512111210k626ff691x@mail.gmail.com>	 <439CC549.5060500@tzi.de> <da5cd1900512120122y217541a2h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <da5cd1900512120122y217541a2h-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Marco Calviani wrote:
> Is this an hardware limitation or a software one?
> If i understood well this occur because the active bus polling that is
> required to maintain communication with usb devices deny the CPU from
> switching to C3, and even if there are no usb device connected but the
> modules are loaded the polling prevent the switch.
> Will it be possible to increase the polling time, so that maybe the
> CPU can enter that state?
> 
Okay, I read through this stuff once again. I would say, that busmaster 
activity is a direct write into memory. While the processor is in C3, it 
can not keep it's cache in sync with the memory. So there are two 
solutions to this problem for uniprocessor systems:
1. Either you flush the cache before entering C3. This takes a relative 
long period of time (according to ACPI 3.0 spec) so it should not be the 
prefered method.
2. Disable the busmaster. The kernel looks at the current busmaster 
activity and then chooses if it wants to disable busmaster and enter C3.

After reading through the spec again, I would revoke my first comment 
and say that with a bit of policytuning you could enter C3 even with a 
USB mouse plugged in.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
