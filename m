From: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Subject: Re: heatload 0.4 now with throttling support
Date: Wed, 18 Dec 2002 17:13:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E009EB5.7010109@muenster.de>
References: <3E008120.5080908@uni-muenster.de> <20021218153355.GK347@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021218153355.GK347-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Ducrot Bruno wrote:

>After dpkg and heatload, get
> Sorry can't open any of the following files:
>	 /proc/acpi/thermal_zone/THRM/temperature
>	 /proc/acpi/thermal/0/status
>
>But
># ls /proc/acpi/thermal_zone/
>THM0
>
>
>Please fix by parsing the entry of /proc/acpi/thermal_zone, 
>
can you please send me

cat /proc/acpi/thermal_zone/THM0

... it seems to me that there are a LOT of different 
proc/acpi-structures :-(

/proc/acpi/thermal/0/status
/proc/acpi/thermal_zone
/proc/acpi/thermal_zone/THRM/temperature

and now:
/proc/acpi/thermal_zone/THM0

hope that the ACPI-group stabilize this ;-)

>and
>do not forget that you can have more than one thermal zone.
>
>  
>
until now heatload workes only for one CPU (i suppose the thermal_zone 
is coherent to the counting of CPUs?)

I won't be hard to improve it to more than one, but doing THAT for 
recurrent changing directory structs does not make fun.
If you can tell me more about the future (and present) of the 
proc/acpi-structure depending on the numers of CPU I will start 
implementing this feature between christmas and new years eve ;-)


Greetings,

Malte







>  
>



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
