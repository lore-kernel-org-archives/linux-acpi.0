From: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Subject: Re: heatload 0.4 now with throttling support
Date: Wed, 18 Dec 2002 18:22:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E00AEC8.9050906@muenster.de>
References: <3E008120.5080908@uni-muenster.de> <20021218153355.GK347@poup.poupinou.org> <3E009EB5.7010109@muenster.de> <20021218170828.GA9127@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021218170828.GA9127-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Faye Pearson wrote:

>Malte Thoma [thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org] wrote:
>  
>
>>cat /proc/acpi/thermal_zone/THM0
>>
>>... it seems to me that there are a LOT of different 
>>proc/acpi-structures :-(
>>
>>/proc/acpi/thermal/0/status
>>/proc/acpi/thermal_zone
>>/proc/acpi/thermal_zone/THRM/temperature
>>/proc/acpi/thermal_zone/THM0
>>    
>>
>
>As with most ACPI things, the name of the thermal_zone is defined by the
>DSDT table, and is arbitrary.  You should read everything in the
>directory.
>  
>
In which directory, in /proc/acpi or in ../thermal_zone ?

>>hope that the ACPI-group stabilize this ;-)
>>    
>>
>
>They can't do anything about it.
>  
>
Thank you for this importent and disillusioned information :-(

>>until now heatload workes only for one CPU (i suppose the thermal_zone 
>>is coherent to the counting of CPUs?)
>>    
>>
>
>No, there could be a passive zone, a critical zone etc.
>  
>
Wonderfull task: something to develope for machines I cannot test it for :-(
coming along that my skills are not guru-like :-(

So what can you advise me?

parsing /proc/acpi and looking for


processor ->throttling
thermal*  -> ????
battery -> state or status
ac_adapter   -> state or status

excpecially in the thermal zone it looks as if ther is no regularity :-(
Do you have some more hints ?


Greetings,

Malte








>  
>



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
