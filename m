From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: ACPI owner_id limit too low
Date: Thu, 08 Dec 2005 21:23:25 +0100
Message-ID: <4398963D.8040207@gmx.net>
References: <1134066095.32040.20.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1134066095.32040.20.camel@tdi>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alex Williamson schrieb:
>    We've found recently that it's not very hard to bump into the limit
> of the number of owner_ids that the ACPI subsystem can provide.
> [...] Doubling the limit to 64 is a sufficient short term fix
> and a fairly trivial patch, maybe even something that could go in before
> 2.6.15.  Len, could we do something like the below patch to give us a
> little more reasonable limit?  We could switch to a bitmap too, but
> given how close the next kernel is to release this is less impact.
> Thanks,
> 
> 	Alex
> 
> 
> Signed-off-by: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
> ---
> 
> diff -r 03055821672a drivers/acpi/utilities/utmisc.c
> --- a/drivers/acpi/utilities/utmisc.c	Mon Dec  5 01:00:10 2005
> +++ b/drivers/acpi/utilities/utmisc.c	Wed Dec  7 14:55:58 2005
> @@ -84,14 +84,14 @@
>  
>  	/* Find a free owner ID */
>  
> -	for (i = 0; i < 32; i++) {
> -		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
> +	for (i = 0; i < 64; i++) {
> +		if (!(acpi_gbl_owner_id_mask & (1UL << i))) {

Shouldn't this be 1ULL if you intend it to be 64 bit wide on a
32 bit arch?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
