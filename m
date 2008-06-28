From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 04/84] misc,acpi,backlight: compal Laptop Extras
Date: Sat, 28 Jun 2008 15:56:31 +0100
Message-ID: <20080628145631.GA23803@srcf.ucam.org>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com> <45fea4a84325d5724ffe480ae6f0d1658d520141.1214631213.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45001 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbYF1O4g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 10:56:36 -0400
Content-Disposition: inline
In-Reply-To: <45fea4a84325d5724ffe480ae6f0d1658d520141.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

On Sat, Jun 28, 2008 at 01:43:08AM -0400, Len Brown wrote:
> This driver exports a few files in /sys/devices/platform/compal-laptop/:
>  lcd_level - screen brightness: contains a single integer in the range 0..7 (rw)
>  wlan - wlan subsystem state: contains 0 or 1 (rw)
>  bluetooth - bluetooth subsystem state: contains 0 or 1 (rw)
>  raw - raw value taken from embedded controller register (ro)

Can we make sure this is changed to use rfkill before merging?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
