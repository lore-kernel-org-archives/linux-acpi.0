From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: Re: toshiba_acpi 0.18
Date: Thu, 25 Mar 2004 10:48:28 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4062FF4C.4000102@neggie.net>
References: <4053C4D5.8000703@neggie.net>	<1079242701.2168.121.camel@dhcppc4>	<4053F592.80001@neggie.net> <20040325173453.77fed4e9.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040325173453.77fed4e9.vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sergey Vlasov wrote:
> On Sun, 14 Mar 2004 01:02:58 -0500 John Belmonte wrote:
> 
>> static int
>>-dispatch_write(struct file* file, const char* buffer, unsigned long count,
>>-	ProcItem* item)
>>+dispatch_write(struct file* file, __user const char* buffer,
>>+	unsigned long count, ProcItem* item)
>> {
>>-	return item->write_func(buffer, count);
>>+	int result;
>>+	char* tmp_buffer;
>>+
>>+	/* Arg buffer points to userspace memory, which can't be accessed
>>+	 * directly.  Since we're making a copy, zero-terminate the
>>+	 * destination so that sscanf can be used on it safely.
>>+	 */
>>+	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
>>+	if (copy_from_user(tmp_buffer, buffer, count)) {
>>+		result = -EFAULT;
>>+	}
>>+	else {
>>+		tmp_buffer[count] = 0;
>>+		result = item->write_func(tmp_buffer, count);
>>+	}
>>+	kfree(tmp_buffer);
>>+	return result;
>> }
> 
> 
> This is still not enough.  count comes from userspace and can be
> arbitrarily large, and this function does not even check the return
> value from kmalloc()...

The "count" arg is passed by value, so there is no issue.

You are right about not checking the kmalloc result for an error.  I'll 
fix that, but it's not enough to warrant a new release on its own.  The 
code before the patch had the same problem, so this is not a newly 
created bug, and not related to the problem being addressed.

-John


-- 
http:// if  ile.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
