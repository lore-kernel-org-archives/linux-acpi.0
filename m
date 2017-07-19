From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Wed, 19 Jul 2017 20:06:20 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F6130DC65@ORSMSX114.amr.corp.intel.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
        <20170717215912.26070-4-toshi.kani@hpe.com>
        <20170718060007.GB8736@nazgul.tnic>     <1500407379.2042.21.camel@hpe.com>
        <20170718181545.32bd9181@vento.lan>     <20170719055838.GF26030@nazgul.tnic>
        <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
 <20170719130245.7fc97352@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:33240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754150AbdGSUGV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 16:06:21 -0400
In-Reply-To: <20170719130245.7fc97352@vento.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Aristeu Rozanski <aris@redhat.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

> So, it seems that either the BIOS is hidden the other channel or
> there's something wrong with SandyBridge EP support at sb_edac driver.

Can you send me the out of "lspci -xxxx" (run as root)?

-Tony
