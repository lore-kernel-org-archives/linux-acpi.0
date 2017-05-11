From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Wed, 10 May 2017 21:38:58 -0400
Message-ID: <9a20df93-b9b3-cd49-0259-6047ddde9d66@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
 <3f2c5bcc-3499-d5ef-6955-778979d25b08@codeaurora.org>
 <5c77c025-e3a4-f317-e7bc-f76e19ed2b12@codeaurora.org>
 <20778615.CFpVNM6V8o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKBjB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 May 2017 21:39:01 -0400
In-Reply-To: <20778615.CFpVNM6V8o@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 5/10/2017 8:58 PM, Rafael J. Wysocki wrote:
>> When GED driver makes an AML call and the driver on the right side of the picture
>> is not present, GED driver gets an ACPI error return code. 
> This means that _EVT evaluation failed, right?
> 
> How does the _EVT in question look like?  What does make it depend on the
> other drivers to be present in particular?

This one was trying to use an I2C Operating Region. The QUP I2C driver was not loaded
yet. Since the I2C namespace handler was not registered, ACPI returned an error.


[    5.061989] ACPI Error: Result stack is empty! State=ffffe021fd9eac00 (20160930/dswstate-99)^M
[    5.061992] ACPI Error: Method parse/execution failed [\_SB.I1C2.ARBT.LCK] (Node ffffe0213c154988), AE_NOT_EXIST (20160930/psparse-543)^M
[    5.061998] ACPI Error: Method parse/execution failed [\_SB.I1C2.PDV0.GETI] (Node ffffe0213c154410), AE_NOT_EXIST (20160930/psparse-543)^M
[    5.062003] ACPI Error: Method parse/execution failed [\_SB.PHP0.GETI] (Node ffffe0213c135118), AE_NOT_EXIST (20160930/psparse-543)^M
[    5.062009] ACPI Error: Method parse/execution failed [\_SB.PHP0.PVNH] (Node ffffe0213c135dc0), AE_NOT_EXIST (20160930/psparse-543)^M
[    5.062013] ACPI Error: Method parse/execution failed [\_SB.PCI0.PEVN] (Node ffffe0213c133910), AE_NOT_EXIST (20160930/psparse-543)^M
[    5.062017] ACPI Error: Method parse/execution failed [\_SB.GED1.PCIM] (Node ffffe0213c121398), AE_NOT_EXIST (20160930/psparse-543)^M
[    5.062022] ACPI Error: Method parse/execution failed [\_SB.GED1._EVT] (Node ffffe0213c1217d0), AE_NOT_EXIST (20160930/psparse-543)^M


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
