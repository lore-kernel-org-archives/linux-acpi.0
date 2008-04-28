From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup() policy
	inputs
Date: Mon, 28 Apr 2008 18:35:53 -0300
Message-ID: <20080428213553.GA3489@khazad-dum.debian.net>
References: <200803201408.33466.david-b@pacbell.net> <200804182118.05228.david-b@pacbell.net> <1208871017.14474.52.camel@yakui_zhao.sh.intel.com> <200804261237.26499.david-b@pacbell.net> <1209386885.884.9.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35363 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763832AbYD1Vf4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Apr 2008 17:35:56 -0400
Content-Disposition: inline
In-Reply-To: <1209386885.884.9.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Thomas Renninger <trenn@suse.de>

On Mon, 28 Apr 2008, Zhao Yakui wrote:
> Yes. What your said is right. If your patch is applied, whether the PCI
> device can wake the sleeping system is controlled by device driver. In
> such case the /proc/acpi/wakeup will be useless.

Which calls for a new standard interface to let userpace control that,
doesn't it?  Issues with wake-up devices are not uncommon, the user
really has to have a way to configure that, and IMHO it better be a
generic one...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
