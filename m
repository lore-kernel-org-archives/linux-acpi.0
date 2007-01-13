From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18
 and later
Date: Sat, 13 Jan 2007 18:51:59 +0300
Message-ID: <45A9001F.1040008@linux.intel.com>
References: <beb91d720701110549r346991beh95547e912f68d98f@mail.gmail.com>	 <E3C0BCA40296C347AF7142161DB9FC8298EF3A@mssmsx411>	 <1e2af89e0701130429x7083b6d7we89174dd7e130364@mail.gmail.com>	 <45A8DAA9.3010300@linux.intel.com> <1e2af89e0701130533o7cdead43g9ab79b71f852ac71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:25337 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422702AbXAMPwH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 10:52:07 -0500
In-Reply-To: <1e2af89e0701130533o7cdead43g9ab79b71f852ac71@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Brett <matthew.brett@gmail.com>
Cc: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

Matthew Brett wrote:
> Hi,
>
>> If BIOS does not export fan controls to OS via DSDT, it means that BIOS
>> wants to control fans via its own means (hardware), this doesn't mean
>> that your machine is at risk, it only means that you are not allowed to
>> tamper with it...
>
> Well, except the original poster complained that linux but not windows
> was shutting down the fan - meaning - surely - that somehow linux is
> tampering with the fan when it should not.
>
> Best,
>
> Matthew
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
As it was said above, Linux has no means to do that. At least through 
ACPI framework.
