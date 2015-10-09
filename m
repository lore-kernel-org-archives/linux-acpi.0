From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] acpi: add a utility function for evaluating _FIT
Date: Fri, 9 Oct 2015 10:56:26 -0700
Message-ID: <CAPcyv4ihZa4LRxwsgnWFDGwBcRGw-Jb5n29iMBVPcHKF5538yQ@mail.gmail.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	<1444254577-23744-3-git-send-email-vishal.l.verma@intel.com>
	<x497fmwj6ia.fsf@segfault.boston.devel.redhat.com>
	<1444413246.9638.7.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33034 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbJIR42 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2015 13:56:28 -0400
Received: by wiclk2 with SMTP id lk2so80744967wic.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2015 10:56:27 -0700 (PDT)
In-Reply-To: <1444413246.9638.7.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>

On Fri, Oct 9, 2015 at 10:54 AM, Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
> On Fri, 2015-10-09 at 13:28 -0400, Jeff Moyer wrote:
>> Vishal Verma <vishal.l.verma@intel.com> writes:
>>
>> >  /**
>> > + * acpi_evaluate_fit: Evaluate _FIT method to get an updated NFIT
>> > + * @handle: ACPI device handle
>> > + * @buf: buffer for the updated NFIT
>> > + *
>> > + * Evaluate device's _FIT method if present to get an updated NFIT
>> > + */
>> > +acpi_status acpi_evaluate_fit(acpi_handle handle, struct
>> > acpi_buffer **buf)
>> > +{
>> > +   acpi_status status;
>> > +   struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL
>> > };
>> > +
>> > +   status = acpi_evaluate_object(handle, "_FIT", NULL,
>> > &buffer);
>> > +
>> > +   if (ACPI_FAILURE(status))
>> > +           return status;
>> > +
>> > +   *buf = &buffer;
>>
>> Umm, unless I'm missing something, you're returning a stack address.
>
> Good point, you're right. Dan/Rafael, is it OK to just remove this
> patch entirely, and call acpi_evaluate_object directly from nfit.c? The
> current way did feel a bit kludgey to me any way because I was
> allocating a buffer here (above), but trying to free it in the caller,
> which seems very ugly..

Open coding a call to acpi_evaluate_object() sounds good to me.
