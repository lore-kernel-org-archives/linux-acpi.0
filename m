From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Sun, 21 Sep 2008 19:42:59 +0100
Message-ID: <48D695B3.5000303@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:35698 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYIUSnE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Sep 2008 14:43:04 -0400
Received: by ik-out-1112.google.com with SMTP id c30so660760ika.5
        for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2008 11:43:02 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Alexey Starikovskiy wrote:

> Here is the patch.
>
> Please try/review.
>
> Regards,
> Alex.
> Alan Jenkins wrote:
>>
>> Sounds sensible. Hopefully we're right that most systems with these
>> broken EC's don't want the workaround. I assume you will still notify
>> the user automatically, something like "acpi: ec: GPE storm detected,
>> try booting with ec=poll".

My apologies.  I seem to have tested this but neglected to reply :-(.

I've been running with this for a week or so now.  I've been bashing the
hotkeys (and holding down the ones with autorepeat), and it works fine. 
Plus I get the message in the kernel log suggesting ec_intr=0 if the
keyboard doesn't work.  It's all good.

Thanks
Alan
