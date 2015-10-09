From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/3] nfit: in acpi_nfit_init, break on a 0-length table
Date: Fri, 9 Oct 2015 10:27:48 -0700
Message-ID: <CAPcyv4hnFY7xCZ9e6kZrruj48Z9WfY3V5RU00Nxxb3sfbTV_JQ@mail.gmail.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
	<1444254577-23744-2-git-send-email-vishal.l.verma@intel.com>
	<x49bnc8j6ro.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35143 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbbJIR1t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2015 13:27:49 -0400
Received: by wicge5 with SMTP id ge5so77668942wic.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2015 10:27:48 -0700 (PDT)
In-Reply-To: <x49bnc8j6ro.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Fri, Oct 9, 2015 at 10:23 AM, Jeff Moyer <jmoyer@redhat.com> wrote:
> Vishal Verma <vishal.l.verma@intel.com> writes:
>
>> If acpi_nfit_init is called (such as from nfit_test), with an nfit table
>> that has more memory allocated than it needs (and a similarly large
>> 'size' field, add_tables would happily keep adding null SPA Range tables
>> filling up all available memory.
>>
>> Make it friendlier by breaking out if a 0-length header is found in any
>> of the tables.
>
> Shouldn't that at least spew a warning?  Or does the spec allow for
> zero-length tables?
>

The spec allows for zero length tables but the firmware implementation
should be self consistent and not report a total NFIT size that is
greater than the sum of the size of the sub-structures.  A warning /
nudge to firmware developers to fix their stuff seems appropriate.
