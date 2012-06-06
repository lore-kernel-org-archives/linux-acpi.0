From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Wed, 6 Jun 2012 10:21:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206061020080.1788-100000@iolanthe.rowland.org>
References: <4FCEB80E.3070100@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51162 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755651Ab2FFOV6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jun 2012 10:21:58 -0400
In-Reply-To: <4FCEB80E.3070100@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Wed, 6 Jun 2012, Lan Tianyu wrote:

> > If "auto" does nothing, there's no reason to put it in this patch at
> > all.  It could be added in a later patch, along with its
> > implementation.
> OK. I prefer to remove "auto" option in this patch. We can further discuss
> the function of "auto".

Sounds good.

One more problem -- your implementation of "off" isn't quite right.  
You need to update hub_power_on() too.

Alan Stern

