From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 12:07:08 -0700
Message-ID: <49C7DDDC.2050103@goop.org>
References: <49C484B7.20100@goop.org> <49C67054.7020603@goop.org> <0A882F4D99BBF6449D58E61AAFD7EDD60E5E8766@pdsmsx502.ccr.corp.intel.com> <200903231920.12991.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:40195 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbZCWTHU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Mar 2009 15:07:20 -0400
In-Reply-To: <200903231920.12991.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

Rafael J. Wysocki wrote:
> On Monday 23 March 2009, Tian, Kevin wrote:
>   
>> And then Xen jumps in to finish remaining steps. From this angle,
>> Xen is not a completely new platform and, well, S3 is more like a
>> 'S1' type from dom0's p.o.v with a different trigger method. Then is
>> it overkilled to introduce a new set of ops with 99% content 
>> duplicated?
>>     
>
> IMO, no, it isn't.

Hm.  Well, lets take acpi_suspend_enter() as a specific example.  The 
Xen change here is:

@@ -240,11 +240,20 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		barrier();
 		status = acpi_enter_sleep_state(acpi_state);
 		break;
 
 	case ACPI_STATE_S3:
-		do_suspend_lowlevel();
+		if (!xen_pv_domain())
+			do_suspend_lowlevel();
+		else {
+			/*
+			 * Xen will save and restore CPU context, so
+			 * we can skip that and just go straight to
+			 * the suspend.
+			 */
+			acpi_enter_sleep_state(acpi_state);
+		}
 		break;
 	}
 
 	/* If ACPI is not enabled by the BIOS, we need to enable it here. */
 	if (set_sci_en_on_resume)


Which is, functionally, adding one if() and a new line of code, in the 
middle of a ~70 line function.

Are you suggesting that it would be best to copy this whole function so 
that I can put one line of Xen-specific code in the middle, rather than 
just making this change?

Some other functions, the Xen vs. non-Xen changes are larger; 
acpi_sleep_prepare() could reasonably have a Xen-specific variant 
because a big chunk of it is setting up the wakeup vector (which is 
unnecessary under Xen), and the rest can be easily pulled into common 
code.  But unfortunately acpi_sleep_prepare isn't itself an operation, 
and is only called at the bottom of 2-3 level deep callchains.

I think that rather than having a separate xen-acpi 
platform_suspend_ops, it would make more sense to have a acpi_ops within 
acpi/sleep.c and handle the differences that way.  I'll see how it turns 
out.

    J
