From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Sun, 21 Sep 2008 23:17:29 +0400
Message-ID: <48D69DC9.5060100@suse.de>
References: <48D695B3.5000303@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:36312 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750877AbYIUTR2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Sep 2008 15:17:28 -0400
In-Reply-To: <48D695B3.5000303@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Hi Alan,
That patch is old news already...
There is a new shiny one appended to 9998/10724/11549...
Please give it a try. It does disable GPE, but for very small duration.

Regards,
Alex.


Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
> 
>> Here is the patch.
>>
>> Please try/review.
>>
>> Regards,
>> Alex.
>> Alan Jenkins wrote:
>>> Sounds sensible. Hopefully we're right that most systems with these
>>> broken EC's don't want the workaround. I assume you will still notify
>>> the user automatically, something like "acpi: ec: GPE storm detected,
>>> try booting with ec=poll".
> 
> My apologies.  I seem to have tested this but neglected to reply :-(.
> 
> I've been running with this for a week or so now.  I've been bashing the
> hotkeys (and holding down the ones with autorepeat), and it works fine. 
> Plus I get the message in the kernel log suggesting ec_intr=0 if the
> keyboard doesn't work.  It's all good.
> 
> Thanks
> Alan

