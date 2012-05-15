From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Tue, 15 May 2012 13:00:47 -0700
Message-ID: <20120515200047.GA20507@xanatos>
References: <20120511202113.GH18754@xanatos>
 <Pine.LNX.4.44L0.1205111629150.1865-100000@iolanthe.rowland.org>
 <20120511235922.GJ18754@xanatos>
 <20120512001722.GA28011@kroah.com>
 <20120514232123.GK18754@xanatos>
 <4FB268CA.9060304@intel.com>
 <20120515151800.GC23916@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11111 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966685Ab2EOUBB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 May 2012 16:01:01 -0400
Content-Disposition: inline
In-Reply-To: <20120515151800.GC23916@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Dan Williams <dcbw@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Tue, May 15, 2012 at 08:18:00AM -0700, Greg KH wrote:
> On Tue, May 15, 2012 at 10:31:38PM +0800, Lan Tianyu wrote:
> > Since alan suggested we should start simpler version(power
> > down port that have no devices attached) firstly. And we
> > also should provide general power off mechanism.
> > 
> > I have a proposal.
> > first:  add portx_power_control sys file.
> >      echo "auto" => portx_power_control
> >                     check whether there is a device. if no, send the clear
> >                     USB_PORT_FEAT_POWER request. (since general way
> >                     to control port power is via set or clear PORT_POWER)
> > 
> >     echo "on" =>  portx_power_control
> >                     send the set  USB_PORT_FEAT_POWER request.
> 
> No "off"?

Yeah, we probably need an "off" for those libusb and ModemManager
developers who want to try and simulate a disconnect of a misbehaving
device.

Sarah Sharp
