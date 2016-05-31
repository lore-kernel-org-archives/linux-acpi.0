From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Regression in IO resource allocation
Date: Wed, 1 Jun 2016 00:32:19 +0200
Message-ID: <CAJZ5v0iKRnU6gBHcyjqVBwCJf_rJsb-PTiCsRRtSENeZKMcr+Q@mail.gmail.com>
References: <CAL1RGDW9z1FhgQwJZTkk0kUBipT68hmW2C4--3Hbb5vzj5ta2w@mail.gmail.com>
	<3491327.Z9FVFNvO7z@vostro.rjw.lan>
	<CAL1RGDUfCuZ0qiQT4xUf0koS3uxfXfBPMfYL41tkjB_cM36Nfw@mail.gmail.com>
	<CAJZ5v0jOg-oTDEZodhLHD5iz039kKP-UCQoB92nZ8=_qhSa-HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38020 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbcEaWcU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 May 2016 18:32:20 -0400
In-Reply-To: <CAJZ5v0jOg-oTDEZodhLHD5iz039kKP-UCQoB92nZ8=_qhSa-HA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <roland@purestorage.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jun 1, 2016 at 12:31 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, May 31, 2016 at 11:42 PM, Roland Dreier <roland@purestorage.com> wrote:
>> On Tue, May 31, 2016 at 2:11 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> Can you please try the appended patch (untested)?
>>
>> Thanks for the quick reply.  Patch looks OK on my system... it boots
>> (which is very good :) and I see
>>
>>     system 00:01: [io  0x0400-0x047f] has been reserved
>>
>> however I don't see the "ACPI CPU throttle" region reserved in
>> /proc/ioports... haven't debugged why acpi_processor_get_throttling()
>> isn't getting called or what is happening yet.
>>
>> Will dig a bit deeper and let you know.
>
> It may not be called at all if _PTC is used on that system, for example.

I mean acpi_processor_get_throttling_fadt(), of course. :-)
