From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: Re: nc4010 resume failure (was: ACPI S3 resume only reboots)
Date: Tue, 19 Oct 2004 06:52:13 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF00E887FE.9A5BA00C-ON49256F31.00734A89-49256F31.0077AD40@jp.ibm.com>
References: <1098132147.4032.5.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098132147.4032.5.camel@tyrosine>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org





Matthew wrote:

>>  ENTRY(wakeup_start)
>> @@ -20,6 +35,7 @@
>>           wakeup_code_start = .
>>           .code16
>>
>> +         BEEP
>>           movw        $0xb800, %ax
>>           movw        %ax,%fs
>>           movw        $0x0e00 + 'L', %fs:(0x10)

>I've been trying this on an HP nc4010. As far as I can tell, the code
>never even gets this far. The machine appears to suspend correctly - the
>sleep light flashes. Pressing the power button then causes the fan to
>switch on, but no beep is produced. This is with the gdt and
>virt_to_phys patches applied. What's the best way to proceed with
>debugging this?

It is reported that some machines cannot use its stack due to unknown
reason. In that case you must create a beep sound without any stack use
(push, call etc.) especially before your own ss:sp setting.

The best way to debug is to write a code to switch from protected mode to
real mode and  jump directly to wakeup_start from do_suspend_lowlevel. If
the control comes back to C routine again via the short-cut code, BIOS
shall be something wrong.

I will start writing the code soon to verify whether BIOS wakeup routine
misbehave to system hardware registers or not.

Regards, Hiro.





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
