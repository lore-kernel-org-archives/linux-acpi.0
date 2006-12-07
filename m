From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 00/21] ACPI: ibm-acpi: cleanups, extended fan/thermal support
Date: Thu, 7 Dec 2006 17:35:25 -0200
Message-ID: <20061207193525.GA1263@khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net> <200612070123.25992.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45631 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S938001AbWLGTfd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2006 14:35:33 -0500
Content-Disposition: inline
In-Reply-To: <200612070123.25992.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Thu, 07 Dec 2006, Len Brown wrote:
> Henrique,
> FYI, A pull of this branch will take everything included underneath it.
> In this case, it will take all the contents of acpi-test that this branch is built upon.
> 
> That is fine for testing, but it isn't a path to upstream b/c
> not everything in acpi-test is going to get sent up to Linus at the same time as ibm-acpi.

I was operating under the false idea that the flow should be ibm-acpi-devel
-> acpi-test -> linus.

> For this batch, I'll just re-parent the series, or re-commit the e-mail patches.

Thanks.

> But in the future, if you base your patches directly against some snapshot of Linus' tree
> and don't include anything else besides your changes, then I can pull it directly.
> Of course you can do both by checking your changes in on a branch off of Linus'
> baseline and then merging onto your mirror of acpi-test.  In that event I'd
> pull from your branch based on Linus' mirror.

Will do.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
