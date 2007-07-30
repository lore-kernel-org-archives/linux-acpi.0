From: david@lang.hm
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Sun, 29 Jul 2007 20:46:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707292042320.6297@asgard.lang.hm>
References: <1183030080.4249.172.camel@queen.suse.de> <200707241540.43868.bjorn.helgaas@hp.com>
 <Pine.LNX.4.64.0707291821590.6331@asgard.lang.hm> <200707292141.23339.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:40577
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbXG3Dv5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 23:51:57 -0400
In-Reply-To: <200707292141.23339.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Sun, 29 Jul 2007, Bjorn Helgaas wrote:

>>> of /proc/interrupts?
>>
>> done, see the files
>> 2.6.22-rc4.interrupts
>> 2.6.22-rc4.dmesg.test
>> at http://lang.hm/linux
>
> Thanks, but you booted with "pnpacpi=off", so we didn't learn anything.
> The port works with "pnpacpi=off" even without the patch.  Somebody
> else tried my "disable/init/activate" patch with terrible results, so
> that approach will need more work.

I did?? I thought I had changed that.

Ok, I'll try again.

David Lang

> This seems an awful lot like this bug report:
>  http://bugzilla.kernel.org/show_bug.cgi?id=5832
>
> Can you take a look at 5832, and maybe we can combine your problem
> with that one if you agree they look the same?
>
> Bjorn
>
