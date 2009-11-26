From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: regression: 2.6.32-rc8 shuts down after reaching critical
 temperature
Date: Thu, 26 Nov 2009 00:23:11 -0200
Message-ID: <20091126022311.GB22613@khazad-dum.debian.net>
References: <20091125102857.GA28310@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44988 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754021AbZKZCXI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Nov 2009 21:23:08 -0500
Content-Disposition: inline
In-Reply-To: <20091125102857.GA28310@lst.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009, Christoph Hellwig wrote:
> I recently upgraded my Thinkpad T500 from Linux 2.6.31 to Linux
> 2.6.32-rc (first -rc7 but I've also tried with -rc6 and -rc8) and when
> putting load on it, e.g. by building a kernel tree.  It shuts down soon
> with the
> 
> 	Critical temperature reached (%ld C), shutting down.\n"
> 
> printk from drivers/thermal/thermal_sys.c, where the temperature is
> usually 100C or slightly above.  The system is a Lenovo Thinkpad T500
> with a Intel Core 2 Dueo T9600 running a 32 bit kernel.

If you go back to the previous kernel, does the problem disappear?  Please
test and report (don't go by past experiences).

If it does disappear, what are the highest temperatures your thinkpad hits?

"sensors" from lm-sensors will tell you the current temperatures as long as
the "thermal" and "thinkpad-acpi" modules are loaded (don't run
sensors-detect).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
