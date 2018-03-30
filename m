From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] acpi: add find error record in BERT function
Date: Sat, 31 Mar 2018 07:36:54 +0800
Message-ID: <201803310742.jTzcHxid%fengguang.wu@intel.com>
References: <152236302712.35558.17322719540329044966.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152236302712.35558.17322719540329044966.stgit-Cxk7aZI4ujnJARH06PadV2t3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
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
To: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, Ying Huang <ying.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Dave,

I love your patch! Yet something to improve:

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.16-rc7 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dave-Jiang/Adding-support-to-parse-BERT-for-libnvdimm/20180331-065821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/kernel/setup.o: In function `bert_find_mem_error_record':
>> setup.c:(.text+0x3): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   arch/x86/kernel/i8259.o: In function `bert_find_mem_error_record':
   i8259.c:(.text+0x2c2): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   arch/x86/kernel/irqinit.o: In function `bert_find_mem_error_record':
   irqinit.c:(.text+0x0): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   arch/x86/kernel/bootflag.o: In function `bert_find_mem_error_record':
   bootflag.c:(.text+0x0): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   arch/x86/kernel/e820.o: In function `bert_find_mem_error_record':
   e820.c:(.text+0xb1): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   arch/x86/kernel/pci-dma.o: In function `bert_find_mem_error_record':
   pci-dma.c:(.text+0x0): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   arch/x86/kernel/rtc.o: In function `bert_find_mem_error_record':
   rtc.c:(.text+0x41): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   kernel/sysctl.o: In function `bert_find_mem_error_record':
   sysctl.c:(.text+0x0): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   drivers/base/platform.o: In function `bert_find_mem_error_record':
   platform.c:(.text+0x1e8): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   drivers/base/cpu.o: In function `bert_find_mem_error_record':
   cpu.c:(.text+0x1a1): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   drivers/base/property.o: In function `bert_find_mem_error_record':
   property.c:(.text+0x2aa): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   drivers/base/cacheinfo.o: In function `bert_find_mem_error_record':
   cacheinfo.c:(.text+0x2e5): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here
   drivers/base/dma-mapping.o: In function `bert_find_mem_error_record':
   dma-mapping.c:(.text+0x104): multiple definition of `bert_find_mem_error_record'
   init/main.o:main.c:(.text+0x19): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
