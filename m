From: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: Cannot access force_remove sysfs
Date: Wed, 28 Jun 2017 16:41:25 -0400
Message-ID: <0d5b7fb4-4079-6c42-333a-b9cbe575575c@gmail.com>
References: <4034c534-ea67-03ca-f1ee-bc55e0ce487d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34836 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbdF1Ul2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jun 2017 16:41:28 -0400
Received: by mail-qt0-f193.google.com with SMTP id w12so8940032qta.2
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jun 2017 13:41:28 -0700 (PDT)
In-Reply-To: <4034c534-ea67-03ca-f1ee-bc55e0ce487d@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>, rafael.j.wysocki@intel.com

Please ignore the e-mail.
I found a way to hot remove ACPI0004 device. If I found anything related to force_remove sysfs,
I'll let you know.

Thanks,
Yasuaki Ishimatsu

On 06/28/2017 02:16 PM, YASUAKI ISHIMATSU wrote:
> Our sever supports system board (defined as ACPI0004) hotplug. And to hot-remove the device safely,
> we control force_remove sysfs. But due to the following commit, ACPI0004 hotplug does not work.
> 
> commit ffc10d82ff5df7087a9b737de55a69ac4f89bf56
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Mon Apr 3 09:40:23 2017 +0200
> 
>     ACPI / scan: Drop support for force_remove
> 
> ACPI0004 is defined as module device in ACPI specification. So we don't know what devices mounts on ACPI0004.
> So to hot-remove ACPI0004 safely, we implemented that ACPI004 can be hot removed only when acpi_force_hot_remove
> is set to 1 via force_remove sysfs. And if acpi_force_hot_remove is set to 0, kernel just notifies REMOVE request
> of ACPI0004 to udev so that user can offline the devices on ACPI0004 by udev rule.
> 
> In our udev script, we hot-removes ACPI0004 safely as follows:
> 
>   1. udev catches REMOVE request of a ACPI0004 and run our script
>   2. Our script offline all devices on the ACPI0004
>   3. Our script write 1 to force_remove sysfs so that ACPI0004 can be hot-removed.
>   4. Our script write 1 to eject sysfs of the ACPI0004 to hot remove ACPI0004
>   5. Our script write 0 to force_remove sysfs so that the ACPI0004 cannot be hot-removed.
> 
> But due to the commit ffc10d82ff5d, there is no way to hot remove ACPI0004.
> So please revert the commit.
> 
> Thanks,
> Yasuaki Ishimatsu
> 
