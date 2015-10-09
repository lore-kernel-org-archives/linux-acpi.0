From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] acpi: nfit: Add support for hotplug
Date: Fri, 9 Oct 2015 11:13:06 -0700
Message-ID: <CAPcyv4jt4mLj7yXGcLO_5uOkssKnGAS6v5sUtP_KeBufbRRe5Q@mail.gmail.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	<1444254577-23744-4-git-send-email-vishal.l.verma@intel.com>
	<x4937xkj6a3.fsf@segfault.boston.devel.redhat.com>
	<1444414122.9638.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38534 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbbJISNH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2015 14:13:07 -0400
Received: by wiclk2 with SMTP id lk2so77727005wic.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2015 11:13:06 -0700 (PDT)
In-Reply-To: <1444414122.9638.13.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>

On Fri, Oct 9, 2015 at 11:08 AM, Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
> On Fri, 2015-10-09 at 13:33 -0400, Jeff Moyer wrote:
>> Vishal Verma <vishal.l.verma@intel.com> writes:
>>
>> > Add a .notify callback to the acpi_nfit_driver that gets called on
>> > a
>> > hotplug event. From this, evaluate the _FIT ACPI method which
>> > returns
>> > the updated NFIT with handles for the hot-plugged NVDIMM.
>> >
>> > Iterate over the new NFIT, and add any new tables found, and
>> > register/enable the corresponding regions.
>> >
>> > In the nfit test framework, after normal initialization, update the
>> > NFIT
>> > with a new hot-plugged NVDIMM, and directly call into the driver to
>> > update its view of the available regions.
>>
>> OK, so just plugging in new NVDIMMs is supported, right?  Are there
>> plans to support unplugging DIMMs?
>
> Right, this is hot-add only until someone has a hot-remove use case.
>

...someone meaning ACPI, since it only defines a hot-add flow.  We
could prototype something for the virtualization provisioning use
case, but it's not part of the current spec.
