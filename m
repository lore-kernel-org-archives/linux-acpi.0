From: "Kleen, Andi" <andi.kleen@intel.com>
Subject: RE: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Thu, 31 Jul 2008 03:19:32 +0100
Message-ID: <38E5333AA17D0A4DABBB33D71000D2907CB3BE@swsmsx411.ger.corp.intel.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com> <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12787 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbYGaCTb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 22:19:31 -0400
Content-class: urn:content-classes:message
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org
Cc: "Lin, Ming M" <ming.m.lin@intel.com>

 

>Looking at this patch, I see that it solves a very specific 
>case, namely the AE_NOT_FOUND exception. However, this is just 
>one of many exceptions that we may want to ignore. In fact, I 
>wonder if in the general case we should just ignore all 
>exceptions from _REG methods, other than printing some kind of message.

You mean the exceptions should be silently ignored?  I think ignoring
exceptions on more methods is probably a good idea.

But at least some kind of warning would be probably good, wouldn't it?

-Andi
