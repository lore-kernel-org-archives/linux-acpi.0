From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] acpi: implement Generic Event Device
Date: Tue, 26 Jan 2016 07:21:56 +0800
Message-ID: <201601260728.zwrjxeIK%fengguang.wu@intel.com>
References: <1453757387-28154-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453757387-28154-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, rjw@rjwysocki.net, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Sinan,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/acpi-implement-Generic-Event-Device/20160126-053245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/acpi/evged.c:152:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
