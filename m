From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Fri, 22 Aug 2008 11:50:11 +0100
Message-ID: <48AE99E3.7090702@tuffmail.co.uk>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org> <48AD5BBB.2050701@suse.de> <48AD6F14.9080700@tuffmail.co.uk> <48AD73E9.9090904@suse.de> <48AD7EBD.9030507@tuffmail.co.uk> <48AD9160.90005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:46396 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbYHVKuS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Aug 2008 06:50:18 -0400
Received: by wr-out-0506.google.com with SMTP id 69so339554wri.5
        for <linux-acpi@vger.kernel.org>; Fri, 22 Aug 2008 03:50:17 -0700 (PDT)
In-Reply-To: <48AD9160.90005@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: akpm@linux-foundation.org, andi@firstfloor.org, linux-acpi@vger.kernel.org, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

Alexey Starikovskiy wrote:
> Here is the patch.
>
> Please try/review.
>
Sorry, I can't help with testing this any more.  The "bad state" I
complained about earlier seems to be permanent now.

I left the laptop with AC and battery disconnected last night.  This
morning both 2.6.22 and 2.6.24-19-generic (ubuntu) are locking up or
rebooting as soon as I press a hotkey.  The patch resets the default
behaviour back to 2.6.24, so it won't make any difference.

None of these kernels should have the GPE polling problem.  There are
many people using Ubuntu on the EeePC without complaint; I must have
damaged the hardware or firmware.

OTOH 2.6.21.4-eeepc (the pre-installed kernel from Xandros/Asus) is
immune.  I will work on it, but don't expect anything soon.

Thanks for your help
Alan
