From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 1/4] ACPI: Add acpi_pr_<level>() interfaces
Date: Thu, 19 Jul 2012 17:43:57 -0600
Message-ID: <1342741437.3010.275.camel@misato.fc.hp.com>
References: <1342644027-19559-1-git-send-email-toshi.kani@hp.com>
	 <1342644027-19559-2-git-send-email-toshi.kani@hp.com>
	 <1342648771.5138.37.camel@lorien2>
	 <1342650386.3010.55.camel@misato.fc.hp.com>
	 <1342651257.5138.44.camel@lorien2>
	 <1342651966.3010.66.camel@misato.fc.hp.com>
	 <1342653482.5138.56.camel@lorien2>
	 <1342658296.3010.136.camel@misato.fc.hp.com>
	 <1342714515.3100.27.camel@lorien2>
	 <1342718897.3010.188.camel@misato.fc.hp.com>
	 <1342725950.5599.7.camel@lorien2>
	 <1342731093.3010.245.camel@misato.fc.hp.com>
	 <1342737168.6809.40.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:46264 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab2GSXsn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jul 2012 19:48:43 -0400
In-Reply-To: <1342737168.6809.40.camel@lorien2>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shuah.khan@hp.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com, shuahkhan@gmail.com

On Thu, 2012-07-19 at 16:32 -0600, Shuah Khan wrote:
> On Thu, 2012-07-19 at 14:51 -0600, Toshi Kani wrote:
> 
> > If your concern is actually a performance bottleneck in acpi_get_name()
> > you found in the code, you should report it to the ACPI CA team.
> 
> I have tried my best to get you to understand the problems in bigger
> picture your patch set can exacerbate. Looking to somebody else to fix
> the problems doesn't help. It doesn't look like we can come to an
> agreement here, we just have to agree to disagree.

I am not asking someone to fix it.  I tried my best to explain that
acpi_get_name() does not lead any performance issue when it is called in
the error paths of ACPI drivers, and why we have to call it to obtain an
object path info for error analysis.  If you still believe there is a
performance issue in calling acpi_get_name() under this context, please
help us understand where the performance bottleneck is in the code.  (I
hope you just concerned it because it has "acpi_" prefix...) I will then
work on the issue with the ACPI CA team.

Thanks,
-Toshi



> caio,
> -- Shuah
> 


