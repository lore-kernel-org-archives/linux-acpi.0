From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 14:20:40 -0800
Message-ID: <CAPcyv4gcZrLZ6YvZ87MUsMVQcEnUKMihQkjJ1uGZVFshYr2AVA@mail.gmail.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
	<x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
	<20151110194938.GA47666@tevye.fc.hp.com>
	<CAPcyv4ihgRUVtQQtSxfi8byF+_YhcDsLb9hQDwrkCNXPA3iCDw@mail.gmail.com>
	<56425939.7000605@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36590 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbKJWUl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 17:20:41 -0500
Received: by wmww144 with SMTP id w144so137376564wmw.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2015 14:20:40 -0800 (PST)
In-Reply-To: <56425939.7000605@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: Jerry Hoemann <Jerry.Hoemann@hpe.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, Nov 10, 2015 at 12:53 PM, Linda Knippers <linda.knippers@hpe.com> wrote:
> On 11/10/2015 3:27 PM, Dan Williams wrote:
>>
>> On Tue, Nov 10, 2015 at 11:49 AM, Jerry Hoemann <jerry.hoemann@hpe.com>
>> wrote:
>>>
>>> On Tue, Nov 10, 2015 at 12:51:59PM -0500, Jeff Moyer wrote:
>>>>
>>>> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
>>>>
>>>>> Add IOCTL type 'P' to denote NVDIMM_TYPE_PASSTHRU.
>>>>
>>>>
>>>> Can't you just make passthrough a separate command?  If you actually add
>>>
>>>
>>> There are multiple conflicting NVDIMM _DSM running around, they
>>> are "device specific".  So, we should plan in general and not just
>>> for the example DSM that Intel added support for.  These DSM have
>>> over lapping and incompatible function ids.
>>>
>>> The Intel example is an example,  not standard. They are free to
>>> change it at will. So, we can't be certain there won't be a
>>> conflict some time in the future if we try to use their number space.
>>>
>>> I'm trying to create a generic pass thru that any vendors can use.
>>> Putting
>>> this in the Intel function number space doesn't make a lot of sense to
>>> me.
>>
>>
>> It isn't the "Intel" function number space.  The fact that they
>> currently align is just a happy accident.
>
>
> It's not really a happy accident. Your commit message says it
> was derived from the Intel spec 'for convenience', which I think is
> convenient
> for anything that implements that spec.

Right, and now its no longer convenient to keep things one to one.

> We've discussed ways of supporting different command sets with you
> and determined that this pass-through mechanism was a good approach
> because it allows multiple different command sets to be support in
> a generic way.  Blending the two flavors (generic pass through and explicit
> function definitions) is confusing to me.
>
>> The kernel is free to break
>> the 1:1 ioctl number to DSM function number relationship, and I think
>> it would make the implementation cleaner in this case.
>
>
> To me it's less clean and even for your own example spec, less
> convenient if Intel ever updates that spec.

If that spec is ever updated any new commands will be implemented with
this new generic envelope as the marshaling mechanism.  I'd also look
to convert the existing commands into this new envelope and deprecate
the existing per-DSM-function number approach.  Finally I don't look
at this as purely "passthru" as the kernel will want to crack open the
input payload for commands that it cares about with kernel relevant
side effects, like namespace label updates.
