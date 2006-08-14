From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [Bug 6997] insmod of tg3 gives IRQ handler type mismatch on HP
          nc6220 notebook
Date: Mon, 14 Aug 2006 10:02:03 -0600 (MDT)
Message-ID: <1939.24.9.204.52.1155571323.squirrel@mail.cce.hp.com>
References: <200608132030.k7DKUQ6e008416@fire-2.osdl.org>   
    <20060813134632.8879a2c5.akpm@osdl.org>
    <1897.24.9.204.52.1155566160.squirrel@mail.cce.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ccerelrim02.cce.hp.com ([161.114.21.23]:5658 "EHLO
	ccerelrim02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751474AbWHNQCF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Aug 2006 12:02:05 -0400
In-Reply-To: <1897.24.9.204.52.1155566160.squirrel@mail.cce.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org

>>> http://bugzilla.kernel.org/show_bug.cgi?id=6997

> If there's no such thing as i2c-pca-isa on ACPI boxes, maybe its driver
> should just exit early if ACPI is enabled, instead of claiming a random
> IRQ that isn't connected to anything and nobody else in the system
> knows about.

On second thought, it seems addled that a non-ACPI driver should have
anything to do with checking whether ACPI is enabled.  Maybe there is
or could be a way for ACPI to notice that IRQ 10 is already in use
exclusively and avoid it.

