From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Can't get ACPI to work on a Panasonic Toughbook CF-52
Date: Wed, 30 Apr 2008 07:58:15 +0100
Message-ID: <200804300758.16301.carlos@strangeworlds.co.uk>
References: <4801D253.40904@orle.de> <480319F5.1060702@orle.de> <1208196157.4031.61.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:36892 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbYD3G6X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 02:58:23 -0400
In-Reply-To: <1208196157.4031.61.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Ralf Orlowski <ralf@orle.de>, linux-acpi@vger.kernel.org

On Monday 14 April 2008 19:02:37 Zhao Yakui wrote:
> Sorry that you can't use the custom DSDT downloaded from the bug9915.
> You had better modify the DSDT based on your laptop.
> To modify the following will be OK
>
>  OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)  // This is incorrect.
>  The correct definition should be the following:
>     OperationRegion (IGDM, SystemMemory, \ASLB, 0x2000)

Could this be a case of http://bugzilla.kernel.org/show_bug.cgi?id=8953 in a 
completely different machine? (Windows somehow seems able to handle these 
broken paths...)

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
