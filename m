From: "Joshua C." <joshuacov@googlemail.com>
Subject: Re: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Thu, 31 Jul 2008 13:21:37 +0200
Message-ID: <5f6f8c5f0807310421n7d85995bqa5bc832902183c16@mail.gmail.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>
	 <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
	 <1217485738.4006.73.camel@yakui_zhao.sh.intel.com>
	 <5f6f8c5f0807310219y2f7ddd6p85531c464bd9bde3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:59220 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYGaLVj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jul 2008 07:21:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so201940nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 31 Jul 2008 04:21:37 -0700 (PDT)
In-Reply-To: <5f6f8c5f0807310219y2f7ddd6p85531c464bd9bde3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

2008/7/31 Zhao Yakui <yakui.zhao@intel.com>:
> Yes.  This patch only solves the specific case. For example: in the bug
> 8953, 10237.
>
> But if all the exceptions from the _REG methods are ignored, it will be
> too aggressive. Maybe some potential problems will be hidden. We had
> better wait for that more people complain the similar bugs.
>
> Thanks.
>
 I agree with that. Maybe not all exceptions should be ignored.
