From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] PCI: Add information about describing PCI in ACPI
Date: Tue, 29 Nov 2016 15:39:11 -0800
Message-ID: <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34547 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbcK2XjN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Nov 2016 18:39:13 -0500
Received: by mail-io0-f177.google.com with SMTP id c21so301682932ioj.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Nov 2016 15:39:12 -0800 (PST)
In-Reply-To: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Lv Zheng <lv.zheng@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Bjorn, this email was marked as spam, because:

  It has a from address in google.com but has failed google.com's
required tests for authentication

in particular, it looks like you used a non-google smtp server
(kernel.org) to send the email, so there is no DKIM hash (or perhaps
google just uses some other non-standard marker for "this actually
came from google"). So gmail marks it as spam because dmarc fails:

       dmarc=fail (p=REJECT dis=NONE) header.from=google.com

Just to let you know. If you use your google.com email, you do need to
go through the google smtp server.

This may or may not be new - I didn't go and look at old messages of
yours, but it is possible that google.com enabled dmarc/dkim recently.

             Linus

On Tue, Nov 29, 2016 at 1:39 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Here's another stab at this writeup.  I'd appreciate any comments!
