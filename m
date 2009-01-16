From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Fri, 16 Jan 2009 10:05:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901161001440.2417-100000@iolanthe.rowland.org>
References: <1232070900.3989.34.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57908 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755785AbZAPPFK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 10:05:10 -0500
In-Reply-To: <1232070900.3989.34.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 16 Jan 2009, Zhao Yakui wrote:

> Hi, Alan
>    Thanks for the detailed explanation. Understand the dependency
> between UHCI and EHCI. This should be considered in course of resuming.
>    I still have another question. 
>    There exists a ROOT HUB device for every UHCI/EHCI controllers.
> Should the dependency between UHCI root hub and EHCI root HUB be
> considered? 

No, there is no dependency between the root hubs.  Only between the PCI 
host controller devices.

>    Should the UHCI root hub be resumed before EHCI root hub? (Of course
> the EHCI host controller will be resumed after UHCI host controllers).

It doesn't matter.  We are already guaranteed that the EHCI root hub 
will be resumed after the EHCI host controller (likewise for UHCI)
and nothing more is needed.

Alan Stern

