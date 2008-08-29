From: Tejun Heo <tj@kernel.org>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Fri, 29 Aug 2008 12:20:14 +0200
Message-ID: <48B7CD5E.1050701@kernel.org>
References: <48A35FE6.1080903@tlinx.org> <48B60373.2050501@tlinx.org> <48B64DB3.6060906@kernel.org> <200808281436.30089.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41584 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbYH2KV4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Aug 2008 06:21:56 -0400
In-Reply-To: <200808281436.30089.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux acpi <linux-acpi@vger.kernel.org>

Thomas Renninger wrote:
> Also the system is really old. Why don't you stick to pci=noacpi or
> even acpi=off?
> What advantage do you want to get with ACPI (SATA works?)?

I think this is the second time I see ACPI IRQ routing doesn't work on
old ACPI.  Is it possible to detect this and turn off automatically?  Or
does that risk breaking even more machines?

Thanks.

-- 
tejun
