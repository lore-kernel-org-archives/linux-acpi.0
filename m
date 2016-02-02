From: Sinan Kaya <okaya@codeaurora.org>
Subject: platform: Do not detach from PM domains on shutdown
Date: Tue, 2 Feb 2016 09:38:52 -0500
Message-ID: <56B0BF7C.6080607@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53180 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbcBBOi4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2016 09:38:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ulf.hansson@linaro.org, fabio.estevam@nxp.com, rafael.j.wysocki@intel.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Rafael,Ulf;

Following up to these patches on linux 4.5-rc1, 

commit 2d30bb0b3889adf09b342722b2ce596c0763bc93
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue Jan 12 00:12:19 2016 +0100

    platform: Do not detach from PM domains on shutdown

    Shutdown is carried out when the driver is still bound to the
    device, so it is incorrect to detach it from a PM domain (if any)
    at this point.

    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Reported-and-tested-by: Fabio Estevam <fabio.estevam@nxp.com>
    Acked-by: Ulf Hansson <ulf.hansson@linaro.org>



>From Tomeu Vizoso <> 
Subject [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain 
Date Tue, 27 Oct 2015 15:38:49 +0100 

I'm seeing a problem with HIDMA driver during
unbind. I recognize that you fixed the issue for shutdown but the issue seems to be still there for
the remove case.

I'm wondering if you need to remove this too.

static int platform_drv_remove(struct device *_dev)
{
struct platform_driver *drv = to_platform_driver(_dev->driver);
struct platform_device *dev = to_platform_device(_dev);
int ret = 0;

if (drv->remove)
ret = drv->remove(dev);
dev_pm_domain_detach(_dev, true); <-----

return ret;
}

The HIDMA driver can be found here. 
https://lkml.org/lkml/2016/1/29/685


/ # echo vfio-platform | tee -a /sys/bus/platform/devices/QCOM8061:00/driver_override
vfio-platform
/ # echo QCOM8061:00 | tee -a  /sys/bus/platform/devices/QCOM8061:00/driver/unbind
QCOM8061:00

hidma_QCOM8061:00:_HI-DMA_engine_removed
hidma QCOM8061:00: after pm_runtime_put_sync_suspend
PM domains can only be changed for unbound devices
------------[ cut here ]------------
WARNING: at drivers/base/power/common.c:150
Modules linked in:

CPU: 0 PID: 1392 Comm: tee Not tainted 4.5.0-rc1+ #46
Hardware name: Hawker RUMI4 (DT)
task: ffffffcbc5398c00 ti: ffffffcbc533c000 task.ti: ffffffcbc533c000
PC is at dev_pm_domain_set+0x54/0x60
LR is at dev_pm_domain_set+0x54/0x60
pc : [<ffffffc000466fe8>] lr : [<ffffffc000466fe8>] pstate: 80000145
sp : ffffffcbc533fc30
x29: ffffffcbc533fc30 x28: ffffffcbc533c000
x27: ffffffc0007fb000 x26: 0000000000000040
x25: ffffffcbc533fec8 x24: 0000000000000000
x23: 000000000000000c x22: ffffffffffffffed
x21: 0000000000000001 x20: ffffffcbc927e800
x19: ffffffcbc9187810 x18: 0000007fb7fce7d8
x17: 0000007fb7f45220 x16: ffffffc0001b21fc
x15: 003a20d71e000000 x14: 0000000000000000
x13: 00000003e8000000 x12: 0000000000000018
x11: 00000000000ee17e x10: 0000000000000840
x9 : ffffffcbc533c000 x8 : ffffffcbc53994a0
x7 : 0000000001eab436 x6 : 0000000000000000
x5 : 0000000000000000 x4 : ffffffcbc53994a8
x3 : ffffffcbc52063cc x2 : ffffffcbc9b14828
x1 : 0000000000000000 x0 : 0000000000000032

---[ end trace fbb22db05098c674 ]---
Call trace:
Exception stack(0xffffffcbc533fa70 to 0xffffffcbc533fb90)
fa60: ffffffcbc9187810 ffffffcbc927e800
fa80: ffffffcbc533fc30 ffffffc000466fe8 ffffffcbc533faa0 ffffffc0000f36f8
faa0: ffffffcbc533fb50 ffffffc0000f3a60 ffffffc0000f3a28 ffffffcbc927e800
fac0: 0000000000000001 ffffffffffffffed 000000000000000c 0000000000000000
fae0: ffffffcbc533fec8 0000000000000040 ffffffc0007fb000 ffffffcbc533c000
fb00: ffffffc000d79fc8 0030303a31363038 0000000000000032 0000000000000000
fb20: ffffffcbc9b14828 ffffffcbc52063cc ffffffcbc53994a8 0000000000000000
fb40: 0000000000000000 0000000001eab436 ffffffcbc53994a0 ffffffcbc533c000
fb60: 0000000000000840 00000000000ee17e 0000000000000018 00000003e8000000
fb80: 0000000000000000 003a20d71e000000
[<ffffffc000466fe8>] dev_pm_domain_set+0x54/0x60
[<ffffffc0003a84c8>] acpi_dev_pm_detach+0x64/0xb4
[<ffffffc000466e3c>] dev_pm_domain_detach+0x20/0x28
[<ffffffc000460100>] platform_drv_remove+0x34/0x64
[<ffffffc00045e814>] __device_release_driver+0x7c/0xfc
[<ffffffc00045e8b8>] device_release_driver+0x24/0x38
[<ffffffc00045ce14>] unbind_store+0xb8/0xd0
[<ffffffc00045c468>] drv_attr_store+0x20/0x30
[<ffffffc00021eb74>] sysfs_kf_write+0x44/0x4c
[<ffffffc00021dfd4>] kernfs_fop_write+0xb8/0x17c
[<ffffffc0001b0700>] __vfs_write+0x2c/0xe0
[<ffffffc0001b1568>] vfs_write+0x90/0x190
[<ffffffc0001b22e0>] SyS_write+0x44/0xa0
[<ffffffc000085d30>] el0_svc_naked+0x24/0x28




-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
