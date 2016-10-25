From: Imre Deak <imre.deak@intel.com>
Subject: Re: 4.9-rc1: [TMP_] ACPI namespace lookup failure, AE_ALREADY_EXISTS
Date: Tue, 25 Oct 2016 15:48:27 +0300
Message-ID: <1477399707.11683.14.camel@intel.com>
References: <1476913001.7633.13.camel@intel.com>
         <1AE640813FDE7649BE1B193DEA596E886A256F5B@SHSMSX101.ccr.corp.intel.com>
         <1477216090.7258.9.camel@intel.com>
          <1AE640813FDE7649BE1B193DEA596E886A259633@SHSMSX101.ccr.corp.intel.com>
Reply-To: imre.deak@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:48391 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932289AbcJYMsa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Oct 2016 08:48:30 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A259633@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On ti, 2016-10-25 at 04:14 +0300, Zheng, Lv wrote:
> Hi, Imre
> 
> I think this is the root cause fix:
> https://github.com/zetalog/linux/commit/108009d0
> Which seems to be an old trap triggered by the good fix.
> 
> Could you give the fix commit a try?
> It’s better to use this branch, where more improvements are included:
> git clone linux-acpica https://github.com/zetalog/linux
> git branch acpica-lock linux-acpica/acpica-lock
> git checkout acpica-lock

Yes, with the above branch I couldn't reproduce the problem during
suspend/resume while reverting 108009d0 made the problem reappear.

--Imre
