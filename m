From: "Yu, Ke" <ke.yu@intel.com>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 17:18:25 +0800
Message-ID: <4D05DB80B95B23498C72C700BD6C2E0B315D6A67@pdsmsx502.ccr.corp.intel.com>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
 <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
 <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com>
 <4A707DC1.9070708@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55584 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbZG3JUy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 05:20:54 -0400
In-Reply-To: <4A707DC1.9070708@goop.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>

>-----Original Message-----
>From: Jeremy Fitzhardinge [mailto:jeremy@goop.org]
>Sent: Thursday, July 30, 2009 12:50 AM
>To: Yu, Ke
>Cc: Brown, Len; linux-acpi@vger.kernel.org; Tian, Kevin
>Subject: Re: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
>control operation interface for domain0 ACPI parser
>
>On 07/28/09 23:20, Yu, Ke wrote:
>> Your question is reasonable. there is also debate here before. People discuss if
>it is possible to add acpica stuff to xen hypervisor and let xen control the acpi
>completely. Unfortunately, this will lead dilemma here, i.e. some devices are
>controlled by dom0 and also need acpi info, e.g. battery, thermal, etc. and pci
>hotplug in dom0 is another example. Tian Kevin has detail description on this
>issue in the attached mail.
>>
>
>What would happen if we special-cased dom0 VCPUs to be bound 1:1 to
>PCPUs.  Would that simplify this stuff?  Wouldn't that make CPU control
>equivalent to battery, fan, etc?

It helps in current approach, i.e. acpi dsdt table is owned and parsed by dom0. Actually, Tx state support in current approach need 1:1 vcpu-pcpu binding.

Meanwhile, in current approach, we still need to let dom0 passing acpi info to xen, which is what this patch intend to do.

>
>> On the other hand, the dom0 acpica approach has other benefit, i.e. current
>linux acpica stuff is pretty mature and has numerous bug fix. Leveraging acpica in
>linux kernel is more practical.
>>
>
>My understanding is that all that code is supposed to be
>kernel-independent.  We could lift all that code as-is, write some new
>kernel interface shims and shove it all into Xen.   But I don't know if
>that solves any more problems than it causes.
>
>>> s/extcntl/xen/ to make it clear why this code exists --
>>> or is there an expected "external control" other than Xen?
>>>
>>> -Len
>>>
>>
>> Ok, I can try this. BTW, besides this naming change, do you have other
>comment on the code? So that I can make it more clean.
>>
>
>I don't think that's a good idea.  If we need to do that, then there's a
>deeper design problem we need to address.  (And, if nothing else, people
>have become hypersensitive to naked Xen-specific code references in
>non-Xen files, and I'm tired of having those arguments.)
>
>    J

Can you explain what the deeper design problem is?

Best Regards
Ke
