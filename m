From: Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: 2.6.0-test8 & Asus M3N
Date: Wed, 22 Oct 2003 12:46:59 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F964403.9090304@namesys.com>
References: <20031020181638.GL4944@austinchronicle.com> <20031021184216.GA7100@austinchronicle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031021184216.GA7100-lfYnT2qr6k+7/ODoCphcOEEOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lindsey Simon <lsimon-kAMMLXQ8Af9Wk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Lindsey Simon wrote:

>Actually, while running the 2.6 kernel and recompiling I watched the
>temp go up into the 70s and the fan never ran. Anybody have any idea how
>to perhaps manually start the fan up? I could blow into the bottom
>really hard :)
>
>Lindsey Simon in message [ACPI-sppt] 2.6.0-test8 & Asus M3N (Mon, 10/20 13:16):
>  
>

I have ASUS M3700N and have never seen something like this on 
2.6.0-test8. Everything works fine. Well, almost everything :)
cpufreq works in different manner then before. When using policy with 
percents of max CPU frequency, it sets CPU frequncy to passed percent of 
current CPU frequency, but should use max one IMHO.

Laptop max frequency is 1.3Gz
When laptop is boot without AC plugged it is set its CPU frequency 
600Mhz, that is policy is 50%-100%-powersave. But if you apply the same 
policy (that is 50%-100%-powersave) one more time, CPU will be changed 
to 300Mhz and so on.

>  
>
>>Out of the box, the test8 kernel seems to have Luca's patch now,
>>temperature readings are showing up properly in /proc/acpi.
>>
>>But when the temp gets to the 55 trip point, I get these in dmesg:
>>osl-0892 [1029] os_wait_semaphore     : Failed to acquire
>>semaphore[cf73e580|1|0], AE_TIME
>>
>>plugged or unplugged into the AC adapter.
>>
>>Anyhow, that might be useful for someone who understands ACPI I though
>>:)
>>
>>Thanks,
>>-l
>>
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by OSDN developer relations
>>Here's your chance to show off your extensive product knowledge
>>We want to know what you know. Tell us and you have a chance to win $100
>>http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
>>_______________________________________________
>>ACPI-support mailing list
>>ACPI-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>https://lists.sourceforge.net/lists/listinfo/acpi-support
>>    
>>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by OSDN developer relations
>Here's your chance to show off your extensive product knowledge
>We want to know what you know. Tell us and you have a chance to win $100
>http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
>
>  
>


-- 
umka




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
