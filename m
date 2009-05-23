From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Sat, 23 May 2009 00:18:11 -0300
Message-ID: <20090523031811.GB10163@khazad-dum.debian.net>
References: <1242892973.8523.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45279 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233AbZEWDSN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 May 2009 23:18:13 -0400
Content-Disposition: inline
In-Reply-To: <1242892973.8523.53.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 21 May 2009, yakui_zhao wrote:
> +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);

Is this safe against overflows, i.e. is pr->id something *we* set?  Because
if it is in any way read from the ACPI firmware, you have to either use
snprintf, or use the format string to limit the %X to a safe lenght...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
