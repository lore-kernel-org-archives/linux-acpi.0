From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 04/70] misc,acpi,backlight: compal Laptop Extras
Date: Fri, 20 Jun 2008 12:48:04 +0100
Message-ID: <20080620114804.GA8637@srcf.ucam.org>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com> <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49627 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbYFTLsL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 07:48:11 -0400
Content-Disposition: inline
In-Reply-To: <45fea4a84325d5724ffe480ae6f0d1658d520141.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

On Fri, Jun 20, 2008 at 03:43:06AM -0400, Len Brown wrote:
>  wlan - wlan subsystem state: contains 0 or 1 (rw)
>  bluetooth - bluetooth subsystem state: contains 0 or 1 (rw)

Could we please not add any more drivers with custom radio control 
options? rfkill is a pretty small amount of code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
