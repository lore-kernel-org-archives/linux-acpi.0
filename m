From: "Nalla, Ravikanth" <ravikanth.nalla@hpe.com>
Subject: RE: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements
Date: Tue, 3 May 2016 16:17:40 +0000
Message-ID: <49D617FA63152941907AADE32CF072F12FF09400@G4W3290.americas.hpqcorp.net>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
 <20160426183611.GC27803@localhost> <571FBACB.1020606@codeaurora.org>
 <49D617FA63152941907AADE32CF072F12FF09187@G4W3290.americas.hpqcorp.net>
 <57279551.3010000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:35162 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134AbcECQRt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 May 2016 12:17:49 -0400
In-Reply-To: <57279551.3010000@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "timur@codeaurora.org" <timur@codeaurora.org>, "cov@codeaurora.org" <cov@codeaurora.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "K, Harish (MCOU/UPEL)" <harish.k@hpe.com>, "Reghunandanan, Ashwin (STSD)" <ashwin.reghunandanan@hpe.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


-----Original Message-----
From: Sinan Kaya [mailto:okaya@codeaurora.org] 
Sent: Monday, May 02, 2016 11:29 PM
To: Nalla, Ravikanth <ravikanth.nalla@hpe.com>; Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org; timur@codeaurora.org; cov@codeaurora.org; linux-pci@vger.kernel.org; lenb@kernel.org; K, Harish (MCOU/UPEL) <harish.k@hpe.com>; Reghunandanan, Ashwin (STSD) <ashwin.reghunandanan@hpe.com>; bhelgaas@google.com; rjw@rjwysocki.net; linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements

On 5/2/2016 1:44 PM, Nalla, Ravikanth wrote:
>> Thanks, can the HPE developers in CC test the series in order to avoid another revert? 
>  I'm facing below errors while applying these patches on mainline 
> kernel for verification. Please check and let me know what is the 
> issue or if I'm  missing  anything. I use outlook for mail and I 
> copied your mail formatted patches into each individual file manually 
> and converted these files into  unix format (using dos2unix cmd)  and when trying to apply with cmd "patch -p1  patch1.patch" /  "git apply patch1.patch" i see  below errors. I'm getting similar errors for remaining  patches too and also "checkpatch.pl" looks to be throwing errors. Hence I'm not able to  verify your changes.

>This should get you the patch files.

>https://patchwork.ozlabs.org/patch/611493/raw/
>https://patchwork.ozlabs.org/patch/611496/raw/
>https://patchwork.ozlabs.org/patch/611495/raw/
>https://patchwork.ozlabs.org/patch/611494/raw/

>You can download the mailbox files here and do "git am" instead

>https://patchwork.ozlabs.org/patch/611493/mbox/
>https://patchwork.ozlabs.org/patch/611496/mbox/
>https://patchwork.ozlabs.org/patch/611495/mbox/
>https://patchwork.ozlabs.org/patch/611494/mbox/

The above mbox patches worked with "git apply".  We have now verified the fix after applying these 4 patches on a 60 CPU system 
with mainline kernel (4.6-rc6) and we don't see any panic or issues during boot (multiple). We will try verifying on a high end system 
and we will let you know the results.

--
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
