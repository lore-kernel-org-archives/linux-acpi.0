From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: 3.12.0-rc3: Symbol license change in commit caf5c03f (ACPI: Move
 acpi_bus_get_device() from bus.c to scan.c)
Date: Tue, 01 Oct 2013 17:21:25 -0400
Message-ID: <524B3CD5.3030904@hurleysoftware.com>
References: <524AFF89.4080703@hurleysoftware.com> <5459219.RfezHuQcWu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:33358 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751492Ab3JAVV1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Oct 2013 17:21:27 -0400
In-Reply-To: <5459219.RfezHuQcWu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux kernel <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 10/01/2013 05:00 PM, Rafael J. Wysocki wrote:
> On Tuesday, October 01, 2013 12:59:53 PM Peter Hurley wrote:
>> I have no love lost for proprietary modules but changing
>> acpi_bus_get_device() symbol's license seems gratuitous considering
>> the symbol pre-dates the mainline git tree and the code is just
>> being moved from one source file to another.
>
> Well, I didn't know whether or not any binary modules use that function in the
> first place.
>
> It looks like some of them do, so below is a revert of that change (that I'm
> going to push for -rc4).
>
> I wonder what module exactly you have in mind, though?

For 3.12, the nouveau driver wants to use MSIs by default.
Unfortunately, some hardware which should support it doesn't.

The binary driver recently migrated to MSIs by default as well,
so I was testing to see if the hardware could run stably with that
driver with MSIs on (since I don't use the binary driver, I needed to
experiment).

Switching back and forth between the drivers is really error-prone;
instead, I sacrificed an older partition/userspace, where I confirmed
that the binary driver does run stably with MSIs -- on kernel 3.2.x.

When I tried to repeat the testing on 3.12-rc2 & -rc3, I happened
upon this change.

Regards,
Peter Hurley







