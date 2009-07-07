From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [PATCH]new ACPI processor driver to force CPUs idle
Date: Mon, 6 Jul 2009 17:50:50 -0700
Message-ID: <7E82351C108FA840AB1866AC776AEC4669D00076@orsmsx505.amr.corp.intel.com>
References: <20090624041354.GA15936@sli10-desk.sh.intel.com>
 <1245825558.19816.1861.camel@twins>
 <20090624074703.GA28458@sli10-desk.sh.intel.com>
 <1245830585.31755.11.camel@twins>
 <20090624082112.GA20844@sli10-desk.sh.intel.com>
 <20090626181623.GF7717@dirshya.in.ibm.com>
 <20090629025455.GA20614@sli10-desk.sh.intel.com>
 <20090706180312.GC26831@dirshya.in.ibm.com>
 <20090706234346.GA8072@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56902 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902AbZGGAs2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2009 20:48:28 -0400
In-Reply-To: <20090706234346.GA8072@basil.fritz.box>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>

 

>-----Original Message-----
>From: Andi Kleen [mailto:andi@firstfloor.org] 
>Sent: Monday, July 06, 2009 4:44 PM
>To: Vaidyanathan Srinivasan
>Cc: Li, Shaohua; Peter Zijlstra; linux-acpi@vger.kernel.org; 
>tglx@linutronix.de; lenb@kernel.org; Pallipadi, Venkatesh; 
>andi@firstfloor.org; Ingo Molnar
>Subject: Re: [PATCH]new ACPI processor driver to force CPUs idle
>
>On Mon, Jul 06, 2009 at 11:33:12PM +0530, Vaidyanathan 
>Srinivasan wrote:
>> > > 
>> > > How do we handle interrupts and timers during this 
>interval?  You seem
>> > > to disable interrupts and hold the cpu at idle for 0.95 
>sec.  It may
>> > > cause timeouts and overflows for network interrupts right?
>> > The x86 mwait/monitor instruction can detect interrupt and 
>complete execution
>> > even interrupt is disabled, so this isn't an issue.
>> 
>> Cool, this will save a lot of trouble :)
>
>This is only available in newer Intel CPUs. 
>

This is present in Intel Core/Core 2 and beyond.
Shaohua's patch is checking for this in init path

> 
> +	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
> +	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK))
> +		return;
>

and -EINVALing when the feature is not present. So,
that will disable the feature on older CPUs.

Thanks,
Venki
