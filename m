From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Wed, 30 Jul 2008 19:11:34 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3550 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965AbYGaCLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 22:11:55 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, "Kleen, Andi" <andi.kleen@intel.com>

Looking at this patch, I see that it solves a very specific case, namely
the AE_NOT_FOUND exception. However, this is just one of many exceptions
that we may want to ignore. In fact, I wonder if in the general case we
should just ignore all exceptions from _REG methods, other than printing
some kind of message.

Bob


>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Joshua C.
>Sent: Wednesday, July 30, 2008 7:03 PM
>To: linux-acpi@vger.kernel.org
>Subject: Re: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method
and
>continue to initialize EC
>
>On Mon, Jul 28, 2008 at 14:59:26AM +0800, Andi Kleen wrote:
>> >Subject:ACPI: Ignore AE_NOT_FOUND error of EC _REG method and
continue
>to initialize EC
>> >From: Zhao Yakui <yakui.zhao@intel.com>
>>Thanks. Queued for test. How urgent is this? Do we need to consider it
>>for .27?
>>
>>-Andi
>
>It will be great if you can put this in .27.
>
>--joshua
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
