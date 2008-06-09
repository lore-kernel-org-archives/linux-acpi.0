From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Mon, 09 Jun 2008 13:56:21 +0900
Message-ID: <484CB7F5.7060606@gmail.com>
References: <20080528143857.GB5585@homac.suse.de> <4845886E.2010505@garzik.org> <20080603181346.GA5013@srcf.ucam.org> <484C8AE1.3010908@gmail.com> <20080609014818.GA32083@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:25557 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYFIE42 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 00:56:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1945952wfd.4
        for <linux-acpi@vger.kernel.org>; Sun, 08 Jun 2008 21:56:28 -0700 (PDT)
In-Reply-To: <20080609014818.GA32083@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Matthew Garrett wrote:
> On Mon, Jun 09, 2008 at 10:44:01AM +0900, Tejun Heo wrote:
> 
>> TF-based ATA controllers are very sensitive to how the registers are 
>> accessed and sometimes lock up the whole machine when they are not happy 
>> by indefinitely holding the PCI bus.  This could have been the case if 
>> IOs were in flight when the dock event occurred.  Were they?
> 
> I'd stopped hal, so I can't imagine that userspace was causing any to be 
> generated at that point.

Ah... okay.  Stupid me.  libata EH always resets a frozen port to 
un-freeze it even if it's unoccupied to listen for hotplug events.  So, 
if dock notifies device removal after the actual device is gone && the 
port is frozen as a result, libata EH will try to reset the port after 
the device is gone and in this case the controller locks up the whole 
machine for that.  If schedule_eh is used, libata EH just removes the 
device and does nothing else and the controller is happy.

This isn't too safe tho.  There can be other things which can trigger 
port reset.  ie. hotplug request from userland, in-flight IOs at the 
time of dock removal, etc...  Maybe we need to implement a flag to 
indicate that the port is dead and shouldn't be accessed in any way.

Thanks.

-- 
tejun
