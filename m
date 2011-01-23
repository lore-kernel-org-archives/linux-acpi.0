From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps
 management
Date: Sun, 23 Jan 2011 16:20:37 -0200
Message-ID: <20110123182037.GH24071@khazad-dum.debian.net>
References: <201101201226.41021.rjw@sisk.pl>
 <201101212206.37469.rjw@sisk.pl>
 <AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
 <201101221013.10239.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53319 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107Ab1AWSUk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Jan 2011 13:20:40 -0500
Content-Disposition: inline
In-Reply-To: <201101221013.10239.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org

On Sat, 22 Jan 2011, Rafael J. Wysocki wrote:
> > I discovered CONFIG_THINKPAD_ACPI caused suspend-to-disk to hang. I
> > need the Thinkpad ACPI to control the fan and bluetooth. It looks like
> > the thinkpad acpi is trying acquire locks while suspending.  Disabling
> > cmos, light, led and hotkeys makes suspend-to-disk works again.
> 
> Well, we should tell the thinkpad_acpi maintainer about that, then (CCed).

What are the requirements re. mutexes for sleep-to-disk versus sleep-to-ram?

Did something change in that area that caused the driver to hang?  A pointer
to the ML threads, documentation, or patchset/git commit with those changes
would be enough answer, and I will pursue it from there.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
