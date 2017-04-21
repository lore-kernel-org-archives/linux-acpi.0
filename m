From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi, nfit: fix the memory error check in nfit_handle_mce
Date: Fri, 21 Apr 2017 10:21:59 +0800
Message-ID: <201704211005.QjuD0bvn%fengguang.wu@intel.com>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170420221818.23522-1-vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Vishal,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.11-rc7 next-20170420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vishal-Verma/acpi-nfit-fix-the-memory-error-check-in-nfit_handle_mce/20170421-084359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-x005-201716 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/acpi/nfit/mce.c: In function 'nfit_handle_mce':
>> drivers/acpi/nfit/mce.c:29:30: warning: comparison of constant '128ul' with boolean expression is always false [-Wbool-compare]
     if (!(mce->status & 0xef80) == BIT(7))
                                 ^~
>> drivers/acpi/nfit/mce.c:29:30: warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses]

vim +/128ul +29 drivers/acpi/nfit/mce.c

    13	 * General Public License for more details.
    14	 */
    15	#include <linux/notifier.h>
    16	#include <linux/acpi.h>
    17	#include <linux/nd.h>
    18	#include <asm/mce.h>
    19	#include "nfit.h"
    20	
    21	static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
    22				void *data)
    23	{
    24		struct mce *mce = (struct mce *)data;
    25		struct acpi_nfit_desc *acpi_desc;
    26		struct nfit_spa *nfit_spa;
    27	
    28		/* We only care about memory errors */
  > 29		if (!(mce->status & 0xef80) == BIT(7))
    30			return NOTIFY_DONE;
    31	
    32		/*
    33		 * mce->addr contains the physical addr accessed that caused the
    34		 * machine check. We need to walk through the list of NFITs, and see
    35		 * if any of them matches that address, and only then start a scrub.
    36		 */
    37		mutex_lock(&acpi_desc_lock);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
