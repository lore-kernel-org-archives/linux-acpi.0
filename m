From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v2 resend] ACPI: generate wakeup events on fixed power button
Date: Mon, 28 May 2012 16:52:47 -0600
Message-ID: <CAMLZHHSxf0xeQi88=uOa+Fsf5iFApzFmGcjf9=ShjW3eAFdK6w@mail.gmail.com>
References: <20120509230843.C3EF79D401E@zog.reactivated.net>
	<201205102208.28013.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46788 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab2E1Wws (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2012 18:52:48 -0400
In-Reply-To: <201205102208.28013.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, pgf@laptop.org, rui.zhang@intel.com

On Thu, May 10, 2012 at 2:08 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, May 10, 2012, Daniel Drake wrote:
>> When the system is woken up by the ACPI fixed power button, currently there
>> is no way of userspace becoming aware that the power button was pressed.
>>
>> OLPC would like to know this, so that we can respond appropriately.
>> For example, if the system was woken up by a network packet, we know
>> we can go back to sleep very quickly. But if the user explicitly woke the
>> system with the power button, we're going to want to stay awake for a
>> while.
>>
>> The wakeup count mechanism seems like a good fit for communicating this.
>> Mark the fixed power button as wakeup-enabled, and increment its wakeup
>> counter when the system is woken with the power button. (The wakeup counter
>> is also incremented when the power button is pressed during system
>> operation; this is already handled by an existing acpi-button codepath).
>>
>> Signed-off-by: Daniel Drake <dsd@laptop.org>
>> Acked-by: Zhang Rui <rui.zhang@intel.com>
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
>
> Len, this looks like v3.5 material to me, any chance to pick it up?

Bump. Any news here? Would love to see it in 3.5.

Thanks
Daniel
