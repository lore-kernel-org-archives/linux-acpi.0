From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Provide /sys/../ec with read/write access and some cleanups
Date: Thu, 01 Jul 2010 23:47:13 +0300
Message-ID: <1278017233.7029.7.camel@localhost.localdomain>
References: <1277996570-2686-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36737 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab0GAUrR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jul 2010 16:47:17 -0400
In-Reply-To: <1277996570-2686-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, astarikovskiy@suse.de

On Thu, 2010-07-01 at 17:02 +0200, Thomas Renninger wrote:
> These patches are diffed against the test branch of the ACPI tree, but also
> patch fine with 2.6.35-rc3.
> 
> I thought about tainting the kernel if someone writes to the EC, but as
> userspace can also write to graphics IO, PCI config or MSRs, it shouldn't
> matter that much.
> Eventually this should still be added (by a separate patch), one can easily
> confuse the EC to not switch on the fans anymore.
> 
> A small tool to read out and write to /sys/devices/system/ec/*/io can be
> found here:
> ftp://ftp.suse.com/pub/people/trenn/sources/ec/ec_access.c
> 
> Len: Can you apply these into your test branch and schedule them for linux-next
> and 2.6.36 if there are no objections, please.
> 
> Thanks,
> 
>      Thomas

This is great patchset, I was even thinking doing that myself.

While at it, could you also provide a broken down table of EC GPEs like
the one in /sys/firmware/acpi/interrupts/ ?

Best regards,
	Maxim Levitsky

