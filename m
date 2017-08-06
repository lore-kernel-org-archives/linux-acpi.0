From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/5] ACPI: Introduce DMA ranges parsing
Date: Sun, 6 Aug 2017 13:12:55 +0800
Message-ID: <201708061311.4aEB8P1Q%fengguang.wu@intel.com>
References: <20170803123239.11359-4-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbdHFFNN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Aug 2017 01:13:13 -0400
Content-Disposition: inline
In-Reply-To: <20170803123239.11359-4-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Robin Murphy <robin.murphy@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Robert Moore <robert.moore@intel.com>, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Nate Watterson <nwatters@codeaurora.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lorenzo,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.13-rc3 next-20170804]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lorenzo-Pieralisi/ACPICA-resource_mgr-Allow-_DMA-method-in-walk-resources/20170804-185152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

Note: the linux-review/Lorenzo-Pieralisi/ACPICA-resource_mgr-Allow-_DMA-method-in-walk-resources/20170804-185152 HEAD 37e91dddbbeb771d4df0001f716607f1dd8719f8 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/acpi/scan.c: In function 'acpi_dma_configure':
>> drivers/acpi/scan.c:1451:2: error: implicit declaration of function 'iort_dma_setup' [-Werror=implicit-function-declaration]
     iort_dma_setup(dev, &dma_addr, &size);
     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/iort_dma_setup +1451 drivers/acpi/scan.c

  1440	
  1441	/**
  1442	 * acpi_dma_configure - Set-up DMA configuration for the device.
  1443	 * @dev: The pointer to the device
  1444	 * @attr: device dma attributes
  1445	 */
  1446	int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
  1447	{
  1448		const struct iommu_ops *iommu;
  1449		u64 dma_addr = 0, size = 0;
  1450	
> 1451		iort_dma_setup(dev, &dma_addr, &size);
  1452	
  1453		iommu = iort_iommu_configure(dev);
  1454		if (IS_ERR(iommu) && PTR_ERR(iommu) == -EPROBE_DEFER)
  1455			return -EPROBE_DEFER;
  1456	
  1457		arch_setup_dma_ops(dev, dma_addr, size,
  1458					iommu, attr == DEV_DMA_COHERENT);
  1459	
  1460		return 0;
  1461	}
  1462	EXPORT_SYMBOL_GPL(acpi_dma_configure);
  1463	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zYM0uCDKw75PZbzx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
LRNyOBqf9NtwMZ5vNIzeAOuyMoJ7VgAA

--zYM0uCDKw75PZbzx--
