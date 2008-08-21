From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Thu, 21 Aug 2008 14:35:16 +0100
Message-ID: <48AD6F14.9080700@tuffmail.co.uk>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org> <48AD5BBB.2050701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:58282 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbYHUNfX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 09:35:23 -0400
Received: by nf-out-0910.google.com with SMTP id d3so466761nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 21 Aug 2008 06:35:22 -0700 (PDT)
In-Reply-To: <48AD5BBB.2050701@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: akpm@linux-foundation.org, andi@firstfloor.org, linux-acpi@vger.kernel.org, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

Alexey Starikovskiy wrote:
> Hi Andrew,
>
> As I understand, this patch is wrong according to comment #65 in bug
> #9998.
>
> Regards,
> Alex.

That's more likely to have been a problem with my other patches, ripping
out the QUERY_PENDING flag and GPE polling, with (what were to Alex)
predictably bad results.

You're right this patch needs testing on it's own.  But the current code
is definitely wrong.

If the "GPE polling" workaround is triggered, and there is a series of
events > one every 0.5s, the EC buffer can overflow.  All it needs is an
ACPI hotkey with fast enough autorepeat.  And I bet it's not just my EC
that breaks horribly when that happens.

Thanks
Alan
