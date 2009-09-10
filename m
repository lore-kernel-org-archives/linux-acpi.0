From: Kamala Narasimhan <Kamala.Narasimhan@citrix.com>
Subject: RE: Resume from sleep fails on HP 6930p with the latest Linux
 kernel when iommu is enabled
Date: Wed, 9 Sep 2009 23:47:31 -0400
Message-ID: <5997D0BE578D47409D1EBD41DFD341F4777E182DD1@FTLPMAILBOX01.citrite.net>
References: <5997D0BE578D47409D1EBD41DFD341F4777E182DCD@FTLPMAILBOX01.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:17628 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbZIJDra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2009 23:47:30 -0400
In-Reply-To: <5997D0BE578D47409D1EBD41DFD341F4777E182DCD@FTLPMAILBOX01.citrite.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>

[Adding Fenghua Yu to the thread as he submitted the iommu suspend/resume patch (https://lists.linux-foundation.org/pipermail/iommu/2009-March/001247.html) which pertains to this issue]

Thought I would clarify that resume from S3 would have never worked with intel_iommu enabled on HP 6930p as opposed to this being a regression for the following reasons -

1) Before the above mentioned patch, when intel_iommu is enabled, during S3/resume we would encounter a kernel crash due to lack of iommu suspend/resume support.
2) After iommu suspend/resume support was added, resume failed on HP 6930p due to enable translation unit code added by the above patch to the iommu resume code path.

Thanks,
Kamala

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Kamala Narasimhan
> Sent: Wednesday, September 09, 2009 9:53 PM
> To: 'linux-acpi@vger.kernel.org'
> Subject: Resume from sleep fails on HP 6930p with the latest Linux
> kernel when iommu is enabled
> 
> I encounter an issue with resume from S3 failing on HP 6930p with the
> latest Linux kernel when iommu is enabled.  Is this a known issue?
> Does anyone have any advice on how to fix/further investigate this
> problem?
> 
> Points to note:
> 
> 1)	This issue is reproducible only with the latest Linux kernel and
> a regression from older ones.
> 2)	iommu should be enabled through kernel build config or
> intel_iommu=on kernel command line.
> 3)	Happens only on HP 6930p.
> 4)	Appears to be related to enable translation unit code in the
> iommu resume code path.
> 
> How to reproduce the problem?
> 
> 1)	Fetch latest Linux kernel.
> 2)	Build with CONFIG_DMAR_DEFAULT_ON or enable iommu through kernel
> command line intel_iommu=on.
> 3)	Enter S3 after booting with the newly built kernel on HP 6930p.
> 4)	Attempt to resume from S3 and that should fail.
> 
> Let me know if you need further information to help with this issue.
> 
> Thanks,
> Kamala
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
