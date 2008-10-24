From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 0/3] ACPI: Fix for supporting > 256 processor declaration
 limit
Date: Fri, 24 Oct 2008 08:42:43 +0400
Message-ID: <49015243.3020706@gmail.com>
References: <1224702636.6784.13.camel@localhost>	 <1224754322.3945.15.camel@yakui_zhao.sh.intel.com>	 <1224778313.6769.39.camel@localhost> <1224817154.4055.13.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:35930 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbYJXEmp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Oct 2008 00:42:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so286132nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2008 21:42:43 -0700 (PDT)
In-Reply-To: <1224817154.4055.13.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi <linux-acpi@vger.kernel.org>

Myron,

I think you could ignore this person... I've spent more than 2 weeks 
explaining
him my changes to EC, but he insisted on quality of his "analysis", 
until was proven
to be completely wrong by test run on his own hardware.
If you have any questions about why he is so vocal, ask Len -- he is the 
manager of
Yakui...

Regards,
Alex.


Zhao Yakui wrote:
> On Thu, 2008-10-23 at 10:11 -0600, Myron Stowe wrote:
>   
>> On Thu, 2008-10-23 at 17:32 +0800, Zhao Yakui wrote:
>>     
>>> On Wed, 2008-10-22 at 13:10 -0600, Myron Stowe wrote:
>>>       
>>>> Len, Alexey:
>>>>
>>>> The following three item patch series fixes an issue with the introduction
>>>> of > 256 processor declaration support: "Allow processor to be declared with
>>>> the Device() instead of Processor()" (git SHA 11bf04c4).
>>>>
>>>> The root issue is in the lsapic mapping logic of drivers/acpi/processor_core.c.
>>>> Currently, the logic tries both types of matches irregardless of declaration
>>>> type and relies on one failing.  According to the spec - lsapic mapping is
>>>> dependent on how the processor object was declared: CPUs declared using the
>>>> "Processor" statement should use the Local SAPIC's 'processor_id', and CPUs
>>>> declared using the "Device" statement should use the 'uid'.
>>>>
>>>> Reference: Section 8.4 Declaring Processors; Section 5.2.11.13 Local SAPIC
>>>> Structure.  "Advanced Configuration and Power Interface Specification",
>>>> Revision 3.0b, October 2006.
>>>>
>>>>
>>>> [PATCH 1/3] disambiguates the processor declaration type that is currently
>>>> conflated so that subsequent logic can behave based explicitly on the
>>>> declaration's type.  I expect the disambiguation this patch introduces will
>>>> also be advantageous when extending the > 256 processor support for x86 via
>>>> x2APIC.
>>>>         
>>> In the patch the new HID("ACPI_CPU") for processor is introduced. Is it
>>> required?
>>> If there exists the _UID object under the scope of Processor, it won't
>>> work well.
>>>       
>> I'm not sure I understand your concern.  If you are concerned about the
>> case of a "Processor" type declaration that has a _UID object within
>> it's scope then this patch will handle such correctly (by the way - some
>> of our past platforms do have this combination).  This is basically what
>> [PATCH 1/3] addresses - setting the underlying infrastructure so that
>> subsequent mapping related logic - [PATCH2/3] - can explicitly
>> disambiguate between "Processor" declarations and "Device" declarations
>> and use the correct component corresponding to the declaration type
>> used.
>>     
> In most cases there is no _UID object under the scope of Processor
> namespace. And in such cases it is unnecessary to add the new
> HID("ACPI_CPU") for the processor. 
>
> But if there exists the _UID object under the scope of processor
> namespace , IMO this patch is not appropriate. The ACPI_ID returned by
> _UID object should have higher priority than the ACPI_ID defined in the
> processor definition.  In such case OS should match the ACPI_ID obtained
> from the _UID with slapic table to get the correct processor ID.
>
> Based on the above analysis IMO it is unnecessary to add the new
> HID("ACPI_CPU") for the processor.
> Thanks.
>
>   
>> If I misunderstood your question, or I am understanding your question
>> but you don't see how [PATCH 1/3] solves your concern then please ask
>> again.
>>     
>>> According to the spec the returned value of the _UID object for
>>> processor/device can be numeric value or a string. If it is a numeric
>>> value, we should match it with the ACPI_UID field of slapic table to get
>>> the APIC id. If it is string, we should match it with the ACPI_UID
>>> string field of slapic table get the APIC ID.
>>>       
>> Correct - thus my "warning" so to speak in the last paragraph of the
>> original posting.  I was going to tackle this and it turned out to get
>> pretty messy fast.  Fortunately the error path printk in
>> acpi_processor_get_info() when a "Device" declaration with a _UID that
>> is *not* an integer is encountered will trigger and indicate exactly
>> where the issue is at some future date when a vendor utilizes this
>> combination.
>>
>> Thanks for your reply!
>> Myron
>>     
>>>> [PATCH 2/3] addresses the root issue as stated above.  With respect to this
>>>> patch I'm ambivalent about the 'printk' introduced in "map_lsapic_id()" -
>>>> perhaps it should be removed?
>>>>
>>>> [PATCH 3/3] is non-functional white space/spelling fixes in the related code. 
>>>>
>>>>
>>>> While the specific fix is ia64 focused the underlying code affected is common
>>>> to both x86 and ia64.  I have tested on the following platform/namespace
>>>> combinations:
>>>>   ia64 with "Processor" type namespace processor declarations,
>>>>   ia64 with "Device" type namespace processor declarations,
>>>>   x86 with "Processor" type namespace processor declarations.
>>>>
>>>> Note that this patch series does *not* handle "Device" type processor
>>>> declarations that contain a string type _UID object under the processor
>>>> device's scope (I am currently not aware of any platforms that have such to
>>>> test against).
>>>>
>>>> All comments welcome.
>>>>
>>>> Myron
>>>>
>>>>         
>
>   

