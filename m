From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 15:53:13 -0500
Message-ID: <56425939.7000605@hpe.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com> <5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com> <x49d1vhlp34.fsf@segfault.boston.devel.redhat.com> <20151110194938.GA47666@tevye.fc.hp.com> <CAPcyv4ihgRUVtQQtSxfi8byF+_YhcDsLb9hQDwrkCNXPA3iCDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4625.austin.hp.com ([15.73.212.76]:36024 "EHLO
	g2t4625.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbKJUxR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 15:53:17 -0500
In-Reply-To: <CAPcyv4ihgRUVtQQtSxfi8byF+_YhcDsLb9hQDwrkCNXPA3iCDw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Jerry Hoemann <Jerry.Hoemann@hpe.com>
Cc: linux-nvdimm <linux-nvdimm@ml01.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 11/10/2015 3:27 PM, Dan Williams wrote:
> On Tue, Nov 10, 2015 at 11:49 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>> On Tue, Nov 10, 2015 at 12:51:59PM -0500, Jeff Moyer wrote:
>>> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
>>>
>>>> Add IOCTL type 'P' to denote NVDIMM_TYPE_PASSTHRU.
>>>
>>> Can't you just make passthrough a separate command?  If you actually add
>>
>> There are multiple conflicting NVDIMM _DSM running around, they
>> are "device specific".  So, we should plan in general and not just
>> for the example DSM that Intel added support for.  These DSM have
>> over lapping and incompatible function ids.
>>
>> The Intel example is an example,  not standard. They are free to
>> change it at will. So, we can't be certain there won't be a
>> conflict some time in the future if we try to use their number space.
>>
>> I'm trying to create a generic pass thru that any vendors can use.  Putting
>> this in the Intel function number space doesn't make a lot of sense to me.
>
> It isn't the "Intel" function number space.  The fact that they
> currently align is just a happy accident.

It's not really a happy accident. Your commit message says it
was derived from the Intel spec 'for convenience', which I think is convenient
for anything that implements that spec.

We've discussed ways of supporting different command sets with you
and determined that this pass-through mechanism was a good approach
because it allows multiple different command sets to be support in
a generic way.  Blending the two flavors (generic pass through and explicit
function definitions) is confusing to me.

> The kernel is free to break
> the 1:1 ioctl number to DSM function number relationship, and I think
> it would make the implementation cleaner in this case.

To me it's less clean and even for your own example spec, less
convenient if Intel ever updates that spec.

-- ljk
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
>

