From: Vibol Hou <vibol-LA8/tbxb0N8@public.gmane.org>
Subject: Re: Laptop backlight/S1 in 2.6.6 vanilla
Date: Fri, 28 May 2004 00:34:07 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40B6EB6F.4090508@khmer.cc>
References: <40B1D0BA.8080303@khmer.cc> <20040525192551.GM5215@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040525192551.GM5215-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I commented out pm_prepare_console() and pm_restore_console() in 
kernel/power/main.c and the screen no longer turns back on.  However, 
I'm still uncertain if this is safe.  What I do notice is that some 
keyboard input still makes it into the terminal where I have initiated 
sleep from while the machine is in S1 so it appears after I wake up the 
machine.

Somehow, this has also resolved another problem I had with the machine 
cycling in and out of S1 mode a few times before finally staying awake.

-Vibol

Pavel Machek wrote:

>Hi!
>
>  
>
>>I'm running vanilla 2.6.6 on a dell latitude c400 (fedora core 2).  I 
>>have my sleep script set to shut off the display backlight in X 
>>before echo 1 > /proc/acpi/sleep, but the backlight turns back on the 
>>moment my machine enters sleep mode.  does anyone have any idea why 
>>this is happening?
>>    
>>
>
>Kernel switches to text console and stops processes.
>It should not be neccessary for S1 and is likely to cause
>your problem.
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
