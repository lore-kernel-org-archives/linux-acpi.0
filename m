From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2] eeepc-laptop: Use standard interfaces
Date: Mon, 4 Aug 2008 18:21:13 -0300
Message-ID: <20080804212113.GB24927@khazad-dum.debian.net>
References: <20080804170833.GA9513@srcf.ucam.org> <20080804171504.GB9513@srcf.ucam.org> <200808041953.38829.IvDoorn@gmail.com> <20080804173627.GA10302@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57607 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757123AbYHDVVS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2008 17:21:18 -0400
Content-Disposition: inline
In-Reply-To: <20080804173627.GA10302@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, corentincj@iksaif.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 04 Aug 2008, Matthew Garrett wrote:
> On Mon, Aug 04, 2008 at 07:53:38PM +0200, Ivo van Doorn wrote:
> > On Monday 04 August 2008, Matthew Garrett wrote:
> > > eeepc-laptop currently only sends key events via ACPI and has 
> > > non-standard rfkill control. Add an input device and use the rfkill 
> > > infrastructure.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > Please use the rfkill_force_state() to report state changes,
> > that will ensure that the events are immediately send to the
> > rfkill layer.
> 
> Why does writing to the sysfs file not generate an update implicitly? 

It does.  rfkill_force_state() is used to propagate state changes done by
outside sources back into rfkill.  All internal changes caused by rfkill or
known to rfkill are dealt with by rfkill itself.

If there are no such outside sources, you don't need rfkill_force_state() or
get_state() at all, as long as you set rfkill->state properly before you
call rfkill_register.

BTW: if it has a hardware rfkill switch that overrides the rfkill
controller, that DOES count as an outside source of changes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
