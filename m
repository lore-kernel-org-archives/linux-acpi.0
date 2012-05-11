From: Peter Stuge <peter@stuge.se>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
	for device fixed on the motherboard
Date: Fri, 11 May 2012 06:13:09 +0200
Message-ID: <20120511041309.22096.qmail@stuge.se>
References: <Pine.LNX.4.44L0.1205101136470.1831-100000@iolanthe.rowland.org> <1336677578.6463.5.camel@dcbw.foobar.com> <20120510211156.GA18754@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foo.stuge.se ([212.116.89.98]:35147 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751130Ab2EKETw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 00:19:52 -0400
Content-Disposition: inline
In-Reply-To: <20120510211156.GA18754@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Dan Williams <dcbw@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

Sarah Sharp wrote:
> Maybe we need an "off" setting that forces the port off?

FWIW this would be very welcome in libusb, to do a hard reset of
bus-powered devices.

It can be attempted via SET_FEATURE(PORT_POWER) to the hub, but a
"real" API would be nice.


//Peter
