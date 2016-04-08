From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/14] x86/rtc: replace paravirt rtc check with
 platform legacy quirk
Date: Fri, 8 Apr 2016 00:36:44 -0700
Message-ID: <CAB=NE6XHL87=FzwnoS-0Rm=GMNZHXSKybHiXzVkfX1hcd_b3qQ@mail.gmail.com>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
 <1459987594-5434-5-git-send-email-mcgrof@kernel.org> <570658DA.7060509@oracle.com>
 <20160408003207.GN1990@wotan.suse.de> <57073F0F.400@suse.com>
 <CAB=NE6UfgbUiF0v4X2O+FzGCqU3eevEXejrRO4bGWtmYOr0mxg@mail.gmail.com>
 <57075201.5080207@suse.com> <CAB=NE6W3gnH8_cFE4q2QStm-KXn+TtEB_sZHWoSD5ZF7cqD04A@mail.gmail.com>
 <57075A0F.2020303@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41913 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbcDHHhK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 03:37:10 -0400
In-Reply-To: <57075A0F.2020303@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, lguest@lists.ozlabs.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joey Lee <jlee@suse.com>, Gary Lin <glin@suse.com>, Matt Fleming <matt@codeblueprint.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Toshi Kani <toshi.kani@hp.com>, ACPI

On Fri, Apr 8, 2016 at 12:13 AM, Juergen Gross <jgross@suse.com> wrote:
> On 08/04/16 08:56, Luis R. Rodriguez wrote:
>> On Thu, Apr 7, 2016 at 11:38 PM, Juergen Gross <jgross@suse.com> wrote:
>>> On 08/04/16 08:29, Luis R. Rodriguez wrote:
>>>> On Thu, Apr 7, 2016 at 10:18 PM, Juergen Gross <jgross@suse.com> wrote:
>>>>> On 08/04/16 02:32, Luis R. Rodriguez wrote:
>>>>>> This highlights a semantic gap issue. From a quick cursory review, I think
>>>>>> we can address this temporarily by just using a check:
>>>>>>
>>>>>> void __init x86_early_init_platform_quirks(void)
>>>>>> {
>>>>>>       x86_platform.legacy.rtc = 1;
>>>>>>
>>>>>>       switch (boot_params.hdr.hardware_subarch) {
>>>>>>       case X86_SUBARCH_XEN:
>>>>>>       case X86_SUBARCH_LGUEST:
>>>>>>       case X86_SUBARCH_INTEL_MID:
>>>>>> -             x86_platform.legacy.rtc = 0;
>>>>>> +             if (x86_init.mpparse.get_smp_config != x86_init_uint_noop)
>>>>>> +                     x86_platform.legacy.rtc = 0;
>>>>>
>>>>> No! Why don't you just use the explicit test xen_initial_domain() ?
>>>>
>>>> Because we don't want to sprinkle Xen specific code outside of Xen
>>>> code. What do you think about the second possibility I listed?
>>>> Otherwise, any other ideas?
>>>
>>> Don't try to guess.
>>
>> I can only do that given there is nothing at all to tell me what to
>> expect here with regards to RTC on Xen guest, if there is some
>> documentation that could help with that please let me know.
>
> Only Xen inernals. :-)

Where can I look at this specifically on the Xen sources? No worries
if you don't care -- as I don't really either.

>>> In case you don't want to inject Xen internals here, just call a Xen
>>> function to either return the correct value, or to set all structure
>>> elements correctly.
>>
>> I like the later as an option, in case there are further hardware
>> subarch specific quirks which require internal logistics. What do
>> others think?
>>
>>> Thinking more about it: why not do that for all the subarchs?
>>
>> I originally had went with that approach, but Ingo made the point that
>> it would be best to instead move all quirk settings into one place.
>> That lets a reader easily tell what is going on in one place, it also
>> compartmentalizes the hardware subarch uses.
>
> Okay. Another idea (not sure whether this is really a good one):
>
> Add X86_SUBARCH_XEN_DOM0. As hardware_subarch is 32 bits wide I don't
> think the number of subarchs is a scarce resource. :-)

This would mean bumping the x86 boot protocol, we shouldn't take that
lightly, but given that in this case the new subarch would really only
be set by the kernel (or future loaders for perhaps HVMLite) I'd think
this is not such an intrusive alternative.

> I'd expect other quirks in future might have different settings for
> domU and dom0, too.

Can you elaborate a bit more on this. I realize we expect domU and
dom0 on HVMLite in the future, would HVMLite use the subarch ? From
the last discussions on the HVMLite thread Boris noted HVMLite would
use the PC subarch -- how would we do dom0 Vs domU quirk management?

If it goes the EFI route, I gather Xen instead can use the EFI
configuration tables for Xen specific tunings, however we may also
need a generic x86 configuration table for generic quirks I think. We
may need to provide a 1-1 mapping of these quirks there, if the
subarch is not used.

>>> You'd
>>> have the specific settings where they belong: in a subarch specific
>>> source. Just do the default settings in x86_early_init_platform_quirks()
>>> and let the subarch functions set the non-default values.
>>
>> This is a rather different approach than what I had originally tried.
>> Bike shed thing -- someone just has to decide.
>>
>> Left up to me, I kind of really like centralizing the quirk settings
>> in one place approach as it means a reader can easily tell what's
>> going on regardless of platform in one place for odd settings. I
>> prefer this given that we *already* have the semantics over hardware
>> subarch in a generalized fashion. We *do not* have semantics for dom0
>> Vs domU -- if such a notion is generic to other virtualization
>
> That's not carved in stone - see above. :-)

Another subarch for Xen dom0 works well for me as well given the new
subarch would just all set in the kernel. It does mean extending the
x86 boot protocol though, and so for that I yield to hpa.

 Luis
