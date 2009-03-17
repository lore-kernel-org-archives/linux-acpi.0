From: Francesco Lattanzio <franz.lattanzio@gmail.com>
Subject: Re: FSB scaling for ASUS EeePC 1000H
Date: Tue, 17 Mar 2009 09:26:06 +0100
Message-ID: <49BF5E9E.8050404@gmail.com>
References: <49BD1843.7050502@gmail.com> <20090315190557.GA4324@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:13210 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbZCQIXh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2009 04:23:37 -0400
Received: by nf-out-0910.google.com with SMTP id d21so1030984nfb.21
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2009 01:23:35 -0700 (PDT)
In-Reply-To: <20090315190557.GA4324@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

Matthew Garrett ha scritto:
> On Sun, Mar 15, 2009 at 04:01:23PM +0100, Francesco Lattanzio wrote:
>   
>> The following patch (against the current "linux-acpi-2.6" source tree) 
>> adds the capability of the ASUS EeePC 1000H (and maybe other models as 
>> well) to scale the FSB frequency and core voltage. Do not confuse this 
>> with cpufreq (SpeedStep and other similar mechanisms): cpufreq changes 
>> the internal CPU clock multiplier (and eventually the core voltage too) 
>> leaving the FSB frequency untouched.
>>     
>
> No, there's no requirement that cpufreq be limited to clock-multiplier 
> based methods. It's the right interfae to use for CPU speed control.
>
> (snip patch)
>
> Is this different to the cpufreq driver suggested at 
> http://lkml.org/lkml/2008/11/23/115 , other than the latter having 
> hardcoded speed values?
>
>   
It is exactly the same thing, done differently. Now I ask you, should we 
put this feature inside some eeepc-specific cpufreq module, or inside 
the eeepc-laptop module? Keep in mind that the 1000H model allows me to 
combine the effects of both the cpufreq (through Atom SpeedStep feature) 
and these ACPI methods.

-- 
Francesco Lattanzio <franz.lattanzio@gmail.com>

