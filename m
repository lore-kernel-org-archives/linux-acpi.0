From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 0/3] ACPI: Fix for supporting > 256 processor declaration
 limit
Date: Thu, 23 Oct 2008 09:34:48 +0400
Message-ID: <49000CF8.1070608@gmail.com>
References: <1224702636.6784.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:21946 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYJWFey (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 01:34:54 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1599645ugf.37
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2008 22:34:52 -0700 (PDT)
In-Reply-To: <1224702636.6784.13.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: lenb@kernel.org, linux-acpi <linux-acpi@vger.kernel.org>

Hi Myron,

It is great to see that this functionality found some care after
2+ years :)
Please check your patches to conform to patch submission guidelines,
namely 80 char string limit... :) scripts/checkpatch.pl is quite good for
such purpose.

Myron Stowe wrote:
> Len, Alexey:
>
> The following three item patch series fixes an issue with the introduction
> of > 256 processor declaration support: "Allow processor to be declared with
> the Device() instead of Processor()" (git SHA 11bf04c4).
>
> The root issue is in the lsapic mapping logic of drivers/acpi/processor_core.c.
> Currently, the logic tries both types of matches irregardless of declaration
> type and relies on one failing.  According to the spec - lsapic mapping is
> dependent on how the processor object was declared: CPUs declared using the
> "Processor" statement should use the Local SAPIC's 'processor_id', and CPUs
> declared using the "Device" statement should use the 'uid'.
>
> Reference: Section 8.4 Declaring Processors; Section 5.2.11.13 Local SAPIC
> Structure.  "Advanced Configuration and Power Interface Specification",
> Revision 3.0b, October 2006.
>
>
> [PATCH 1/3] disambiguates the processor declaration type that is currently
> conflated so that subsequent logic can behave based explicitly on the
> declaration's type.  I expect the disambiguation this patch introduces will
> also be advantageous when extending the > 256 processor support for x86 via
> x2APIC.
>
> [PATCH 2/3] addresses the root issue as stated above.  With respect to this
> patch I'm ambivalent about the 'printk' introduced in "map_lsapic_id()" -
> perhaps it should be removed?
>
>   
Errors causing change from default behaviour should be visible, so
printk is ok, please only make it conform to 80 char string length limit.
> [PATCH 3/3] is non-functional white space/spelling fixes in the related code. 
>
>
> While the specific fix is ia64 focused the underlying code affected is common
> to both x86 and ia64.
That was intentional to have it common, as the less frequently used
case will rotten without care.
>   I have tested on the following platform/namespace
> combinations:
>   ia64 with "Processor" type namespace processor declarations,
>   ia64 with "Device" type namespace processor declarations,
>   x86 with "Processor" type namespace processor declarations.
>
>   
I had no machine with second variant, so it probably didn't work there, 
right?
> Note that this patch series does *not* handle "Device" type processor
> declarations that contain a string type _UID object under the processor
> device's scope (I am currently not aware of any platforms that have such to
> test against).
>
>   
Original didn't do it either -- it is too difficult and does not give 
any advantage
to HW vendors over numeral ID.

Regards,
Alex.
