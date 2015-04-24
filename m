From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [Linux-nvdimm] [PATCH 08/21] nd: ndctl.h, the nd ioctl abi
Date: Fri, 24 Apr 2015 09:31:00 -0700
Message-ID: <CAPcyv4imiOJbze62xfT6L82uEUnH0P-6CtCbQypR=aSqTAnq=Q@mail.gmail.com>
References: <20150418013256.25237.96403.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150418013557.25237.81354.stgit@dwillia2-desk3.amr.corp.intel.com>
	<1429890991.16996.55.camel@misato.fc.hp.com>
	<1429891777.16996.58.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35777 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933009AbbDXQbB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2015 12:31:01 -0400
Received: by widdi4 with SMTP id di4so28470119wid.0
        for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2015 09:31:00 -0700 (PDT)
In-Reply-To: <1429891777.16996.58.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>

On Fri, Apr 24, 2015 at 9:09 AM, Toshi Kani <toshi.kani@hp.com> wrote:
> On Fri, 2015-04-24 at 09:56 -0600, Toshi Kani wrote:
>> On Fri, 2015-04-17 at 21:35 -0400, Dan Williams wrote:
>> > Most configuration of the nd-subsystem is done via nd-sysfs.  However,
>> > the NFIT specification defines a small set of messages that can be
>> > passed to the subsystem via platform-firmware-defined methods.  The
>> > command set (as of the current version of the NFIT-DSM spec) is:
>> >
>> >     NFIT_CMD_SMART: media health and diagnostics
>> >     NFIT_CMD_GET_CONFIG_SIZE: size of the label space
>> >     NFIT_CMD_GET_CONFIG_DATA: read label
>> >     NFIT_CMD_SET_CONFIG_DATA: write label
>> >     NFIT_CMD_VENDOR: vendor-specific command passthrough
>> >     NFIT_CMD_ARS_CAP: report address-range-scrubbing capabilities
>> >     NFIT_CMD_START_ARS: initiate scrubbing
>> >     NFIT_CMD_QUERY_ARS: report on scrubbing state
>> >     NFIT_CMD_SMART_THRESHOLD: configure alarm thresholds for smart events
>>
>> "nd/bus.c" provides two features, 1) the top level ND bus driver which
>> is the central part of the ND, and 2) the ioctl interface specific to
>> the example-DSM-interface.  I think the example-DSM-specific part should
>> be put into an example-DSM-support module, so that the ND can support
>> other _DSMs as necessary.  Also, _DSM needs to be handled as optional.
>
> And the same for "nd/acpi.c", which is 1) the ACPI0012 handler, and 2)
> the example-DSM-support module.  I think they need to be separated.
>

Ok, send me a patch as I'm not sure what type of separation you are proposing.
