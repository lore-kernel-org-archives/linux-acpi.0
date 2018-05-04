From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
Date: Sat, 5 May 2018 04:16:06 +0800
Message-ID: <201805050356.n04IuGDl%fengguang.wu@intel.com>
References: <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525422930-27826-2-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Akshu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Akshu-Agrawal/clk-x86-Add-ST-oscout-platform-clock/20180504-220653
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/acpi/acpi_apd.c:114:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
