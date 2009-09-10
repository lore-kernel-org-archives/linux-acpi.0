From: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: Resume from sleep fails on HP 6930p with the latest Linux
 kernel when iommu is enabled
Date: Thu, 10 Sep 2009 10:19:04 -0700
Message-ID: <A6AD88C3F2289247BE726C37303E1EB8B98BB801@orsmsx505.amr.corp.intel.com>
References: <5997D0BE578D47409D1EBD41DFD341F4777E182DCD@FTLPMAILBOX01.citrite.net>
 <5997D0BE578D47409D1EBD41DFD341F4777E182DD1@FTLPMAILBOX01.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47187 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbZIJRTD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 13:19:03 -0400
In-Reply-To: <5997D0BE578D47409D1EBD41DFD341F4777E182DD1@FTLPMAILBOX01.citrite.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: 'Kamala Narasimhan' <Kamala.Narasimhan@citrix.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>

>[Adding Fenghua Yu to the thread as he submitted the iommu suspend/resume
>patch (https://lists.linux-foundation.org/pipermail/iommu/2009-
>March/001247.html) which pertains to this issue]
>
>Thought I would clarify that resume from S3 would have never worked with
>intel_iommu enabled on HP 6930p as opposed to this being a regression for
>the following reasons -
>
>1) Before the above mentioned patch, when intel_iommu is enabled, during
>S3/resume we would encounter a kernel crash due to lack of iommu
>suspend/resume support.
>2) After iommu suspend/resume support was added, resume failed on HP 6930p
>due to enable translation unit code added by the above patch to the iommu
>resume code path.

Yes, you are right. This is not a regression. Now we are talking about suspend/resume issue on HP 6930P. The suspend/resume patch should have been tested on many platforms either by me or by others for quite a while. So I would guess this is an issue specific to HP 6930p, e.g. BIOS issue.

Could you please send out log buffer message (from serial port or kdb) after the failure?

Thanks.

-Fenghua
