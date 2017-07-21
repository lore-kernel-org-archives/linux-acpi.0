From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 20 Jul 2017 21:00:20 -0300
Message-ID: <20170720210020.0996b7e2@vento.lan>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
        <20170717215912.26070-4-toshi.kani@hpe.com>
        <20170718060007.GB8736@nazgul.tnic>
        <1500407379.2042.21.camel@hpe.com>
        <20170718181545.32bd9181@vento.lan>
        <20170719055838.GF26030@nazgul.tnic>
        <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
        <20170719130245.7fc97352@vento.lan>
        <20170720211553.itdbvjacjnliago5@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39714
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964851AbdGUAA3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 20:00:29 -0400
In-Reply-To: <20170720211553.itdbvjacjnliago5@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Aristeu Rozanski <aris@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Em Thu, 20 Jul 2017 14:15:54 -0700
"Luck, Tony" <tony.luck@intel.com> escreveu:

> On Wed, Jul 19, 2017 at 01:02:45PM -0300, Mauro Carvalho Chehab wrote:
> > Tony/Aris,
> > 
> > I got yesterday an HP ML350 G9, equipped with Sandy Bridge EP CPUs (E5-2640v4).
> > I'm running Kernel 4.11 there.
> > 
> > AFAIKT, Sandy Bridge EP has 4 channels per memory controller, right?
> > That would match the number of memory slots on this machine (24 slots).
> > 
> > Yet, EDAC is only identifying 3 channels per CPU:
> > 
> >  $  ras-mc-ctl --layout
> >        +-----------------------------------------------------------------------+
> >        |                mc0                |                mc1                |
> >        | channel0  | channel1  | channel2  | channel0  | channel1  | channel2  |
> > -------+-----------------------------------------------------------------------+
> > slot2: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
> > slot1: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
> > slot0: |  16384 MB  |     0 MB  |  16384 MB  |  16384 MB  |     0 MB  |  16384 MB  |
> > -------+---------------------------------------------------------------------------+
> > 
> > So, it seems that either the BIOS is hidden the other channel or
> > there's something wrong with SandyBridge EP support at sb_edac driver.  
> 
> Does lspci show all four of these devices?
> 
> include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD0    0x3caa  /* 15.2 */
> include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD1    0x3cab  /* 15.3 */
> include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD2    0x3cac  /* 15.4 */
> include/linux/pci_ids.h:#define PCI_DEVICE_ID_INTEL_SBRIDGE_IMC_TAD3    0x3cad  /* 15.5 */
> 
> There should be two of each (one on bus 7f, the other on bus ff).

It is getting all 4 TAD devices (Broadwell). This is what I'm getting
(from the PCI IDs that it is supposed to be on Broadwell):

00:05.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management [8086:6f28] (rev 01)
7f:0f.4 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Caching Agent [8086:6ffc] (rev 01)
7f:0f.5 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Caching Agent [8086:6ffd] (rev 01)
7f:12.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Home Agent 0 [8086:6fa0] (rev 01)
7f:13.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS [8086:6fa8] (rev 01)
7f:13.1 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS [8086:6f71] (rev 01)
7f:13.2 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6faa] (rev 01)
7f:13.3 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6fab] (rev 01)
7f:13.4 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6fac] (rev 01)
7f:13.5 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6fad] (rev 01)
7f:13.7 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D DDRIO Global Broadcast [8086:6faf] (rev 01)
7f:16.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Target Address/Thermal/RAS [8086:6f68] (rev 01)
80:05.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Map/VTd_Misc/System Management [8086:6f28] (rev 01)
ff:0f.4 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Caching Agent [8086:6ffc] (rev 01)
ff:0f.5 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Caching Agent [8086:6ffd] (rev 01)
ff:12.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Home Agent 0 [8086:6fa0] (rev 01)
ff:13.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS [8086:6fa8] (rev 01)
ff:13.1 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Target Address/Thermal/RAS [8086:6f71] (rev 01)
ff:13.2 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6faa] (rev 01)
ff:13.3 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6fab] (rev 01)
ff:13.4 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6fac] (rev 01)
ff:13.5 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Memory Controller 0 - Channel Target Address Decoder [8086:6fad] (rev 01)
ff:13.7 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D DDRIO Global Broadcast [8086:6faf] (rev 01)
ff:16.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D Target Address/Thermal/RAS [8086:6f68] (rev 01)


Thanks,
Mauro
