From: =?ISO-8859-1?Q?Robert_W=F6rle?= <robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org>
Subject: Re: swsusp needs clock corrected | 8193too needs reload
Date: Wed, 18 Sep 2002 11:59:55 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D884E9B.7050600@symplon.com>
References: <3D85998F.7090101@symplon.com> <20020916092450.GA22114@marcogigante.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org schrieb:

>On Mon, Sep 16, 2002 at 10:42:55AM +0200, Robert wrote:
>  
>
>>Hi
>>
>>For my Tablet PC ACPI is very good working now .n
>>The Transmeta 600Mhz sits on a ALi chipset with a Phoenix Bios
>>
>>AC and battery are displayed.
>>processor can be influenced and throttle
>>i also get the temperature .
>>and with the swsusp i also can fully use S4 without any BIG problem
>>
>>Only 2 things are not fully working with swsusp
>>after i resume from S4 , my clock is still at the time when it was
>>suspended.
>>    
>>
>
>You should use something like:
>
>hwclock --systohc
>echo -n "1 0 0" > /proc/sys/kernel/swsusp
>sleep 5 # time to sleep
>hwclock --hctosys
>
>  
>
>>the secound thing is that i need to rmmod my 8139too Realtek eth0 chip
>>and reinsert it by hand . although i get the correct messages at resume
>>: " setting up half dupley 10/100 ...."
>>
>>Anybody has a hint ...?
>>    
>>
>
>Now I haven't my swsusp script at hand. I'll send it as soon as I come
>back home. The concept is to rmmod modules or stop services before susp.
>and insmod restart they after wakeup.
>  
>
may you can sent me this script .. since i dont manage it to do !!?!?!

>--
>Regards, Marco Gigante
>
>
>  
>

-- 
 
_____________________________________
*Robert Wörle
 Linux | Embedded Device*
*
Symplon AG*

*...touch the internet*

phone: +49 89 552 999 35
fax: +49 89 552 999 10
email: robert.woerle-y2s3ugBAdl9BDgjK7y7TUQ@public.gmane.org <mailto:robert.woerle@symplon.com>
web: www.symplon.com <http://www.symplon.com/>

_____________________________________
 



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
