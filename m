From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] toshiba_acpi 0.18
Date: Tue, 23 Mar 2004 23:09:37 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40610A01.9070904@neggie.net>
References: <4053C4D5.8000703@neggie.net> <20040314130724.GA1994@hell.org.pl> <20040323232438.GA9223@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040323232438.GA9223-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> @@ -499,9 +500,16 @@ write_led(const char *buffer, unsigned l
>  {
>  	int value;
>  	int led_out = 0;
> +	char *tmp_buffer;
>  
> -	if (sscanf(buffer, "%i", &value) == 1)
> +	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
> +	if (copy_from_user(tmp_buffer, buffer, count))
> +		return -EFAULT;
> +	else
> +		tmp_buffer[count] = '\0';
> +	if (sscanf(tmp_buffer, "%i", &value) == 1)
>  		led_out = value ? 1 : 0;
> +	kfree(tmp_buffer);

Note that if copy_from_user fails, this code leaks memory.

-John


-- 
http:// if  ile.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
