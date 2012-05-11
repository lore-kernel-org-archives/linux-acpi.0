From: Peter Stuge <peter@stuge.se>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
	for device fixed on the motherboard
Date: Fri, 11 May 2012 23:09:40 +0200
Message-ID: <20120511210940.8350.qmail@stuge.se>
References: <4FAD3A51.4010803@intel.com> <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org> <20120511183543.GF7920@kroah.com> <20120511201124.GF18754@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foo.stuge.se ([212.116.89.98]:32936 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753457Ab2EKVJm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 17:09:42 -0400
Content-Disposition: inline
In-Reply-To: <20120511201124.GF18754@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

Sarah Sharp wrote:
> Theoretically there's no maximum number for xHCI root ports

Hm? Please clarify this?

HCSPARAMS1 MaxPorts is 8 bits and "Valid values are in the range of
1h to FFh."


//Peter
