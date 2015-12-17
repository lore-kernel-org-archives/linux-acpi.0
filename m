From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 02/10] irqchip / GICv3: Add ACPI support for GICv3+
 initialization
Date: Thu, 17 Dec 2015 16:12:32 +0100
Message-ID: <5672D0E0.3020209@semihalf.com>
References: <201512172109.NUSKIrEK%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35211 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934585AbbLQPOZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2015 10:14:25 -0500
Received: by mail-wm0-f52.google.com with SMTP id l126so25854077wml.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2015 07:14:25 -0800 (PST)
In-Reply-To: <201512172109.NUSKIrEK%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com

On 17.12.2015 14:44, kbuild test robot wrote:
> Hi Tomasz,
>
> [auto build test ERROR on v4.4-rc4]
> [also build test ERROR on next-20151217]
> [cannot apply to tip/irq/core v4.4-rc5]
>
> url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Introduce-ACPI-world-to-GICv3-ITS-irqchip/20151217-195910
> config: arm-allyesconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>     drivers/irqchip/irq-gic-v3.c: In function 'gic_irq_domain_translate':
>>> drivers/irqchip/irq-gic-v3.c:768:2: error: implicit declaration of function 'is_fwnode_irqchip' [-Werror=implicit-function-declaration]
>       if (is_fwnode_irqchip(fwspec->fwnode)) {
>       ^
>     cc1: some warnings being treated as errors
>
> vim +/is_fwnode_irqchip +768 drivers/irqchip/irq-gic-v3.c
>
>     762			}
>     763	
>     764			*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
>     765			return 0;
>     766		}
>     767	
>   > 768		if (is_fwnode_irqchip(fwspec->fwnode)) {
>     769			if(fwspec->param_count != 2)
>     770				return -EINVAL;
>     771	
>

It is because I missed irqdomain.h header for irq-gic-v3.c and 
irq-gic-v3-its.c files. Fixed in version 3.

Tomasz
