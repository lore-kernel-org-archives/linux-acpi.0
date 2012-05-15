From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Mon, 14 May 2012 18:47:26 -0700
Message-ID: <20120515014726.GL18754@xanatos>
References: <4FAD3A51.4010803@intel.com>
 <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
 <20120511183543.GF7920@kroah.com>
 <20120511201124.GF18754@xanatos>
 <20120511210940.8350.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64810 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab2EOBrj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2012 21:47:39 -0400
Content-Disposition: inline
In-Reply-To: <20120511210940.8350.qmail@stuge.se>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 11, 2012 at 11:09:40PM +0200, Peter Stuge wrote:
> Sarah Sharp wrote:
> > Theoretically there's no maximum number for xHCI root ports
> 
> Hm? Please clarify this?
> 
> HCSPARAMS1 MaxPorts is 8 bits and "Valid values are in the range of
> 1h to FFh."

Sorry, yes, you're correct, the maximum number of ports for xHCI is 255.
I was just trying to point out that it's possible that xHCI hosts will
have a much larger number of USB ports than what we've previously seen
on EHCI host controllers.

Sarah Sharp
