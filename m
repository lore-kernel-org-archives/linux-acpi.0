From: Kamala Narasimhan <Kamala.Narasimhan@citrix.com>
Subject: Resume from sleep fails on HP 6930p with the latest Linux kernel
 when iommu is enabled
Date: Wed, 9 Sep 2009 21:53:21 -0400
Message-ID: <5997D0BE578D47409D1EBD41DFD341F4777E182DCD@FTLPMAILBOX01.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:29146 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZIJBxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2009 21:53:18 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>

I encounter an issue with resume from S3 failing on HP 6930p with the latest Linux kernel when iommu is enabled.  Is this a known issue?  Does anyone have any advice on how to fix/further investigate this problem?

Points to note:

1)	This issue is reproducible only with the latest Linux kernel and a regression from older ones.
2)	iommu should be enabled through kernel build config or intel_iommu=on kernel command line.
3)	Happens only on HP 6930p.
4)	Appears to be related to enable translation unit code in the iommu resume code path.

How to reproduce the problem?

1)	Fetch latest Linux kernel.
2)	Build with CONFIG_DMAR_DEFAULT_ON or enable iommu through kernel command line intel_iommu=on.
3)	Enter S3 after booting with the newly built kernel on HP 6930p.
4)	Attempt to resume from S3 and that should fail.

Let me know if you need further information to help with this issue.

Thanks,
Kamala
