From: Hamie <hamish-CM5YN7r2dWBr4tq51QLIbdBPR1lH4CV8@public.gmane.org>
Subject: Re: No APIC interrupts after ACPI suspend
Date: Mon, 28 Jun 2004 09:48:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40DFDB5A.7070301@travellingkiwi.com>
References: <B44D37711ED29844BEA67908EAF36F032D566A@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F032D566A-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Li, Shaohua wrote:

>Hi,
>I attached a new patch to handler all level triggered IRQs after resume
>for 8259 in http://bugme.osdl.org/show_bug.cgi?id=2643. Please try and
>attach your test result on it.
>
>  
>


Uh.... That might work.... Except that after applying the patch & 
restarting. Then suspend-resume I get another small problem... My 
thinkpad (r50p) uses the power button to wake up from suspend... The 
system wakes, but with this latest patch, acpid then kicks in & says 
'Ohh! I saw him press the power button' and promptly shuts down...

here's my acpid logfile

[Mon Jun 28 09:39:27 2004] received event "button/sleep SLPB 00000080 
00000001"
[Mon Jun 28 09:39:27 2004] executing action "/etc/acpi/sleep.sh"
[Mon Jun 28 09:39:27 2004] BEGIN HANDLER MESSAGES
ERROR: Module i810_audio does not exist in /proc/modules
Stopping hotplug subsystem:
   input
   net
   pci
   usb
done
ERROR: Module bluetooth is in use by rfcomm,l2cap
Starting hotplug subsystem:
   input
   net
   pci
   usb
** can't synthesize root hub events
done

/dev/hda:
 setting standby to 240 (20 minutes)
[Mon Jun 28 09:39:43 2004] END HANDLER MESSAGES
[Mon Jun 28 09:39:43 2004] action exited with status 0
[Mon Jun 28 09:39:43 2004] completed event "button/sleep SLPB 00000080 
00000001"
[Mon Jun 28 09:39:43 2004] received event "button/power PWRF 00000080 
00000001"
[Mon Jun 28 09:39:43 2004] executing action "/etc/acpi/powerbtn.sh"
[Mon Jun 28 09:39:43 2004] BEGIN HANDLER MESSAGES
[Mon Jun 28 09:39:43 2004] END HANDLER MESSAGES
[Mon Jun 28 09:39:43 2004] action exited with status 0
[Mon Jun 28 09:39:43 2004] completed event "button/power PWRF 00000080 
00000001"
[Mon Jun 28 09:40:07 2004] exiting
[Mon Jun 28 09:41:08 2004] starting up
[Mon Jun 28 09:41:08 2004] 3 rules loaded
ballbreaker:/var/log#


Sleeps, wakes & a shutdown... Should acpid do that? (i.e. shouldn't it 
eat the power button event that woke it up as a wakeup? Should it even 
get that?) Or is it the previous patch for drivers/acpi/sleep/main.c 
resetting the IRQ9 to edge triggered that's killing me? (I'll try 
removing that now).

TIA
Hamish.

>Thanks,
>Shaohua
>  
>
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Hamie
>>Sent: Monday, June 28, 2004 4:27 AM
>>Cc: Alexander Gran; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; acpi-
>>devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
>>
>>Hamie wrote:
>>
>>    
>>
>>>Alexander Gran wrote:
>>>
>>>      
>>>
>>>>-----BEGIN PGP SIGNED MESSAGE-----
>>>>Hash: SHA1
>>>>
>>>>Am Sonntag, 27. Juni 2004 19:57 schrieb Hamie:
>>>>
>>>>
>>>>        
>>>>
>>>>>FWIW the sound & networking appear to run fine for a while after
>>>>>resuming. But I just started a DVD. It ran fine for about 30
>>>>>          
>>>>>
>seconds
>  
>
>>>>>and
>>>>>then the sound went. About 30 seconds later the video froze and the
>>>>>          
>>>>>
>app
>  
>
>>>>>(xine) has frozen also. (kill -9 time...).
>>>>>
>>>>>          
>>>>>
>>>><>
>>>>I can confirm that here:
>>>>after resuming, network completely works (yeah!).
>>>>Sound doesn't.
>>>>unloading/reloading the sound driver does not help.
>>>>USB works jumpy (perhaps 5-10hz)
>>>>Reloading does the trick for usb.
>>>>
>>>>        
>>>>
>>>Since it sounds like a different bug to 2643, (Similiar but the patch
>>>that fixes the ethernet doesn't appear to doa  lot for the sound).
>>>I've opened a new one... #2965.
>>>
>>>      
>>>
>>Seeing as sound was on IRQ5 and the patch for 2643 fixed the ethernet,
>>    
>>
>I
>  
>
>>added a
>>(big hack here :) call to
>>
>>               acpi_pic_sci_set_trigger(5, acpi_sci_flags.trigger);
>>
>>in  acpi_pm_finish(u32 state); just after the call to set the IRQ
>>    
>>
>trigger
>  
>
>>for
>>the acpi irq...
>>
>>Results in (kern.log)
>>
>>Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ9 SCI: Edge set to Level
>>Trigger.
>>Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ5 SCI: Edge set to Level
>>Trigger.
>>
>>
>>and then sound works after resume... Obviously not a very good fix as
>>    
>>
>it
>  
>
>>won't
>>fix anything that uses somethign other than IRQ5.
>>
>>So... What should the correct fix be? Obviously some IRQ's triggers
>>    
>>
>aren't
>  
>
>>surviving the resume... But why... The timer (IRQ 0) obviously does...
>>
>>
>>
>>    
>>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
