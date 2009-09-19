From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
 generate events on changes
Date: Sat, 19 Sep 2009 20:24:24 -0300
Message-ID: <20090919232424.GA15200@khazad-dum.debian.net>
References: <1247587564-27737-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44915 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026AbZISXYX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Sep 2009 19:24:23 -0400
Content-Disposition: inline
In-Reply-To: <1247587564-27737-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net

On Tue, 14 Jul 2009, Matthew Garrett wrote:
> Certain hardware will send us events when the backlight brightness
> changes. Add a function to update the value in the core, and
> additionally send a uevent so that userspace can pop up appropriate
> UI. The uevents are flagged depending on whether the update originated
> in the kernel or from userspace, making it easier to only display UI
> at the appropriate time.

Ok.  I have it working (event-based AND poll-based) in thinkpad-acpi,
although it needs to be tested by dual-GPU, ACPI-based and OpRegion-based
owners.

Should the driver notify of *any* changes, even when the user is hitting the
"ceiling" or the "floor" and the backlight value didn't really change?

If the answer is no, shouldn't the backlight class filter these out itself,
to guarantee a consistent experience?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
