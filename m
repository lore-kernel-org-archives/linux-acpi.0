From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Panasonic Let's Note laptop extras driver
Date: Wed, 2 Jul 2008 14:17:59 +0100
Message-ID: <20080702131759.GA5419@srcf.ucam.org>
References: <20080702090044.GB12272@prithivi.gnumonks.org> <20080702101919.GB699@srcf.ucam.org> <20080702130315.GA4064@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42843 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbYGBNSF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 09:18:05 -0400
Content-Disposition: inline
In-Reply-To: <20080702130315.GA4064@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-acpi@vger.kernel.org, Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca

On Wed, Jul 02, 2008 at 09:03:15PM +0800, Harald Welte wrote:
> Hi Matthew,
> > 
> > Hm. Does this mean that the keymap isn't changable at runtime?
> 
> i wasn't aware that those kind of keymaps could be changeable at
> runtime.  Will read up on my homework ;)

Especially when you have a case where there's a scancode that isn't 
mapped to anything by default, it's helpful to let it be changed at 
runtime. I usually just copy the code from wistron_btns whenever I'm 
implementing this.

> > And shouldn't be adding any new files to /proc. Anything that can't be 
> > expressed via the existing generic sysfs classes should be an attribute 
> > on a sysfs platform device.
> 
> that's what I generally know from other drivers (and how I do it in
> other kernel code).  But I wasn't sure what the policy with regard to
> this was for ACPI.

The long-term goal is to kill off /proc/acpi entirely, so adding new 
things is kind of frowned upon :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
