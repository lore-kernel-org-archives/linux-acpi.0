From: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Subject: Re: performance & fan & heatload & suspend
Date: Sun, 05 Jan 2003 19:37:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E187B62.9050709@muenster.de>
References: <3E06C494.3060408@uni-muenster.de> <20021223135527.GA658@zaurus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021223135527.GA658-XqDnSF8rrUM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Pavel Machek wrote:

>Hi!
>
>  
>
>>By the way: What do you think about suspend: should a graphical 
>>interface should be able to put the computer to sleep (with swsusp)?
>>I think it would be a good idea, but is this an action only privilegd 
>>users should be able to, or should EVERY user how is allowd to adjust 
>>fan/throttling/performance be also allowed to suspend a computer?
>>( Technical spoken: should there be an extra entry in /etc/sudoers 
>>for suspend or can the fan/throttling/performancce entry be shared, 
>>what do you think about it?
>>    
>>
>
>Any user permitted to turn machine off should
>be permitted to make it sleep. 
>
Done, heatload now supports swsusp and performance via context menu.

Greetings,

Malte

You can find it here:

ftp://ftp.berlios.de/pub/heatload/


Any tests are welcome




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
