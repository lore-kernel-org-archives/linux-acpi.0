From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 0/2] i915 brightness control
Date: Mon, 13 Sep 2010 18:48:48 +0100
Message-ID: <20100913174847.GA10443@srcf.ucam.org>
References: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54413 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0IMRsw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Sep 2010 13:48:52 -0400
Content-Disposition: inline
In-Reply-To: <1275516702-27090-1-git-send-email-kamal@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Wed, Jun 02, 2010 at 03:11:40PM -0700, Kamal Mostafa wrote:

> In order to avoid the often-dysfunctional native acpi brightness control
> methods, a new acpi_brightness_hook interface is made available.
> 
> The i915 driver uses the new hook to take over brightness control.
> Boot with i915.brightness=0 to disable.

I've looked into this issue more closely and think I've worked out the 
underlying problem. The system in question appears to have two GPUs and 
exposes two ACPI backlight devices. Both of these are associated with 
existing PCI devices, so we don't ignore either of them because of that. 
Further, one of them (the AMD one) implements the spec properly and 
should work. We don't seem to perform a more fine-grained check to 
identify whether every ACPI backlight has all the required methods, and 
so as a result we provide both the working one and the non-working one.

Having thought about this some more, I don't think this is the right 
approach. We should be ensuring that every backlight ahs all the 
required methods and then dropping the one that doesn't. This should be 
replaced with a native i915 backlight, and I sent patches to do that 
last week.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
