From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Tue, 15 May 2012 22:31:38 +0800
Message-ID: <4FB268CA.9060304@intel.com>
References: <20120511202113.GH18754@xanatos> <Pine.LNX.4.44L0.1205111629150.1865-100000@iolanthe.rowland.org> <20120511235922.GJ18754@xanatos> <20120512001722.GA28011@kroah.com> <20120514232123.GK18754@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38188 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758106Ab2EOObt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 May 2012 10:31:49 -0400
In-Reply-To: <20120514232123.GK18754@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Dan Williams <dcbw@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

Since alan suggested we should start simpler version(power
down port that have no devices attached) firstly. And we
also should provide general power off mechanism.

I have a proposal.
first:  add portx_power_control sys file.
      echo "auto" => portx_power_control
                     check whether there is a device. if no, send the clear
                     USB_PORT_FEAT_POWER request. (since general way
                     to control port power is via set or clear PORT_POWER)

     echo "on" =>  portx_power_control
                     send the set  USB_PORT_FEAT_POWER request.

second:
In the  xhci driver, add acpi hook in the xhci_hub_control()
                 where USB_PORT_FEAT_POWER request is dealt with.
