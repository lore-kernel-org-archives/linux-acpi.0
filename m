From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [Bug 6997] insmod of tg3 gives IRQ handler type mismatch on HP
     nc6220 notebook
Date: Mon, 14 Aug 2006 08:36:00 -0600 (MDT)
Message-ID: <1897.24.9.204.52.1155566160.squirrel@mail.cce.hp.com>
References: <200608132030.k7DKUQ6e008416@fire-2.osdl.org>
    <20060813134632.8879a2c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ccerelrim03.cce.hp.com ([161.114.21.24]:19330 "EHLO
	ccerelrim03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932257AbWHNOgC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Aug 2006 10:36:02 -0400
In-Reply-To: <20060813134632.8879a2c5.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org

> On Sun, 13 Aug 2006 13:30:26 -0700
> bugme-daemon@bugzilla.kernel.org wrote:
>
>> http://bugzilla.kernel.org/show_bug.cgi?id=6997
>
> Could someone please take a look at this bug from an ACPI POV?  I _think_
> what's happened is that APCI decided to move his tg3 NIC onto a different
> interrupt, causing it to collide with an i2c driver which doesn't share
> interrupts.

i2c-pca-isa requests IRQ 10 exclusively (non-shared).  It has no
mechanism for detecting whether its hardware is actually present,
so I see no path where it will ever release IRQ 10.

ACPI might have moved the tg3 IRQ to collide with the i2c-pca-isa one,
but I don't know what it could do differently.  If the i2c-pca-isa
thing were described as an ACPI device (which it should be, if it
appears on modern boxes), the driver could be fixed to pay attention
to what the BIOS is trying to tell it.  8250_pnp.c is a good example
of how to do that.

If there's no such thing as i2c-pca-isa on ACPI boxes, maybe its driver
should just exit early if ACPI is enabled, instead of claiming a random
IRQ that isn't connected to anything and nobody else in the system
knows about.

