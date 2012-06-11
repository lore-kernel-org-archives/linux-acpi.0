From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] usb : Add sysfs files to control usb port's power
Date: Mon, 11 Jun 2012 10:12:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206111011490.1607-100000@iolanthe.rowland.org>
References: <1339381474-17413-4-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50469 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754155Ab2FKOM2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jun 2012 10:12:28 -0400
In-Reply-To: <1339381474-17413-4-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, sarah.a.sharp@linux.intel.com, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 11 Jun 2012, Lan Tianyu wrote:

> This patch is to add two sys files for each usb hub ports to control port's power.
> Control port's power through setting or clearing PORT_POWER feature.
> 
> The new sys files is under the usb hub interface sysfs portx directory.
> ls /sys/bus/usb/devices/1-0:1.0
> bAlternateSetting  bInterfaceClass  bInterfaceNumber  bInterfaceProtocol
> bInterfaceSubClass  bNumEndpoints  driver  ep_81  modalias  power
> subsystem  supports_autosuspend  uevent port1 port2 port3 port4
> 
> ls /sys/bus/usb/devices/1-0:1.0/port1
> control state
> 
> control has two options. "on" and "off"
> "on" - port power must be on.
> "off" - port power must be off.
> 
> state reports usb port's power state
> "on" - power on
> "off" - power off
> "error" - can't get power state
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

