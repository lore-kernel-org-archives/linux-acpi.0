From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 16:15:09 +0200
Message-ID: <200809261615.10488.rjw@sisk.pl>
References: <20080925170030.15311.27823.stgit@thinkpad> <200809261433.53674.rjw@sisk.pl> <9D7649D18729DE4BB2BD7B494F7FEDC201DE13D8@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32831 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbYIZOJt (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 10:09:49 -0400
In-Reply-To: <9D7649D18729DE4BB2BD7B494F7FEDC201DE13D8@pdsmsx415.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhao, Yakui" <yakui.zhao@intel.com>
Cc: Sitsofe Wheeler <sitsofe@yahoo.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Friday, 26 of September 2008, Zhao, Yakui wrote:
> Alan gives a suggestion that after processing the EC notification event, EC driver
> should continue to issue the query command and process the EC notification
> event until the query command returns zero. 
> But this suggestion will break my laptop. On my laptop when issuing the query
> command, a non-zero query event is  returned but it can't be processed.(There
> is no corresponding ACPI _Qxx object). At the same time the SCI_EVT bit won't
> be cleared. In such case OS can't exit the function of acpi_ec_query_handler,
> which causes that the acpid kernel thread can't work well.

Well, perhaps we should exit acpi_ec_query_handler() if SCI_EVT is clear _or_
the processing of an event fails due to the lack of a _Qxx object?  Alex?

> In fact according to my analysis IMO Alexey's patch will break my laptop.

That obviously would be a regression.

> But now the laptop is not in my hand and I can't do the test. After I own the
> laptop again, I will do the test and attach the corresponding info.

OK, how much time is it going to take, approximately?

> At the same time there are two generic issues in this patch:
>    a. spin_lock is overkill. When 2000 EC I/O read/write are executed, the
>    CPU interrupt will be disabled for about 1.5ms. This will affect the normal
>    laptops.

OTOH, I think we need _some_ locking in there in order to prevent races from
happening.

>    b. the local variable that resides in process stack space is used in
>    interrupt-context.

Which one?

Rafael
