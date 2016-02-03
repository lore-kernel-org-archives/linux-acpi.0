From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: platform: Do not detach from PM domains on shutdown
Date: Wed, 3 Feb 2016 13:05:56 -0500
Message-ID: <56B24184.10006@codeaurora.org>
References: <56B0BF7C.6080607@codeaurora.org>
 <CAJZ5v0jkYhdNqY7xoGzwAsk0o-YO0PX6REp0OGc9NgBxgCLDDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37862 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933630AbcBCSF7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2016 13:05:59 -0500
In-Reply-To: <CAJZ5v0jkYhdNqY7xoGzwAsk0o-YO0PX6REp0OGc9NgBxgCLDDA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, fabio.estevam@nxp.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Rafael,

On 2/2/2016 7:53 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> On Tue, Feb 2, 2016 at 3:38 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Hi Rafael,Ulf;
>>
>> Following up to these patches on linux 4.5-rc1,
>>
>> commit 2d30bb0b3889adf09b342722b2ce596c0763bc93
>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Date:   Tue Jan 12 00:12:19 2016 +0100
>>
>>     platform: Do not detach from PM domains on shutdown
>>
>>     Shutdown is carried out when the driver is still bound to the
>>     device, so it is incorrect to detach it from a PM domain (if any)
>>     at this point.
>>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>     Reported-and-tested-by: Fabio Estevam <fabio.estevam@nxp.com>
>>     Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>>
>>
>> From Tomeu Vizoso <>
>> Subject [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
>> Date Tue, 27 Oct 2015 15:38:49 +0100
>>
>> I'm seeing a problem with HIDMA driver during
>> unbind. I recognize that you fixed the issue for shutdown but the issue seems to be still there for
>> the remove case.
>>
>> I'm wondering if you need to remove this too.
> 
> This patch may help here: https://patchwork.kernel.org/patch/8170821/
> 
> Can you try it please?
> 
> Thanks,
> Rafael
> 

Your patch worked. You can add this if you have not merged already.

Tested-by: okaya@codeaurora.org

enablement: booted suscessfully
Starting logging: OK
Starting mdev...
Starting irqbalance: OK
Initializing random number generator... [    9.806670] random: dd urandom read with
done.
Starting system message bus: done
Starting network...
Starting dropbear sshd: OK
Starting telnetd: OK
Starting libvirtd: OK

/_#_echo_vfio-platform |tee -a /sys/bus/platform/devices/QCOM8061:00/driver_override
vfio-platform
/ # echo QCOM8061:00 | tee -a  /sys/bus/platform/devices/QCOM8061:00/driver/unbind
QCOM8061:00
[  148.846481] hidma QCOM8061:00: HI-DMA engine removed


/# echo QCOM8061:00 |tee -a /sys/bus/platform/drivers_probe
QCOM8061:00

/#
/#



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
