From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/3] backlight: Allow drivers to update the core, and
 generate events on changes
Date: Tue, 14 Jul 2009 07:30:07 -0300
Message-ID: <20090714103006.GA19866@khazad-dum.debian.net>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54202 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754424AbZGNKaP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jul 2009 06:30:15 -0400
Content-Disposition: inline
In-Reply-To: <1247517685-7719-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net

On Mon, 13 Jul 2009, Matthew Garrett wrote:
> Certain hardware will send us events when the backlight brightness
> changes. Add a function to update the value in the core, and
> additionally send a uevent so that userspace can pop up appropriate
> UI. The uevents are flagged depending on whether the update originated
> in the kernel or from userspace, making it easier to only display UI
> at the appropriate time.

Any reasons to not do it using poll() support (since sysfs has it)?  Or at
least, do both poll and uevents?

Other than that, I like the idea a lot.  thinkpad-acpi will use this event
support.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
