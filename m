From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v4 04/14] x86/rtc: replace paravirt rtc check with
 platform legacy quirk
Date: Fri, 8 Apr 2016 08:37:44 -0400
Message-ID: <5707A618.7040608@oracle.com>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
 <1459987594-5434-5-git-send-email-mcgrof@kernel.org>
 <570658DA.7060509@oracle.com> <20160408003207.GN1990@wotan.suse.de>
 <57073F0F.400@suse.com>
 <CAB=NE6UfgbUiF0v4X2O+FzGCqU3eevEXejrRO4bGWtmYOr0mxg@mail.gmail.com>
 <57075201.5080207@suse.com>
 <CAB=NE6W3gnH8_cFE4q2QStm-KXn+TtEB_sZHWoSD5ZF7cqD04A@mail.gmail.com>
 <57075A0F.2020303@suse.com>
 <CAB=NE6XHL87=FzwnoS-0Rm=GMNZHXSKybHiXzVkfX1hcd_b3qQ@mail.gmail.com>
 <570764F8.6020902@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17991 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbcDHMi6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2016 08:38:58 -0400
In-Reply-To: <570764F8.6020902@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, lguest@lists.ozlabs.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joey Lee <jlee@suse.com>, Gary Lin <glin@suse.com>, Matt Fleming <matt@codeblueprint.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Toshi Kani <toshi.kani@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, kozerkov@paral

On 04/08/2016 03:59 AM, Juergen Gross wrote:
> On 08/04/16 09:36, Luis R. Rodriguez wrote:
>> On Fri, Apr 8, 2016 at 12:13 AM, Juergen Gross <jgross@suse.com> wrote:
>>> On 08/04/16 08:56, Luis R. Rodriguez wrote:
>>>> On Thu, Apr 7, 2016 at 11:38 PM, Juergen Gross <jgross@suse.com> wrote:
>>>>
>>>> Okay. Another idea (not sure whether this is really a good one):
>>>>
>>>> Add X86_SUBARCH_XEN_DOM0. As hardware_subarch is 32 bits wide I don't
>>>> think the number of subarchs is a scarce resource. :-)
>> This would mean bumping the x86 boot protocol, we shouldn't take that
>> lightly, but given that in this case the new subarch would really only
>> be set by the kernel (or future loaders for perhaps HVMLite) I'd think
>> this is not such an intrusive alternative.
> I think adding an own subarch for dom0 isn't that bad. It really is
> different from domU as dom0 has per default access to the real hardware
> (or at least to most of it).

Can we do this (overwrite quirks) in x86_init_ops.arch_setup? I'd really 
like to avoid adding a what essentially is a sub-subarch.

-boris
