From: Andrew Morton <akpm@osdl.org>
Subject: Re: [Bug 6997] insmod of tg3 gives IRQ handler type mismatch on HP
 nc6220 notebook
Date: Sun, 13 Aug 2006 13:46:32 -0700
Message-ID: <20060813134632.8879a2c5.akpm@osdl.org>
References: <200608132030.k7DKUQ6e008416@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:1453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751418AbWHMUqu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Aug 2006 16:46:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7DKklnW009075
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sun, 13 Aug 2006 13:46:49 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k7DKkWR3026277
	for <linux-acpi@vger.kernel.org>; Sun, 13 Aug 2006 13:46:32 -0700
In-Reply-To: <200608132030.k7DKUQ6e008416@fire-2.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Sun, 13 Aug 2006 13:30:26 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=6997

Could someone please take a look at this bug from an ACPI POV?  I _think_
what's happened is that APCI decided to move his tg3 NIC onto a different
interrupt, causing it to collide with an i2c driver which doesn't share
interrupts.

I don't know what part of the kernel is at fault here, but it's a dead box.

Thanks.
