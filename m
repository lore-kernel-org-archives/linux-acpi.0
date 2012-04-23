From: Daniel Drake <dsd@laptop.org>
Subject: Re: How to detect reason for ACPI wakeup?
Date: Mon, 23 Apr 2012 14:26:37 -0600
Message-ID: <CAMLZHHTS14ZQmO5H6E3vy8zhW=yRtCN2O3KaYraAtd0TXNd1ng@mail.gmail.com>
References: <20120417171709.GC5632@merlins.org>
	<CAErSpo7fOL_JD8eTJSESfJ5BnXvE5BZWkv02mJQmozj0ngu1LA@mail.gmail.com>
	<CAMLZHHRmRWUdFxPdhQ3ZE==NXFEMTRG2UKK1=aTPbqa6YMLoKg@mail.gmail.com>
	<20120423202450.GD11480@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:40981 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab2DWU0i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Apr 2012 16:26:38 -0400
Received: by mail-pz0-f51.google.com with SMTP id z8so16022027dad.10
        for <linux-acpi@vger.kernel.org>; Mon, 23 Apr 2012 13:26:38 -0700 (PDT)
In-Reply-To: <20120423202450.GD11480@merlins.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc MERLIN <marc@merlins.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On Mon, Apr 23, 2012 at 2:24 PM, Marc MERLIN <marc@merlins.org> wrote:
> Thanks for the patches.
>
> Do you know if either is likely to ever make it to mainline?

I'm planning on pestering people until they do. The button wakeup one
has been acked so I assume that one is close.
Waiting for comments on the rtc-cmos patch.

Daniel
