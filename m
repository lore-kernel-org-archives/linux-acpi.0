From: Paul Ionescu <paul-f7LjuT9/YZU@public.gmane.org>
Subject: Re: Re: [PATCH] filling in ACPI method access via sysfs
Date: Wed, 14 Apr 2004 01:15:01 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081894500.6859.120.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Alex,

I tried to play with your new patch. I am able now to run arbitrary
parameterless methods. I have some problems accessing the methods
requiring parameters, or giving results.

I did an "echo 1 > /sys/.../DOCK/_DCK " but nothing happened, and I have
tried also to cat it but I got "cat: Read error: No such device"

And I did an "cat /sys/.../_STA" and I receive 
cat: Read error: No such device
Do I miss something ?

Thanks,
Paul


On Sun, 2004-04-11 at 16:29, Alex Williamson wrote: 
>> 
>> It seems unintuitive that you have to read the file for the method to
>> take effect.  How about having the write function invoke the method and
>> (if there is a result) store it for later read-back via the read function?
>> It should be discarded on close, of course.  A read() on a file with
>> no stored result should invoke the ACPI method (on the assumption this
>> is a parameter-less method) and return the result directly.  Closing a
>> file should discard any result from the method.
>
>  How's this?  It behaves the way you described, but might be doing
> some questionable things with the buffer to get there.  Is there a
> better place to store the return data than back into the buf passed to
> write() (aka file->private_data)?  Without adding callbacks to
> open/close, I'm not sure how else we can dispose of the results on
> close.  Thanks,
>
>	Alex



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
