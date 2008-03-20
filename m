From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [patch 2.6.25-rc6 7/7] PCI set up device.power.can_wakeup
 flags
Date: Thu, 20 Mar 2008 17:53:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803201750010.881-100000@netrider.rowland.org>
References: <200803201425.54587.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:4440 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757428AbYCTVxI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Mar 2008 17:53:08 -0400
In-Reply-To: <200803201425.54587.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Thu, 20 Mar 2008, David Brownell wrote:

> A previous version of this patch broke on PowerPC platforms after they
> changed how they do early PCI initialization (following the first version
> of this patch).  Potentially the real fix involves switching PCI init on
> all platforms so they all adopt the driver model "init() then add()" model,
> calling device_initialize() early and pci_setup_device() before device_add().

Would it help to break this apart into two patches: the first to switch 
PCI over to the driver model approach, and the second to set up the 
can_wakeup flags?  Those really are two very different goals.

What are the barriers to doing the first part right now?  Is it just 
PPC?

Alan Stern

