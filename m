From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: acpica: Fix double-free in acpi_ns_repair_CID()
Date: Sat, 30 Sep 2017 06:50:48 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF72394@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16266 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdI3Guw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 Sep 2017 02:50:52 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, Daniel Drake <drake@endlessm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

Are you still monitoring this issue?
https://patchwork.kernel.org/patch/9555103/
I have a fix related, are you still available for testing this issue?
I just created a kernel Bugzilla entry for us to communicate:
https://bugzilla.kernel.org/show_bug.cgi?id=197085

Thanks
Lv

