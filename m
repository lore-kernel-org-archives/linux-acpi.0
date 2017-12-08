From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: Backporting patches that fix TBT at bootup
Date: Fri, 8 Dec 2017 09:10:47 +0200
Message-ID: <20171208071047.GY22431@lahna.fi.intel.com>
References: <ad18c029a5ca4a3cbcd4a2dfef50fed5@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47030 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751109AbdLHHKv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Dec 2017 02:10:51 -0500
Content-Disposition: inline
In-Reply-To: <ad18c029a5ca4a3cbcd4a2dfef50fed5@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: linux-acpi@vger.kernel.org

On Thu, Dec 07, 2017 at 11:20:40PM +0000, Mario.Limonciello@dell.com wrote:
>    Hi,
> 
> 
>    During kernel 4.14 some issues were fixed for Thunderbolt enumeration
>    at bootup.
> 
>    They were referenced in an issue
> 
>    ([1]https://github.com/01org/thunderbolt-software-user-space/issues/24#
>    issuecomment-328011428)
> 
>    There are 3 patches that Mika mentioned would be evaluated to be
>    backported back to 4.13.
> 
> 
>    As 4.14 has come and gone now, I wanted to see if there was any other
>    thoughts about
> 
>    bringing those back to stable now on 4.13 (or did they come back and I
>    just didn’t know?)
> 
> 
>    ecc1165b8b74 ACPICA: Dispatch active GPEs at init time
> 
>    1312b7e0caca ACPICA: Make it possible to enable runtime GPEs earlier
> 
>    eb7f43c4adb4 ACPI / scan: Enable GPEs before scanning the namespace

They are already in stable starting from v4.13.13.
