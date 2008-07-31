From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Wed, 30 Jul 2008 20:06:29 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3BFA99C@orsmsx415.amr.corp.intel.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com> <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com> <38E5333AA17D0A4DABBB33D71000D2907CB3BE@swsmsx411.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15860 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbYGaDGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 23:06:31 -0400
Content-class: urn:content-classes:message
In-Reply-To: <38E5333AA17D0A4DABBB33D71000D2907CB3BE@swsmsx411.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kleen, Andi" <andi.kleen@intel.com>, "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org
Cc: "Lin, Ming M" <ming.m.lin@intel.com>

>>just ignore all
>>exceptions from _REG methods, other than printing some kind of
message.

Yes, I mean that some kind of warning would be appropriate.

There may be many places where we don't want to simply give up because
some method failed.

>-----Original Message-----
>From: Kleen, Andi
>Sent: Wednesday, July 30, 2008 7:20 PM
>To: Moore, Robert; 'Joshua C.'; 'linux-acpi@vger.kernel.org'
>Cc: Lin, Ming M
>Subject: RE: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method
and
>continue to initialize EC
>
>
>
>>Looking at this patch, I see that it solves a very specific
>>case, namely the AE_NOT_FOUND exception. However, this is just
>>one of many exceptions that we may want to ignore. In fact, I
>>wonder if in the general case we should just ignore all
>>exceptions from _REG methods, other than printing some kind of
message.
>
>You mean the exceptions should be silently ignored?  I think ignoring
>exceptions on more methods is probably a good idea.
>
>But at least some kind of warning would be probably good, wouldn't it?
>
>-Andi
