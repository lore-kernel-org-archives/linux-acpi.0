From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH v6 6/8] usb: expose usb port's pm qos flags to user space
Date: Tue, 22 Jan 2013 21:50:04 +0800
Message-ID: <50FE990C.8090405@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com> <1358777887-2656-7-git-send-email-tianyu.lan@intel.com> <20130121213126.GC20083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45237 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405Ab3AVNuI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2013 08:50:08 -0500
In-Reply-To: <20130121213126.GC20083@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On 2013/1/22 5:31, Greg KH wrote:
> On Mon, Jan 21, 2013 at 10:18:05PM +0800, Lan Tianyu wrote:
>> This patch is to expose usb port's pm qos flags(pm_qos_no_power_off,
>> pm_qos_remote_wakeup) to user space. User can set pm_qos_no_power_off
>> flag to prohibit the port from being powered off.
>
> How are they now seen by userspace?  Should a new Documentation/ABI
> entry be created somewhere describing this?
There are already some descriptors in the 
Documentation/ABI/testing/sysfs-devices-power(line 208, lin223).
>
> thanks,
>
> greg k-h
>


-- 
Best Regards
Tianyu Lan
linux kernel enabling team
