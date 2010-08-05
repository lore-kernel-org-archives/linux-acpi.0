From: Raj Kumar <rajkumar278@hotmail.com>
Subject: RE: Question regarding linux acpi
Date: Thu, 5 Aug 2010 16:21:36 +0530
Message-ID: <BLU102-W143744C8470E5E9C2F4B8EEB900@phx.gbl>
References: <20100804170236.GA32073@srcf.ucam.org>
 <BLU102-W14E1E8D6FA2F2A23C56E84EBAF0@phx.gbl>,<20100804233418.GA8167@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from blu0-omc2-s11.blu0.hotmail.com ([65.55.111.86]:5053 "EHLO
	blu0-omc2-s11.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755581Ab0HEKvh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Aug 2010 06:51:37 -0400
In-Reply-To: <20100804233418.GA8167@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: linux-acpi@vger.kernel.org


 
Hi Matthew,
 
First very thanks for quick responses. But now i have one more
question regarding the ACPI.
 
As you mentioned " The core ACPI code will inform the PCI code (for instance) that a wakeup
event has been generated, or the PCI code (for instance) will call the
appropraite ACPI functions while putting the device in a low power
state"
 
{RAJ}: Does it mean then PCI bus driver code and ACPI driver will directly communicate
with each other without any linux power management core?
 
Please see if my understanding is correct:
 
{RAJ}: If system suspend/resumes and runtime_suspend/runtime_resume happens, as linux power management core(static/runtime)
calls the bus driver code so when ACPI will be there, the bus driver will directly call the ACPI driver APIs.
 
But still device driver's suspend and resume(static and runtime) calls will be called by bus driver as normal behaviour
and if ACPI is there, then bus driver will inform the device driver and then inform the device power status to ACPI driver?
 
correct?
 
{RAJ}: Will the ACPI driver code also call the linux power management functions directly?
 
 
 
 
Regards
Raj.
 
 
 
 


----------------------------------------
> Date: Thu, 5 Aug 2010 00:34:18 +0100
> From: mjg59@srcf.ucam.org
> To: rajkumar278@hotmail.com
> CC: linux-acpi@vger.kernel.org
> Subject: Re: Question regarding linux acpi
>
> On Thu, Aug 05, 2010 at 04:13:42AM +0530, Raj Kumar wrote:
>
>> I have implemented run time power management in my drivers. Do you mean to
>> say
>> In case of ACPI also, again run time power management will get to device
>> in low
>> power mode or full working mode.
>
> Unless you're coding for an ACPIPNP device, you don't need to care about
> ACPI at all in your driver. The code in 2.6.35 and higher will handle
> that for you.
>
>> The another thing is suppose BIOS is ACPI based, ok as you told that bus
>> will handle
>> all the things do you mean ACPI driver will notify the bus about various
>> device states?
>
> The core ACPI code will inform the PCI code (for instance) that a wakeup
> event has been generated, or the PCI code (for instance) will call the
> appropraite ACPI functions while putting the device in a low power
> state.
>
>> If yes then what the standard interface between bus driver and device
>> driver?
>
> It's documented in the runtime pm document I pointed you at.
>
>> Do you mean if there is ACPI, still ACPI is hooked with standard linux
>> static power management
>> core and run time power management core?
>
> Yes.
>
>> I mean to say ACPI notify the bus via linux power management core (static
>> and run time)?
>
> Yes.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html 		 	   		  