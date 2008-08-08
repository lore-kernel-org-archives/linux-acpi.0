From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] acpi: replace AE_BAD_ADDRESS exception code with AE_ERROR
Date: Fri, 8 Aug 2008 22:14:20 +0100
Message-ID: <200808082214.21230.carlos@strangeworlds.co.uk>
References: <1218167831.4978.11.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:33454 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758030AbYHHVOb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Aug 2008 17:14:31 -0400
In-Reply-To: <1218167831.4978.11.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: ak@linux.intel.com, linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Friday 08 August 2008 04:57:11 Lin Ming wrote:
> Hi, Andi
>
> The AE_BAD_ADDRESS exception code is now unused in ACPICA.
> For linux, it's only used at wmi.c and acer-wmi.c.
> I checked both wmi.c and acer-wmi.c, the AE_BAD_ADDRESS exception code
> has no special meaning. The parent functions just call AE_SUCCESS() or
> AE_FAILURE() to check the return status.
> So it's safe to replace AE_BAD_ADDRESS with AE_ERROR.
>
> Signed-off-by Lin Ming <ming.m.lin@intel.com>

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
