From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: Re: [PATCH] acpi:  acpica:  dsutils: fixanoff-by-one index
Date: Wed, 7 Jun 2017 19:18:14 +0200
Message-ID: <20170607171814.zjvrikbjonp5n3gd@macchiaveli>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5BF38C@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36795 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdFGRSS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 13:18:18 -0400
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5BF38C@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: devel@acpica.org, afael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, lv.zheng@intel.com, lenb@kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 07, 2017 at 03:14:46PM +0000, Moore, Robert wrote:
> I believe that the rationale for this is that at that point in the code, it is *guaranteed* that there is at least one operand; therefore the -1 would always be valid.
>
> In the end, we just deleted that call to 
> acpi_db_display_argument_object.
> 
> I don't know if this change has made it into Linux yet.
> 
The latest rc actually produces the UBSAN splat in my previous message.
So I suppose, I have some buggy hardware/firmware.

Thanks,
Seraph
