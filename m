From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 20:23:48 +0100
Message-ID: <20090730192348.GA22421@srcf.ucam.org>
References: <20090730190243.GA22016@srcf.ucam.org> <Pine.LNX.4.44L0.0907301511030.6087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36458 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZG3TXt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 15:23:49 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0907301511030.6087-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Shaohua Li <shaohua.li@intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 30, 2009 at 03:15:46PM -0400, Alan Stern wrote:

> P.S.: Besides which, you can't put these Intel UHCI controllers into D3
> because they don't support PCI PM.  Controllers from other vendors
> (i.e., VIA) do.

There's an out of band wakeup mechanism via ACPI for the Intel ones. It 
works for remote wakeups and disconnects - it's the connects I'm having 
trouble with. Given that all PCI PM events are delivered via ACPI on 
standard x86, the only difference it makes from an implementation 
viewpoint is whether or not you have to enable the PME bits.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
