From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Fri, 21 Jul 2017 16:53:24 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F61310CD3@ORSMSX114.amr.corp.intel.com>
References: <20170717215912.26070-1-toshi.kani@hpe.com>
        <20170717215912.26070-4-toshi.kani@hpe.com>
        <20170718060007.GB8736@nazgul.tnic>     <1500407379.2042.21.camel@hpe.com>
        <20170718181545.32bd9181@vento.lan>     <20170719055838.GF26030@nazgul.tnic>
        <3908561D78D1C84285E8C5FCA982C28F6130D126@ORSMSX114.amr.corp.intel.com>
        <20170719130245.7fc97352@vento.lan>
        <20170720211553.itdbvjacjnliago5@intel.com>
 <20170720210020.0996b7e2@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:58390 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752178AbdGUQx0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 12:53:26 -0400
In-Reply-To: <20170720210020.0996b7e2@vento.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Aristeu Rozanski <aris@redhat.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>

Hmmm so the BIOS isn't hiding any devices.

Can you read the MTR registers from each of those target address decoders?

for i in a b d c
do
	for j in 0 4 8
	do
		setpci -d 8086:6fa$i 0x8$j.L
	done
done

bit 14 is the IS_DIMM_PRESENT one.  So you should see values like 001c5050 for populated slots. I see 000f000c for empty slots.

-Tony

[If you send me "lspci -xxxx" output I can check why the driver isn't reporting the 4th channel]
