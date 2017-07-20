From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 14:15:54 -0700
Message-ID: <20170720211553.itdbvjacjnliago5@intel.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
 <20170717215912.26070-4-toshi.kani@hpe.com>
 <20170718060007.GB8736@nazgul.tnic>
 <1500407379.2042.21.camel@hpe.com>
 <20170718181545.32bd9181@vento.lan>
 <20170719055838.GF26030@nazgul.tnic>
 <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
 <20170719130245.7fc97352@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933285AbdGTVQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Jul 2017 17:16:03 -0400
Content-Disposition: inline
In-Reply-To: <20170719130245.7fc97352@vento.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Aristeu Rozanski <aris@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

On Wed, Jul 19, 2017 at 01:02:45PM -0300, Mauro Carvalho Chehab wrote:
> Tony/Aris,
> 
> I got yesterday an HP ML350 G9, equipped with Sandy Bridge EP CPUs (E5-2640v4).
> I'm running Kernel 4.11 there.
> 
> AFAIKT, Sandy Bridge EP has 4 channels per memory controller, right?
> That would match the number of memory slots on this machine (24 slots).
> 
> Yet, EDAC is only identifying 3 channels per CPU:
> 
>  $  ras-mc-ctl --layout
>        +-----------------------------------------------------------------------+
>        |                mc0                |                mc1                |
>        | channel0  | channel1  | channel2  | channel0  | channel1  | channel2  |
> -------+-----------------------------------------------------------------------+
> slot2: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
> slot1: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
> slot0: |  16384 MB  |     0 MB  |  16384 MB  |  16384 MB  |     0 MB  |  16384 MB  |
> -------+---------------------------------------------------------------------------+
> 
> So, it seems that either the BIOS is hidden the other channel or
> there's something wrong with SandyBridge EP support at sb_edac driver.

Does lspci show all four of these devices?

include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD0    0x3caa  /* 15.2 */
include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD1    0x3cab  /* 15.3 */
include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD2    0x3cac  /* 15.4 */
include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD3    0x3cad  /* 15.5 */

There should be two of each (one on bus 7f, the other on bus ff).

-Tony
