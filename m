From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 12:27:00 -0800
Message-ID: <CAPcyv4ihgRUVtQQtSxfi8byF+_YhcDsLb9hQDwrkCNXPA3iCDw@mail.gmail.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
	<x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
	<20151110194938.GA47666@tevye.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38071 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbbKJU1B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 15:27:01 -0500
Received: by wmec201 with SMTP id c201so19100762wme.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2015 12:27:00 -0800 (PST)
In-Reply-To: <20151110194938.GA47666@tevye.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Hoemann <Jerry.Hoemann@hpe.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>

On Tue, Nov 10, 2015 at 11:49 AM, Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
> On Tue, Nov 10, 2015 at 12:51:59PM -0500, Jeff Moyer wrote:
>> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
>>
>> > Add IOCTL type 'P' to denote NVDIMM_TYPE_PASSTHRU.
>>
>> Can't you just make passthrough a separate command?  If you actually add
>
> There are multiple conflicting NVDIMM _DSM running around, they
> are "device specific".  So, we should plan in general and not just
> for the example DSM that Intel added support for.  These DSM have
> over lapping and incompatible function ids.
>
> The Intel example is an example,  not standard. They are free to
> change it at will. So, we can't be certain there won't be a
> conflict some time in the future if we try to use their number space.
>
> I'm trying to create a generic pass thru that any vendors can use.  Putting
> this in the Intel function number space doesn't make a lot of sense to me.

It isn't the "Intel" function number space.  The fact that they
currently align is just a happy accident.  The kernel is free to break
the 1:1 ioctl number to DSM function number relationship, and I think
it would make the implementation cleaner in this case.
