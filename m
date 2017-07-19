From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 13:02:45 -0300
Message-ID: <20170719130245.7fc97352@vento.lan>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
        <20170717215912.26070-4-toshi.kani@hpe.com>
        <20170718060007.GB8736@nazgul.tnic>
        <1500407379.2042.21.camel@hpe.com>
        <20170718181545.32bd9181@vento.lan>
        <20170719055838.GF26030@nazgul.tnic>
        <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34080
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932215AbdGSQCz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jul 2017 12:02:55 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>, Aristeu Rozanski <aris@redhat.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Tony/Aris,

I got yesterday an HP ML350 G9, equipped with Sandy Bridge EP CPUs (E5-2640v4).
I'm running Kernel 4.11 there.

AFAIKT, Sandy Bridge EP has 4 channels per memory controller, right?
That would match the number of memory slots on this machine (24 slots).

Yet, EDAC is only identifying 3 channels per CPU:

 $  ras-mc-ctl --layout
       +-----------------------------------------------------------------------+
       |                mc0                |                mc1                |
       | channel0  | channel1  | channel2  | channel0  | channel1  | channel2  |
-------+-----------------------------------------------------------------------+
slot2: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
slot1: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
slot0: |  16384 MB  |     0 MB  |  16384 MB  |  16384 MB  |     0 MB  |  16384 MB  |
-------+---------------------------------------------------------------------------+

So, it seems that either the BIOS is hidden the other channel or
there's something wrong with SandyBridge EP support at sb_edac driver.

Thanks,
Mauro
