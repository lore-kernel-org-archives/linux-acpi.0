From: Hamie <hamish-CM5YN7r2dWBr4tq51QLIbdBPR1lH4CV8@public.gmane.org>
Subject: Re: No APIC interrupts after ACPI suspend
Date: Sun, 27 Jun 2004 21:27:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40DF2D99.6030704@travellingkiwi.com>
References: <1088160505.3702.4.camel@tyrosine> <40DDBA7A.6010404@travellingkiwi.com> <40DF0A98.9040604@travellingkiwi.com> <200406272052.43326@zodiac.zodiac.dnsalias.org> <40DF1D22.2010406@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40DF1D22.2010406-CM5YN7r2dWBr4tq51QLIbdBPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hamie wrote:

> Alexander Gran wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Am Sonntag, 27. Juni 2004 19:57 schrieb Hamie:
>>  
>>
>>> FWIW the sound & networking appear to run fine for a while after
>>> resuming. But I just started a DVD. It ran fine for about 30 seconds 
>>> and
>>> then the sound went. About 30 seconds later the video froze and the app
>>> (xine) has frozen also. (kill -9 time...).
>>>   
>>
>> <>
>> I can confirm that here:
>> after resuming, network completely works (yeah!).
>> Sound doesn't.
>> unloading/reloading the sound driver does not help.
>> USB works jumpy (perhaps 5-10hz)
>> Reloading does the trick for usb.
>>
>
> Since it sounds like a different bug to 2643, (Similiar but the patch 
> that fixes the ethernet doesn't appear to doa  lot for the sound). 
> I've opened a new one... #2965.
>

Seeing as sound was on IRQ5 and the patch for 2643 fixed the ethernet, I added a
(big hack here :) call to 

                acpi_pic_sci_set_trigger(5, acpi_sci_flags.trigger);

in  acpi_pm_finish(u32 state); just after the call to set the IRQ trigger for
the acpi irq... 

Results in (kern.log) 

Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ5 SCI: Edge set to Level Trigger.


and then sound works after resume... Obviously not a very good fix as it won't
fix anything that uses somethign other than IRQ5.

So... What should the correct fix be? Obviously some IRQ's triggers aren't
surviving the resume... But why... The timer (IRQ 0) obviously does... 




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
