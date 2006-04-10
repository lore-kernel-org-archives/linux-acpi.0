From: Felix Kuehling <fkuehlin@ati.com>
Subject: RE: Power-button event after resume from S3
Date: Mon, 10 Apr 2006 16:47:31 -0400
Message-ID: <1144702051.340.53.camel@localhost.localdomain>
References: <554C5F4C5BA7384EB2B412FD46A3BAD11906E5@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:18083 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750765AbWDJUrj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Apr 2006 16:47:39 -0400
Received: from outbound2-ash.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-ash-R.bigfish.com (Postfix) with ESMTP id 66C2574B95F
	for <linux-acpi@vger.kernel.org>; Mon, 10 Apr 2006 20:47:39 +0000 (UTC)
Received: from mail64-ash-R.bigfish.com (unknown [172.18.2.1])
	by outbound2-ash.bigfish.com (Postfix) with ESMTP id 5E39774B94B
	for <linux-acpi@vger.kernel.org>; Mon, 10 Apr 2006 20:47:39 +0000 (UTC)
Received: from mail64-ash.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail64-ash-R.bigfish.com (Postfix) with ESMTP id 52EB34E75DE
	for <linux-acpi@vger.kernel.org>; Mon, 10 Apr 2006 20:47:39 +0000 (UTC)
Received: from mail4.ati.com (h209-50-91-134.gtconnect.net [209.50.91.134])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mail64-ash.bigfish.com (Postfix) with ESMTP id 293664E71EB
	for <linux-acpi@vger.kernel.org>; Mon, 10 Apr 2006 20:47:39 +0000 (UTC)
Received: from torcaexgw1.atitech.com (exchange.atitech.com [172.24.5.245])
	by mail4.ati.com (8.13.1/8.13.1) with ESMTP id k3AKlTmj025535
	for <linux-acpi@vger.kernel.org>; Mon, 10 Apr 2006 16:47:38 -0400
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD11906E5@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>, Samuel Li <samli@ati.com>

On Fri, 2006-07-04 at 10:49 +0800, Yu, Luming wrote:
> >Are there plans for a real fix for this problem, either in the 
> >kernel or
> >in acpid?
> >
> 
> We need a  patch to handle the wakeup power-button event.
> Do you want to hack a patch for this?

Before working on a patch I'd like to be sure that there is a general
consensus that this is indeed The Right Way (TM) to fix the problem.
Whose blessing would a patch need before being accepted?

Thanks,
  Felix

> 
> Probably, you need to hack acpi_button_notify.
> like:
> 
> if (acpi_in_suspend)
> 	don't generate event.
> 
> --Luming
> 


