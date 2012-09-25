From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH 1/2] lib: Add early cpio decoder
Date: Mon, 24 Sep 2012 20:47:17 -0700
Message-ID: <50612945.6050906@linux.intel.com>
References: <1346318957-5831-1-git-send-email-trenn@suse.de> <1346318957-5831-2-git-send-email-trenn@suse.de> <50463399.70506@zytor.com> <201209211451.12523.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7842 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785Ab2IYDrT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Sep 2012 23:47:19 -0400
In-Reply-To: <201209211451.12523.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, robert.moore@intel.com, Fenghua Yu <fenghua.yu@intel.com>, initramfs@vger.kernel.org, bigeasy@linutronix.de, vojcek@tlen.pl, eric.piel@tremplin-utc.net, linux-acpi@vger.kernel.org, yinghai@kernel.org

On 09/21/2012 05:51 AM, Thomas Renninger wrote:
> I guess I understand the first part, not sure about the "last left off" 
> bit.
> "Multiple sources" means bootloader already points to multiple sources,
> right?
> This is somewhat out of scope as this would need both, bootloader and
> kernel adjustings.
> This is about "built in" which means multiple cpios concatenated together
> and passed via bootloader as one "file" (initrd).
> At least I understand it that way.
> The only disadvantage I run into is that once the cpios are concatenated,
> I couldn't figure out an easy way how to slice them into separate
> cpio/zip archives again.

No, that's not the issue.

The issue is that there isn't just one initramfs blob, there are
(currently) *TWO*... one loaded by the bootloader and one compiled into
the kernel.

	-hpa
