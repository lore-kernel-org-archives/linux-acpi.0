From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ACPI: APD: Add AMD misc clock handler support
Date: Mon, 30 Apr 2018 15:10:08 +0530
Message-ID: <096a504f-1d86-afc8-c6db-6ee1073a755c@amd.com>
References: <1525072206-17956-1-git-send-email-akshu.agrawal@amd.com>
 <201804301633.FxGiqS4Z%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201804301633.FxGiqS4Z%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, djkurtz@chromium.org, Alexander.Deucher@amd.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org



On 4/30/2018 2:23 PM, kbuild test robot wrote:
> Hi Akshu,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.17-rc3 next-20180426]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Akshu-Agrawal/ACPI-APD-Add-AMD-misc-clock-handler-support/20180430-152810
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: x86_64-acpi-redef (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers//acpi/acpi_apd.c:14:10: fatal error: linux/platform_data/clk-st.h: No such file or directory
>      #include <linux/platform_data/clk-st.h>
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
> 

This patch is dependent on https://patchwork.kernel.org/patch/10370955/
The above patch adds the required include file.

Thanks,
Akshu
> vim +14 drivers//acpi/acpi_apd.c
> 
>    > 14	#include <linux/platform_data/clk-st.h>
>      15	#include <linux/platform_device.h>
>      16	#include <linux/pm_domain.h>
>      17	#include <linux/clkdev.h>
>      18	#include <linux/acpi.h>
>      19	#include <linux/err.h>
>      20	#include <linux/pm.h>
>      21	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
