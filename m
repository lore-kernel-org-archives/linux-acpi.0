From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] thermal: add hwmon sys I/F for thermal device
Date: Thu, 13 Mar 2008 20:09:19 -0300
Message-ID: <20080313230919.GG30864@khazad-dum.debian.net>
References: <1204072670.10256.111.camel@acpi-hp-zz.sh.intel.com> <200803120029.09505.lenb@kernel.org> <200803130109.45531.lenb@kernel.org> <1205405941.29877.341.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60325 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267AbYCMXJV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 19:09:21 -0400
Content-Disposition: inline
In-Reply-To: <1205405941.29877.341.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>

On Thu, 13 Mar 2008, Thomas Renninger wrote:
> This also happens in drivers/misc/thinkpad_acpi.c.

I was sure I had removed __exit from every thinkpad-acpi exit handler that
was also called from __init a long time ago...

Let's see... nope, there isn't a single instance of __exit in
thinkpad-acpi.c, so I must have misunderstood you.  I do have lots of
__init code, but I don't get any warnings from gcc 4.3 about that on ia32.

Can you please send me the warnings/errors you get in thinkpad-acpi?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
