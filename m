From: Phillip Susi <psusi-3tLf1voIkJTQT0dZR+AlfA@public.gmane.org>
Subject: Re: Information regarding C3 cpu state and bus mastering activity
Date: Mon, 12 Dec 2005 11:08:01 -0500
Message-ID: <439DA061.2060500@cfl.rr.com>
References: <da5cd1900512111210k626ff691x@mail.gmail.com> <439CC549.5060500@tzi.de> <439CF197.3090902@cfl.rr.com> <439D716B.3010705@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <439D716B.3010705-cGBD8117FJM@public.gmane.org>
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

Caching is never _completely_ hidden from the kernel.  I am not as 
familiar with the internals of the linux kernel as I am with NT, but I 
imagine it would have to be similar.  On NT drivers issuing hardware DMA 
transfers must call functions in the HAL to facilitate the process.  On 
Intel platforms, the hardware generally maintains cache coherency across 
multiple processors and bus masters, but this is not true on all 
platforms.  Many non Intel platforms' caches do not support bus snooping 
( as indeed, there may not even BE a bus that is shared between all 
processors and bus masters and memory modules ) so it is up to the HAL 
functions to make sure the caches stay coherent by flushing the pages 
being written to the device prior to the DMA starting, and invalidating 
the pages being read after the DMA completes.


Seeing as how Linux is supported on an even wider range of even more 
exotic systems ( think NUMA ), I have to believe that it has similar 
features.  Maybe it is just that the implementations of these support 
functions on Intel platforms is defined to be a NOOP because it is 
assumed that the hardware will always maintain coherency, but it seems 
there is at least one time where this is not the case ( entering C3 ).

If this code is just disabled on Intel platforms, maybe it could be 
reworked so that it maintains a list of all DMA transactions that are 
currently in progress, then before entering C3, all the pages involved 
in DMA writes would be flushed, and when exiting from C3, all the pages 
involved in DMA reads would be invalidated.

It sounds like you were talking about flushing and invalidating the 
ENTIRE cache when entering/exiting from C3.  That would slow things down 
quite a bit, but doing it only to the pages that are actually involved 
in active DMA transfers should be fine.


Janosch Machowinski wrote:
> 
> Normally a cache should be completely hidden from the system, so a 
> driver can never determine the actually state of the cache. Only way to 
> sync the cache is to completely flush it.
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
