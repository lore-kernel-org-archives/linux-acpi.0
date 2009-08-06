From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: a backlight issue
Date: Thu, 6 Aug 2009 09:55:52 -0300
Message-ID: <20090806125552.GB15867@khazad-dum.debian.net>
References: <1245895749.7266.70.camel@localhost.localdomain>
 <200908051450.27970.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43526 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755318AbZHFMzy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Aug 2009 08:55:54 -0400
Content-Disposition: inline
In-Reply-To: <200908051450.27970.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: yakui_zhao <yakui.zhao@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, rpurdie@linux.intel.com, jbarnes@virtuousgeek.org, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Wed, 05 Aug 2009, Thomas Renninger wrote:
> If in KMS drivers backlight switching method is implemented
> and can register for the generic backlight driver, it should always be
> disabled by default. Instead, KMS drivers should export a simple
> "backlight_enable" file somewhere in sysfs. If userspace doesn't
> find a sysfs backlight interface, it can do:
> echo 1 >/sys/path_to_graphics_card/backlight_enable
> and a backlight sysfs interface should pop up on success.

IMO, we already have an in-kernel selector of the backlight control method
for mutually-exclusive backlight control strategies.  We should use that,
and if it is complete/good enough to add the KMS scenario, improve it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
