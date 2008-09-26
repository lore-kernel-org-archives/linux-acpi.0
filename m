From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 19:21:41 +0400
Message-ID: <48DCFE05.7050702@suse.de>
References: <20080925170030.15311.27823.stgit@thinkpad> <200809261615.10488.rjw@sisk.pl> <48DCF75E.7030106@gmail.com> <200809261718.41641.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:45230 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752545AbYIZPVi (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 11:21:38 -0400
In-Reply-To: <200809261718.41641.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, Sitsofe Wheeler <sitsofe@yahoo.com>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
>> He refers to the ec->curr (former ec->t).
> 
> Hm, I'm not sure what the failing scenario in this case would be.
Last one was the thread of the stack is killed during transaction,
thus stack vanishes and interrupt goes over freed memory.

