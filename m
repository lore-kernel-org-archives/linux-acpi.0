From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2] thinkpad_acpi: Hook volume events
Date: Wed, 5 May 2010 08:30:05 -0300
Message-ID: <20100505113004.GA19480@khazad-dum.debian.net>
References: <1272916980-11835-1-git-send-email-mjg@redhat.com>
 <1272916980-11835-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43622 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757233Ab0EELaJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2010 07:30:09 -0400
Content-Disposition: inline
In-Reply-To: <1272916980-11835-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Mon, 03 May 2010, Matthew Garrett wrote:
> Not all Thinkpads generate events for volume hotkeys, so hook into the
> CMOS update and generate events from there without polling. This should
> let Pulseaudio do something sensible with the mute state.

The idea is sound, but it would be probably cleaner to do it only on those
thinkpads which need it.  I don't like the idea of handling duplicate
notifications, and the logic depends entirely on nothing messing with the
mixer state behind our backs, I'd prefer to rely on it just when strictly
required.

Also, UCMS is called for a number of reasons.  It would be best to filter
based on the UCMS parameter before doing an expensive PC CMOS RAM read or EC
read.  We will be dealing with a finite number of thinkpads anyway.

On the same note, we need to be called *after* the UCMS method completes,
otherwise, we will have to schedule delayed work.  I didn't study your ACPI
patch enough to know whether this happens, but that detail is not clear from
the description.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
