From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: assumptions in acpi drivers
Date: Fri, 16 Oct 2009 10:13:10 +0100
Message-ID: <9b2b86520910160213o2cdbed8j8f4ef9f3ba47ad6f@mail.gmail.com>
References: <9b2b86520910100616n38e842e2m9cf306eb4e812077@mail.gmail.com>
	 <1255185595.30901.7.camel@dc7800.home>
	 <9b2b86520910110639g57b2c56ao19f9f1f687729f7d@mail.gmail.com>
	 <1255320452.12547.6.camel@dc7800.home>
	 <20091016043609.GA11582@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:49686 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbZJPJNs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2009 05:13:48 -0400
Received: by fxm18 with SMTP id 18so2149929fxm.37
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2009 02:13:11 -0700 (PDT)
In-Reply-To: <20091016043609.GA11582@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org

On 10/16/09, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Sun, Oct 11, 2009 at 10:07:32PM -0600, Bjorn Helgaas wrote:

>> Ooh, you're right, using atomic_inc_return() is much better.  I don't
>> know whether it needs to be thread-safe or not, but it doesn't hurt, and
>> it's nicer in the sense that it doesn't leave the singleton pointer
>> lying around where people would be tempted to use it instead of using
>> acpi_driver_data(device).
>
> A small note: while it might not be an issue for ACPI in general drivers
> can be detached from devices via sysfs bind/unbind attributes and so if
> using this singleton model xxx_remove() should take care of decrementing
> the counter and xxx_add() should do the same in error path.

I'm sure it does apply to ACPI drivers.  I'll make sure I do that, thanks!

Alan
