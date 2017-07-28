From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PCI / ACPI / PM: Fix propagation of wakeup settings to bridges
Date: Fri, 28 Jul 2017 02:34:48 +0200
Message-ID: <2614123.s9HPuis7tD@aspire.rjw.lan>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41599 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751562AbdG1Amu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 20:42:50 -0400
In-Reply-To: <3116391.JNS1F4DjTg@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Friday, July 21, 2017 02:36:44 PM Rafael J. Wysocki wrote:
> Hi,
> 
> The device wakeup code in pci-acpi.c currently has a (theoretical) problem that
> it can disable wakeup for a bridge prematurely in some obscure conditions.
> 
> This is described in some more detail in the changelog of patch [3/3] and it
> has been there for quite a while, so it's nothing new, but it would be good
> to fix it at last and hence this series.
> 
> Patches [1/3] and [2/3] are mostly preparatory, although the former may be
> regarded as a fix by itself and the latter is a cleanup.

Hi Bjorn,

Since all of the patches in this series have been reviewed by Mika now, please
let me know if you have any concerns regarding them from the PCI angle.

Otherwise I'm going to queue them up for 4.14 early next week.

Thanks,
Rafael

