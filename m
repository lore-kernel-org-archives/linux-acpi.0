From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Date: Thu, 20 Dec 2007 02:17:02 +0000
Message-ID: <200712200217.03861.carlos@strangeworlds.co.uk>
References: <20071204215154.7f26285e.mikeserv@bmts.com> <200712200045.16899.carlos@strangeworlds.co.uk> <200712192113.22974.el@prans.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:50766 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbXLTCSp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Dec 2007 21:18:45 -0500
In-Reply-To: <200712192113.22974.el@prans.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Elvis Pranskevichus <el@prans.net>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Jean Delvare <khali@linux-fr.org>, Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Thursday 20 December 2007 02:13:22 Elvis Pranskevichus wrote:
> Hi Carlos,
>
> I've attached the DSDT for Gigabyte GA-965G-DS3 (rev 1.0, bios rev. F9) to
> bugzilla entry #9514:
>
> http://bugzilla.kernel.org/attachment.cgi?id=14132

A quick look over the DSDT shows that there is no ACPI-WMI mapper device 
(PNP0C14) on this board; so WMI is, at least in this case, not the solution 
to this bug.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
