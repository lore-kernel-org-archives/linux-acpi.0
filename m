From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 1/2] x86 platform drivers, wmi: Remove needless dmi MODULE_ALIAS
Date: Fri, 18 Dec 2009 16:43:19 +0000
Message-ID: <200912181643.19908.carlos@strangeworlds.co.uk>
References: <1261146563-2228-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:56371 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbZLRQnW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 11:43:22 -0500
Received: by ey-out-2122.google.com with SMTP id d26so829073eyd.19
        for <linux-acpi@vger.kernel.org>; Fri, 18 Dec 2009 08:43:20 -0800 (PST)
In-Reply-To: <1261146563-2228-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Friday 18 December 2009 14:29:22 Thomas Renninger wrote:
> wmi autoloading came in, so the dmi matching for autoloading
> is not needed anymore.
> 
> CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: linux-acpi@vger.kernel.org
> CC: Len Brown <lenb@kernel.org>
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>

For acer-wmi:

Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>

-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
