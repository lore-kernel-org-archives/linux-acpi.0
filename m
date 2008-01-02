From: Lee Howard <faxguy@howardsilvan.com>
Subject: Re: controlling ACPI IRQ routing
Date: Wed, 02 Jan 2008 15:59:55 -0800
Message-ID: <477C257B.1090705@howardsilvan.com>
References: <47742083.5060903@howardsilvan.com> <1198814721.20418.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from frodo.howardsilvan.com ([66.119.206.113]:53127 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYABX75 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 18:59:57 -0500
In-Reply-To: <1198814721.20418.3.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org

(I'm still looking into this matter...)

Shaohua Li wrote:
> In IOAPIC mode, interrupt priority isn't related with the pin (in your
> case, irq 16 or 19), but the vector of the pin.

Just to help my understanding a bit... does the Linux ACPI driver 
determine which IRQ numbers are given to certain devices?  And if so, 
how does it make those assignments?

Thanks,

Lee.
