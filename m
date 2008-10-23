From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 0/3] ACPI: Fix for supporting > 256 processor
	declaration limit
Date: Thu, 23 Oct 2008 17:32:01 +0800
Message-ID: <1224754322.3945.15.camel@yakui_zhao.sh.intel.com>
References: <1224702636.6784.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39524 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbYJWJZz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Oct 2008 05:25:55 -0400
In-Reply-To: <1224702636.6784.13.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: lenb@kernel.org, aystarik@gmail.com, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2008-10-22 at 13:10 -0600, Myron Stowe wrote:
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
In the patch the new HID("ACPI_CPU") for processor is introduced. Is it
required?
If there exists the _UID object under the scope of Processor, it won't
work well. 

According to the spec the returned value of the _UID object for
processor/device can be numeric value or a string. If it is a numeric
value, we should match it with the ACPI_UID field of slapic table to get
the APIC id. If it is string, we should match it with the ACPI_UID
string field of slapic table get the APIC ID.
> 
> [PATCH 2/3] addresses the root issue as stated above.  With respect to this
> patch I'm ambivalent about the 'printk' introduced in "map_lsapic_id()" -
> perhaps it should be removed?
> 
> [PATCH 3/3] is non-functional white space/spelling fixes in the related code. 
> 
> 
> While the specific fix is ia64 focused the underlying code affected is common
> to both x86 and ia64.  I have tested on the following platform/namespace
> combinations:
>   ia64 with "Processor" type namespace processor declarations,
>   ia64 with "Device" type namespace processor declarations,
>   x86 with "Processor" type namespace processor declarations.
> 
> Note that this patch series does *not* handle "Device" type processor
> declarations that contain a string type _UID object under the processor
> device's scope (I am currently not aware of any platforms that have such to
> test against).
> 
> All comments welcome.
> 
> Myron
> 

