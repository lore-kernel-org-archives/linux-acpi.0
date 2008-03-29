From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata-acpi: don't call _GTF for disabled drive
Date: Sat, 29 Mar 2008 22:30:35 +0900
Message-ID: <47EE447B.3090800@gmail.com>
References: <1206435045.23794.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:16719 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYC2Nar (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Mar 2008 09:30:47 -0400
Received: by wf-out-1314.google.com with SMTP id 28so638477wff.4
        for <linux-acpi@vger.kernel.org>; Sat, 29 Mar 2008 06:30:47 -0700 (PDT)
In-Reply-To: <1206435045.23794.13.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Garzik <jgarzik@pobox.com>

Shaohua Li wrote:
> I got below log after a S3 resume in a ASUS A6VC laptop. The system has
> only one IDE drive. It appears there is no reason calling _GTF for
> disabled drive.
> 
> ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node df822bd0), AE_AML_OPERAND_VALUE
> ata2.00: _GTF evaluation failed (AE 0x3006)
> ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV1._GTF] (Node df822b94), AE_AML_OPERAND_VALUE
> ata2.01: _GTF evaluation failed (AE 0x3006)
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Acked-by: Tejun Heo <htejun@gmail.com>

Thanks for catching this.

-- 
tejun
