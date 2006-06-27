From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: Acer smart battery: acpi_sbs and linux-2.6.17
Date: Tue, 27 Jun 2006 12:07:12 +0200
Message-ID: <m2zmfyykrz.fsf@phoenix.squirrel.nl>
References: <449F18D9.7060507@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:40201 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751316AbWF0KHS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 06:07:18 -0400
In-Reply-To: <449F18D9.7060507@rrz.uni-koeln.de> (Berthold Cogel's message
 of "Mon, 26 Jun 2006 01:14:33 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: linux-acpi@vger.kernel.org

Berthold Cogel <cogel@rrz.uni-koeln.de> writes:

> I've tried the modified acpi_sbs patch (acpi_sbs-20060422, modified by
> Johan Vromans) for linux-2.6.16 with linux-2.6.17.

Just did the same for my WLMi4001.

> The patch applies and builds without a problem. The same for both
> modules (acpi_sbs and i2c-acpi-ec). The modules work. But when the
> battery is charged, I get divide errors from the kernel.

Hmm. I've yet to see this problem, but I'll be careful (and save
often) for a while.

I remember that when I first tried the patch with 2.6.16 I got a
kernel crash once in the beginning, but never since.

(I'd really hope someone with more kernel expertise would stand up and
help a hand with this patch.)

-- Johan

