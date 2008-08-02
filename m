From: "Joshua C." <joshuacov@googlemail.com>
Subject: Re: [PATCH] ACPI: Ignore AE_NOT_FOUND error of EC _REG method and continue to initialize EC
Date: Sat, 2 Aug 2008 07:32:49 +0200
Message-ID: <5f6f8c5f0808012232v69a5bd13m914ebab27c87cb18@mail.gmail.com>
References: <5f6f8c5f0807301903p5018e656y743d131822b4056e@mail.gmail.com>
	 <9D39833986E69849A2A8E74C1078B6B3BFA98A@orsmsx415.amr.corp.intel.com>
	 <1217485738.4006.73.camel@yakui_zhao.sh.intel.com>
	 <48920EE0.6030808@gmail.com>
	 <1217556196.6766.24.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:40048 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYHBFcv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Aug 2008 01:32:51 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1468776ika.5
        for <linux-acpi@vger.kernel.org>; Fri, 01 Aug 2008 22:32:49 -0700 (PDT)
In-Reply-To: <1217556196.6766.24.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

2008/8/1 Zhao Yakui <yakui.zhao@intel.com>:
> On Thu, 2008-07-31 at 23:13 +0400, Alexey Starikovskiy wrote:
>> NAK.
>>
>> As already mentioned, there is no point to put this workaround in ec.c.
>> Instead, it should be placed into acpi_register_operation_region, or may
>> be even
>> higher (like a flag to ignore errors during execution of the method).
> Maybe what your said is right. The generic method about ignoring the
> error during the execution of the method is very good. But it will
> become more complicated. Maybe it is too aggressive and will have other
> side effect that we can't know.
>
> As the acpi_install_address_space_handler is realized in ACPICA and
> called by other drivers, it is not appropriate to ignore the error in
> the generic ACPICA function. At the same time this error is related with
> EC device, maybe it is more appropriate that EC driver determines
> whether OS continues to initialize EC device.
>
> IMO this workaround patch can fix the issue that is related with the EC
> _REG method(For example: bug 8953, 10237). At the same time this will
> have no effect on the other systems.
>
> best regards.
>   Yakui

I  also support these arguments. The supposed method will complicate
the whole process and take more time to be realised. For now this
patch has effekt only on relatively small number of machines that are
related to bugs 8953 and 10237. Otherwise, it won't affect other
systems. So I don't see any obstacles to putting this in the
mainstream.

--joshua
