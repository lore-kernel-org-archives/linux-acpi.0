From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI: Add information about describing PCI in ACPI
Date: Wed, 30 Nov 2016 10:17:30 -0600
Message-ID: <20161130161730.GB13411@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbcK3QRe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 11:17:34 -0500
Content-Disposition: inline
In-Reply-To: <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Lv Zheng <lv.zheng@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 29, 2016 at 03:39:11PM -0800, Linus Torvalds wrote:
> Bjorn, this email was marked as spam, because:
> 
>   It has a from address in google.com but has failed google.com's
> required tests for authentication
> 
> in particular, it looks like you used a non-google smtp server
> (kernel.org) to send the email, so there is no DKIM hash (or perhaps
> google just uses some other non-standard marker for "this actually
> came from google"). So gmail marks it as spam because dmarc fails:
> 
>        dmarc=fail (p=REJECT dis=NONE) header.from=google.com
> 
> Just to let you know. If you use your google.com email, you do need to
> go through the google smtp server.
> 
> This may or may not be new - I didn't go and look at old messages of
> yours, but it is possible that google.com enabled dmarc/dkim recently.

Argh, thanks for letting me know.  Looks like I've had this broken for a
long time, but I didn't notice.  I think I have it fixed so git will record
the author as bhelgaas@google.com, but git/stgit will send email from
helgaas@kernel.org via the kernel.org smtp server.
