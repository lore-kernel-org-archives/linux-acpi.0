From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: Information regarding C3 cpu state and bus mastering activity
Date: Mon, 12 Dec 2005 13:47:39 +0100
Message-ID: <439D716B.3010705@tzi.de>
References: <da5cd1900512111210k626ff691x@mail.gmail.com> <439CC549.5060500@tzi.de> <439CF197.3090902@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <439CF197.3090902-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
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



Phillip Susi wrote:
> I'm kind of confused as to why this is a problem myself.  Yes, the CPU 
> cache does not snoop the busmaster activity and so the cache can become 
> out of sync with ram, but isn't it the job of the driver that initiates 
> the dma transfer to invalidate those cache lines once the transfer is 
> complete to bring the cache back into sync?

Normally a cache should be completely hidden from the system, so a 
driver can never determine the actually state of the cache. Only way to 
sync the cache is to completely flush it.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
