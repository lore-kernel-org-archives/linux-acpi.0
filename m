From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [BUG] System runs very slow with high cooling_device state
Date: Thu, 28 Jul 2011 21:43:07 +0100
Message-ID: <20110728204307.GA20661@srcf.ucam.org>
References: <CANq1E4RGP5P3F+u1t0pCj9G1pSxoiCr3-9E6QaSSfTfJWj+NgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60402 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab1G1UnL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jul 2011 16:43:11 -0400
Content-Disposition: inline
In-Reply-To: <CANq1E4RGP5P3F+u1t0pCj9G1pSxoiCr3-9E6QaSSfTfJWj+NgQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Thu, Jul 28, 2011 at 10:39:06AM +0200, David Herrmann wrote:

> Is there an easy way to debug this? Does running oprofile help? Or am
> I just misunderstanding what "cooling_deviceX" does?

When the colling device type is "Processor", that means that it's 
reducing heat output by slowing down the processor.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
