From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: ACPI: Fix <acpi/video.h> when CONFIG_ACPI_VIDEO=n
Date: Fri, 19 Nov 2010 17:14:20 -0800
Message-ID: <20101120011420.GA2862@ericsson.com>
References: <20101119170200.2db4ab81@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:51904 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894Ab0KTBQ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Nov 2010 20:16:28 -0500
Content-Disposition: inline
In-Reply-To: <20101119170200.2db4ab81@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Fri, Nov 19, 2010 at 04:02:00PM -0000, Jean Delvare wrote:
> Building the kernel (2.6.37-rc2-git5) with CONFIG_ACPI_VIDEO=n fails
> for me because of these errors:
> 
> include/acpi/video.h:22:11: warning: "struct acpi_device" declared inside parameter list
> include/acpi/video.h:22:11: warning: its scope is only this definition or declaration, which is probably not what you want
> include/acpi/video.h: In function "acpi_video_get_edid":
> include/acpi/video.h:24:10: error: "ENODEV" undeclared (first use in this function)
> include/acpi/video.h:24:10: note: each undeclared identifier is reported only once for each function it appears in
> 
> Adding the missing include and structure declaration fixes it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Yes, it would be great if someone would apply one of the patches.
Build fails for me with CONFIG_PM=n.

Guenter
