From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Touchpad and i8042
Date: Sat, 19 May 2007 16:42:21 +0100
Message-ID: <20070519154220.GA14506@srcf.ucam.org>
References: <200705191828.09719.dev.list@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:47648 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759127AbXESPml (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 May 2007 11:42:41 -0400
Content-Disposition: inline
In-Reply-To: <200705191828.09719.dev.list@mircea.bardac.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mircea Bardac <dev.list@mircea.bardac.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sat, May 19, 2007 at 06:28:08PM +0300, Mircea Bardac wrote:

> I've noticed a weird behaviour when monitoring roughly the number of 
> interrupts fired. The number of interrupts for "i8042" increase dramatically 
> when I move the pointer using the touchpad.

The touchpad is attached to an i8042. When you touch it, it sends data 
and generates interrupts. That's perfectly normal.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
