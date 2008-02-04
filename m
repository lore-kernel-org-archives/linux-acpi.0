From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: suspend to ram problem
Date: Mon, 04 Feb 2008 07:57:28 +0100
Message-ID: <47A6B758.7070405@free.fr>
References: <47A5C399.7010405@free.fr> <47A5DE60.1080402@free.fr> <200802031839.02397.rjw@sisk.pl> <20080203181855.GB1629@elf.ucw.cz> <47A60AA8.8050407@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:35500 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbYBDG5e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 01:57:34 -0500
In-Reply-To: <47A60AA8.8050407@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

matthieu castet wrote:
> Pavel Machek wrote:

>> Hmm, maybe I know where problem could be. Try
>>
>>         movl     $(wakeup_stack - wakeup_code), %esp              # 
>> Private stack is needed for ASUS bo\
>>
>> instead of existing stack setup. That helped on one of my test-boxes
> Thanks, I will try that.
> Because clearing the flags imply pop/push in the stack it could be the 
> problem
That doesn't help : it still crash in pushl $0.

Matthieu

