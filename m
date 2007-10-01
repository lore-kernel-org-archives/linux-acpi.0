From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 2/2] ACPICA: hw: Don't carry spinlock over suspend
Date: Tue, 02 Oct 2007 00:27:43 +0400
Message-ID: <4701583F.9060507@gmail.com>
References: <20070930183936.32654.44391.stgit@samsung> <20070930183942.32654.16220.stgit@samsung> <200710012238.09274.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:18186 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbXJAU1t (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Mon, 1 Oct 2007 16:27:49 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1963269ugc
        for <Linux-acpi@vger.kernel.org>; Mon, 01 Oct 2007 13:27:47 -0700 (PDT)
In-Reply-To: <200710012238.09274.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Rafael J. Wysocki wrote:
> On Sunday, 30 September 2007 20:39, Alexey Starikovskiy wrote:
>> ACPI uses acpi_get_register() in order to get into suspend.
>> This function is guarded by acpi_gbl_hardware_lock, which will be carried
>> into resume phase.
>> At resume interrupts are enabled and first ACPI interrupt deadlocks on this
>> lock.
> 
> Ouch.  That might have bitten quite some people, I guess.
> 
>> Solution seems to be to not lock register read, as there are no concurrent
>> activity at this point.
>>
>> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=7499
>>
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> Do you think it's -stable material?
Seem to be trivial.

Regards,
Alex.
