From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: always enable input layer, add
	hotkey_report_mode
Date: Mon, 3 Sep 2007 20:17:23 -0300
Message-ID: <20070903231723.GC3899@khazad-dum.debian.net>
References: <1188789388345-git-send-email-hmh@hmh.eng.br> <1188789388452-git-send-email-hmh@hmh.eng.br> <200709031715.06269.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42633 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751762AbXICXR2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2007 19:17:28 -0400
Content-Disposition: inline
In-Reply-To: <200709031715.06269.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Richard Hughes <hughsient@gmail.com>

On Mon, 03 Sep 2007, Len Brown wrote:
> I may be seriously jet-lagged right now,
> but I'm having trouble parsing this check-in comment
> and the the Documentation update, so I'm not
> clear on what you're trying to do with this code.

Sounds like at the very least I need to be more clear on both, then :)


The idea is this:

1. I want old userspace to just work with thinkpad-acpi (old userspace uses
ACPI via procfs, and ignores the thinkpad-acpi input devices, but does open
them for some dumbass reason).   This means I must send every event over the
ACPI procfs interface by default.

2. I want new userspace to just work, but using input devices and netlink.
This means I must not send any events that go over the input device also to
the netlink ACPI event interface.

(and, here's what causes the need for the patch):

3. I want to give userspace a way to allow it to use input devices and also
the ACPI procfs interface, because thinkpad-acpi backports to 2.6.20, 2.6.21
and 2.6.22 are really popular.   This means I need to let userspace tell
thinkpad-acpi to NOT send every event over the procfs interface.

> hotkeys are reported through the input layer,
> and /proc/acpi/event when CONFIG_ACPI_PROC_EVENT=y

It does this by default.

> all other events are reported via netlink,
> and /proc/acpi/event when CONFIG_ACPI_PROC_EVENT=y

It does this by default.

> And if you need to add a flag to eliminate duplicate
> reporting, so be it.

It uses a module parameter on 2.6.23, because I am not giving userspace an
easy way out to skip on supporting the netlink ACPI interface ;-)  They will
had to add both functionalities at once if they want 2.6.23 to be supported.

For older kernels, the thinkpad-acpi backports allow userspace to change
reporting behaviour through sysfs, and not just the module parameter (which
is also accepted).

> But I'm totally confused why there is any mention of netlink
> in any of this text -- for if this patch is really
> specific to hotkey events, then no version of any
> kernel should send hotkey events via netlink,
> and no version of HAL should listen for hotkey
> events on netlink.

I will see if I can clarify that text ASAP.

> thanks,

Thanks for the review of the patch!

> ps.
> For me to apply a patch post -rc5,
> it really has to be a bug fix -- preferably fixing a regression.
> ie. "revert new 2.6.23 CONFIG_THINKPAD_ACPI_INPUT_ENABLED option
> because it would create a legacy we don't want to support"
> would be a suitable synopsis -- "always enable input layer"
> sort of gives the impression that this is a new feature, not a fix...

Heh, I will change it to look like that :)

> pps. 
> On Sunday 02 September 2007 23:16, Henrique de Moraes Holschuh wrote:
> > Now that ACPICA can send events over netlink, we can use a different
> 
> Note that ACPICA doesn't know anything about how events are sent
> to user-space -- is it Linux specific ACPI code that does this.

Ok, I will call it ACPI core, then.

The patches should arrive to this list in a few hours.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
