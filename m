From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 04/14] x86/rtc: replace paravirt rtc check with
 platform legacy quirk
Date: Fri, 8 Apr 2016 08:38:57 +0200
Message-ID: <57075201.5080207@suse.com>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
 <1459987594-5434-5-git-send-email-mcgrof@kernel.org>
 <570658DA.7060509@oracle.com> <20160408003207.GN1990@wotan.suse.de>
 <57073F0F.400@suse.com>
 <CAB=NE6UfgbUiF0v4X2O+FzGCqU3eevEXejrRO4bGWtmYOr0mxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34755 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754204AbcDHGjD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 02:39:03 -0400
In-Reply-To: <CAB=NE6UfgbUiF0v4X2O+FzGCqU3eevEXejrRO4bGWtmYOr0mxg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, lguest@lists.ozlabs.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joey Lee <jlee@suse.com>, Gary Lin <glin@suse.com>, Matt Fleming <matt@codeblueprint.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Toshi Kani <toshi.k>

On 08/04/16 08:29, Luis R. Rodriguez wrote:
> On Thu, Apr 7, 2016 at 10:18 PM, Juergen Gross <jgross@suse.com> wrote:
>> On 08/04/16 02:32, Luis R. Rodriguez wrote:
>>> This highlights a semantic gap issue. From a quick cursory review, I think
>>> we can address this temporarily by just using a check:
>>>
>>> void __init x86_early_init_platform_quirks(void)
>>> {
>>>       x86_platform.legacy.rtc = 1;
>>>
>>>       switch (boot_params.hdr.hardware_subarch) {
>>>       case X86_SUBARCH_XEN:
>>>       case X86_SUBARCH_LGUEST:
>>>       case X86_SUBARCH_INTEL_MID:
>>> -             x86_platform.legacy.rtc = 0;
>>> +             if (x86_init.mpparse.get_smp_config != x86_init_uint_noop)
>>> +                     x86_platform.legacy.rtc = 0;
>>
>> No! Why don't you just use the explicit test xen_initial_domain() ?
> 
> Because we don't want to sprinkle Xen specific code outside of Xen
> code. What do you think about the second possibility I listed?
> Otherwise, any other ideas?

Don't try to guess.

In case you don't want to inject Xen internals here, just call a Xen
function to either return the correct value, or to set all structure
elements correctly.

Thinking more about it: why not do that for all the subarchs? You'd
have the specific settings where they belong: in a subarch specific
source. Just do the default settings in x86_early_init_platform_quirks()
and let the subarch functions set the non-default values.


Juergen

