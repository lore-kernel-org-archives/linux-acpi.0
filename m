From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external control
 operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 13:36:07 -0700
Message-ID: <4A720437.5080200@goop.org>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com> <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com> <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com> <4A707DC1.9070708@goop.org> <4D05DB80B95B23498C72C700BD6C2E0B315D6A67@pdsmsx502.ccr.corp.intel.com> <alpine.LFD.2.00.0907301139530.17818@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:59555 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbZG3UgI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2009 16:36:08 -0400
In-Reply-To: <alpine.LFD.2.00.0907301139530.17818@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Yu, Ke" <ke.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>

On 07/30/09 09:00, Len Brown wrote:
>>> My understanding is that all that code is supposed to be
>>> kernel-independent.  We could lift all that code as-is, write some new
>>> kernel interface shims and shove it all into Xen.   But I don't know if
>>> that solves any more problems than it causes.
>>>       
>
> Many have incorporated ACPICA into their OS, from BeOS to BSD, 
> Solaris to Linux.  And I'm not going to tell you that you can't
> do the same and make the xen hypervisor into an OS that knows
> about both policy and the hardware it is running on.
>
> However, ACPI != all the ACPI code in Linux.  ACPICA is the
> stuff in the drivers/acpi/acpica directory, and nothing else
> (asside from a few header files outside that directory)
>
> Also, I'm not sure the OS you build will be competitive with
> other OS's when you're done.
>   

Yes.  The general intent is that Xen tries to avoid having to
reimplement stuff that the guest operating systems are already much
better at.  However, it seems that ACPI's
>   
>>>>> s/extcntl/xen/ to make it clear why this code exists --
>>>>> or is there an expected "external control" other than Xen?
>>>>>           
> ...
>   
>>> I don't think that's a good idea.  If we need to do that, then there's a
>>> deeper design problem we need to address.  (And, if nothing else, people
>>> have become hypersensitive to naked Xen-specific code references in
>>> non-Xen files, and I'm tired of having those arguments.)
>>>       
>> Can you explain what the deeper design problem is?
>>     
>
> Obfuscating the code by calling a Xen-specific abstraction
> "extcntl" instead of "xen" will not fly.
>
> Jeremy's desire to create and use generic abstractions that have multliple 
> users is a good thing.  It simply does not apply here.
>   

OK.  I don't really understand ACPIs overall design or philosophy,
beyond a rough idea of what kinds of things it gets used for.  If there
really is no scope for refactoring things to make Ke's changes fit in
more naturally, then I guess we can live with some explicit hooks.

> I have no objection to having a xen-specific hook being called xen_*
> To do otherwise would be a dis-service to future maintainers of the code.
>   

I agree completely.  I have no interest in extra layers of
indirection/"abstraction" which are just disguises rather than having
some inherent value.

    J
