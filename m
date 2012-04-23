From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: How to detect reason for ACPI wakeup?
Date: Mon, 23 Apr 2012 14:03:40 -0600
Message-ID: <CAErSpo7fOL_JD8eTJSESfJ5BnXvE5BZWkv02mJQmozj0ngu1LA@mail.gmail.com>
References: <20120417171709.GC5632@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50983 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753286Ab2DWUED (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Apr 2012 16:04:03 -0400
Received: by lahj13 with SMTP id j13so9462049lah.19
        for <linux-acpi@vger.kernel.org>; Mon, 23 Apr 2012 13:04:00 -0700 (PDT)
In-Reply-To: <20120417171709.GC5632@merlins.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: linux-acpi@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Zhang Rui <rui.zhang@intel.com>

On Tue, Apr 17, 2012 at 11:17 AM, Marc MERLIN <marc@merlins.org> wrote:
> Howdy,
>
> My HTPC goes to sleep (S3) and resumes just fine (via RTC or WOL).
>
> My problem is that I need to know whether it woke up from RTC or WOL and I
> find nothing in dmesg that gives me a clue for the wakeup reason.
>
> Is it something that I can get from somewhere?

http://marc.info/?l=linux-acpi&m=133478932527097&w=2 is a similar sort
of request; maybe something similar could be done.

Bjorn
