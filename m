From: "Joshua C." <joshuacov@googlemail.com>
Subject: Re: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Thu, 31 Jul 2008 04:03:02 +0200
Message-ID: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:15185 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbYGaCDE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 22:03:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so156140nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2008 19:03:03 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Mon, Jul 28, 2008 at 14:59:26AM +0800, Andi Kleen wrote:
> >Subject:ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
> >From: Zhao Yakui <yakui.zhao@intel.com>
>Thanks. Queued for test. How urgent is this? Do we need to consider it
>for .27?
>
>-Andi

It will be great if you can put this in .27.

--joshua
