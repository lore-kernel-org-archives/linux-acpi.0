From: Daniel Drake <dsd@laptop.org>
Subject: Re: How to detect reason for ACPI wakeup?
Date: Mon, 23 Apr 2012 14:07:28 -0600
Message-ID: <CAMLZHHRmRWUdFxPdhQ3ZE==NXFEMTRG2UKK1=aTPbqa6YMLoKg@mail.gmail.com>
References: <20120417171709.GC5632@merlins.org>
	<CAErSpo7fOL_JD8eTJSESfJ5BnXvE5BZWkv02mJQmozj0ngu1LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:35621 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab2DWUH3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Apr 2012 16:07:29 -0400
Received: by dadz8 with SMTP id z8so16004693dad.10
        for <linux-acpi@vger.kernel.org>; Mon, 23 Apr 2012 13:07:28 -0700 (PDT)
In-Reply-To: <CAErSpo7fOL_JD8eTJSESfJ5BnXvE5BZWkv02mJQmozj0ngu1LA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc MERLIN <marc@merlins.org>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On Mon, Apr 23, 2012 at 2:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> My HTPC goes to sleep (S3) and resumes just fine (via RTC or WOL).
>>
>> My problem is that I need to know whether it woke up from RTC or WOL and I
>> find nothing in dmesg that gives me a clue for the wakeup reason.
>>
>> Is it something that I can get from somewhere?
>
> http://marc.info/?l=linux-acpi&m=133478932527097&w=2 is a similar sort
> of request; maybe something similar could be done.

Here's how you can detect RTC wakeup:
http://patchwork.ozlabs.org/patch/153612/

Daniel
