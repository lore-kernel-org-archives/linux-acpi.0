From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 6/8] usb: expose usb port's pm qos flags to user space
Date: Mon, 21 Jan 2013 13:31:26 -0800
Message-ID: <20130121213126.GC20083@kroah.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
 <1358777887-2656-7-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36878 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3AUVba (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2013 16:31:30 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so3523555pbc.22
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jan 2013 13:31:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358777887-2656-7-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jan 21, 2013 at 10:18:05PM +0800, Lan Tianyu wrote:
> This patch is to expose usb port's pm qos flags(pm_qos_no_power_off,
> pm_qos_remote_wakeup) to user space. User can set pm_qos_no_power_off
> flag to prohibit the port from being powered off.

How are they now seen by userspace?  Should a new Documentation/ABI
entry be created somewhere describing this?

thanks,

greg k-h
