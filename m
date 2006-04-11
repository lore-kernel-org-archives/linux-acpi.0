From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Power-button event after resume from S3
Date: Tue, 11 Apr 2006 09:11:18 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11E39CC@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35006 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932244AbWDKBLa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Apr 2006 21:11:30 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felix Kuehling <fkuehlin@ati.com>
Cc: linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>, Samuel Li <samli@ati.com>

>Before working on a patch I'd like to be sure that there is a general
>consensus that this is indeed The Right Way (TM) to fix the problem.
>Whose blessing would a patch need before being accepted?

I think this is the simplest and right way to fix this problem.
And, it should be accepted. :-)

>> Probably, you need to hack acpi_button_notify.
>> like:
>> 
>> if (acpi_in_suspend)
>> 	don't generate event.

More precisely,  it should be:
acpi_button_notify:
	if(acpi_during_suspend_resume)
		don't generate power button event to confuse user space
daemon,


