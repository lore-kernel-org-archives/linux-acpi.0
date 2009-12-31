From: Len Brown <lenb@kernel.org>
Subject: git-apply --whitespace (Re: [PATCH 2/5] ACPI, APEI,
 APEI supporting infrastructure)
Date: Wed, 30 Dec 2009 20:14:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912302006520.17125@localhost.localdomain>
References: <1261980744-4450-1-git-send-email-ying.huang@intel.com>
 <1261980744-4450-2-git-send-email-ying.huang@intel.com>
 <1261980744-4450-3-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:48930 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbZLaBPA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 20:15:00 -0500
In-reply-to: <1261980744-4450-3-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: ak@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> new file mode 100644
> index 0000000..4085bdd
> --- /dev/null
> +++ b/drivers/acpi/apei/Kconfig
> @@ -0,0 +1,9 @@
> +config ACPI_APEI
> +	tristate "ACPI Platform Error Interface (APEI)"
> +	depends on X86
> +	help
> +	  APEI allows to report errors (for example from the chipset)
> +	  to the operating system. This improves NMI handling
> +	  especially. In addition it supports error serialization and
> +	  error injection.
> +
> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile

FYI, git apply considers a trailing blank line,
such as the one at the end of the hunk above,
to be a "whitespace error".

I use --whitespace=strip, which causes git to delete it
upon checkin.  However, that causes the 4th patch in
this series, which appents to this file, to not apply.

Please don't send patches with trailing blank lines.
In this case, the blank should come as a "preceeding"
blank line in the 4th patch...

thanks,
-Len Brown, Intel Open Source Technology Center



