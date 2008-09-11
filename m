From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC 2/5] devcore adds generic wakeup event handler
Date: Thu, 11 Sep 2008 12:48:52 -0600
Message-ID: <200809111248.52924.bjorn.helgaas@hp.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com> <20080911063823.083409592@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:41655 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYIKSsz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Sep 2008 14:48:55 -0400
In-Reply-To: <20080911063823.083409592@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, david-b@pacbell.net, dbrownell@users.sourceforge.net

On Thursday 11 September 2008 12:30:39 am Shaohua Li wrote:
> The default action to handle wakeup event. Currently just prints something,
> maybe we should call .resume(). The routine will be called in task context.
> ...

> +void device_receive_wakeup_event(struct device *dev)
> +{
> +	printk("Device %s invokes wakeup event\n", dev->bus_id);

Please use dev_printk(), e.g., dev_info() in this case.  Also
applies to patches 4 and 5.
