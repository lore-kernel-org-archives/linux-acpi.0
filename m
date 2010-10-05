From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] ACPI: Allow handlers to be installed at the same time as methods
Date: Wed, 6 Oct 2010 01:18:50 +0200
Message-ID: <201010060118.50875.rjw@sisk.pl>
References: <1286216549-5438-1-git-send-email-mjg@redhat.com> <1286216549-5438-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48376 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205Ab0JEXTn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Oct 2010 19:19:43 -0400
In-Reply-To: <1286216549-5438-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

On Monday, October 04, 2010, Matthew Garrett wrote:
> There are circumstances under which it may be desirable for GPE handlers
> to be installable without displacing the existing GPE method. Add support
> for this via a boolean argument to acpi_install_gpe_handler, and fix up the
> existing users to ensure that their behaviour doesn't change.

Hmm.  I'm not sure this is the best way to do that.

In fact, what we need to handle is the case in which a GPE is pointed to by
a _PRW method somewhere and we presume that it's necessary to execute
Notify() for it regardless of whether or not it has a method, right?

So, this GPE will have ACPI_GPE_CAN_WAKE, so can we just put something like

if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE)
         execute Notify()

somewhere around the switch statement in acpi_ev_gpe_dispatch()?

Or perhaps replace acpi_ev_asynch_enable_gpe() with something that will
execute Notify() and then do what the original acpi_ev_asynch_enable_gpe() does?

That should be easier to implement after the changes we've been discussing with
Bob recently (basically, handle both GPE handlers and _Lxx/_Exx analogously).

Rafael
