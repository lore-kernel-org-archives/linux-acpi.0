From: "William Morrow" <William.Morrow@amd.com>
Subject: Re: [patch 13/14] ACPI: Correctly recover from a failed S3
 attempt
Date: Wed, 16 Aug 2006 11:58:35 -0600
Message-ID: <44E35CCB.5010109@amd.com>
References: <200608150537.k7F5bVsB011566@shell0.pdx.osdl.net>
 <200608160027.12335.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-res.frontbridge.com ([63.161.60.49]:4510 "EHLO
	outbound2-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751231AbWHPRtz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Aug 2006 13:49:55 -0400
In-Reply-To: <200608160027.12335.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, jordan.crouse@amd.com, luming.yu@intel.com

I have to admit, this is not what I would have had.


Len Brown wrote:

>On Tuesday 15 August 2006 01:37, akpm@osdl.org wrote:
>  
>
>>From: William Morrrow <william.morrow@amd.com>
>>
>>This was discovered on a broken BIOS that simply returned from its suspend
>>procedure, appearing to the OS as a failed S3 attempt.
>>
>>It is possible to invoke the protected mode register restore routine (which
>>would normally restore the sysenter registers) when the bios returns from
>>S3.  This has no effect on a correctly running system and repairs the
>>damage from broken BIOS.
>>    
>>
>
>Where and why does acpi_enter_sleep_state() bail out?
>  
>
Where?
It does not actually bail out, it just returns do_suspend_lowlevel as if 
it did sleep.
It did sleep, but did not restart and return the call by the accepted 
software mechanism.
The machine resumes execution in protected mode with the original 
machine state
largely intact, but it fails to restore the sysenter/exit registers.

Why?
It is a sort of tortured bios.  AMD shutdown the design center where the
development was occurring.  Only one bios developer is left (not me), and
he is over-committed.  Fixing our bios is not likely, since the facility 
will
be closed before the mod can be created, tested, and deployed.  I developed
this fix as a demonstration that the S3 can work in linux.  The "fix" makes
error recovery stronger, and so it was suggested to push the fix since 
it can
recover this and other more serious errors.  There was concern that covering
errors was not a good idea in the first place, but in the end - the case 
for more
reliability was stronger.

>Does S3 work on windows on this box?
>  
>
Yes (XP).  This is the excuse - and is the force which is driving this 
solution.
There is no test group to re-test all of the ACPI aware OSs S3 recovery.
So if they change (correct) the S3 strategy, it cant be well tested 
here.  Since it
was tested in the errant form and appeared to pass (on XP), there is 
considerable
pressure to not correct the bios.

>How does the machine fail without this patch -- does it crash or hang on entering S3?
>Does the patch below imply that we've got the return from acpi_enter_sleep_state
>wrong no matter why it returns?
>  
>
The machine goes into and out of S3 normally, and then flips out doing 
double
faults on the first sysenter since these msrs are zeroed and not restored.

>thanks,
>-Len
>  
>
If there are any other materials you need to evaluate this change, let 
me know.

Thanks for your attention!
morrow

>>Signed-off-by: William Morrow <william.morrow@amd.com>
>>Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
>>Cc: "Yu, Luming" <luming.yu@intel.com>
>>Cc: "Brown, Len" <len.brown@intel.com>
>>Signed-off-by: Andrew Morton <akpm@osdl.org>
>>---
>>
>> arch/i386/kernel/acpi/wakeup.S |    5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>>diff -puN arch/i386/kernel/acpi/wakeup.S~acpi-correctly-recover-from-a-failed-s3-attempt arch/i386/kernel/acpi/wakeup.S
>>--- a/arch/i386/kernel/acpi/wakeup.S~acpi-correctly-recover-from-a-failed-s3-attempt
>>+++ a/arch/i386/kernel/acpi/wakeup.S
>>@@ -292,7 +292,10 @@ ENTRY(do_suspend_lowlevel)
>> 	pushl	$3
>> 	call	acpi_enter_sleep_state
>> 	addl	$4, %esp
>>-	ret
>>+
>>+#	In case of S3 failure, we'll emerge here.  Jump
>>+# 	to ret_point to recover
>>+	jmp	ret_point
>> 	.p2align 4,,7
>> ret_point:
>> 	call	restore_registers
>>_
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>    
>>
>
>
>  
>



