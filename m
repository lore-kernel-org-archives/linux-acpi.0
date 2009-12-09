From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [PATCH 10/10] thinkpad-acpi: sync input
 device EV_SW state directly
Date: Wed, 9 Dec 2009 14:30:41 -0200
Message-ID: <20091209163041.GA29575@khazad-dum.debian.net>
References: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
 <1260322590-5571-11-git-send-email-hmh@hmh.eng.br>
 <200912081745.14725.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54326 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755746AbZLIQai (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 11:30:38 -0500
Content-Disposition: inline
In-Reply-To: <200912081745.14725.dmitry.torokhov@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, ibm-acpi-devel@lists.sourceforge.net, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <lenb@kernel.org>

On Tue, 08 Dec 2009, Dmitry Torokhov wrote:
> On Tuesday 08 December 2009 05:36:30 pm Henrique de Moraes Holschuh wrote:
> > Before we register the input device, sync the input layer EV_SW state
> > directly by setting the bitmaps, to avoid issuing a gratuitous event
> > for the initial state of these switches.
> > 
> > I will propose a clean input layer API for this and change the driver
> > to use it later, but I'd rather get the driver fix in mainline ASAP.
> > 
> 
> Just do input_report_switch() before registering the device, it will do
> the right thing.

At device startup, the input core doesn't know the initial state of the
switch. It assumes the switch is "off" (all bits clear in the sw bitmap).

input_report_switch() will call input_event(), which will have a 50% chance
of doing the wrong thing at startup (i.e. issue an event) since it will look
at the state of the sw bitmap to decide whether to issue an event or not.

> Input core guarantees (and will continue doing so) that it is safe to
> pass events to the device as soon as it was allocated with
> input_allocate_device().

Well, there really isn't a transparent way to do this...

Either you change the core to use the first event reported to init the
switch and never issue that first event outside the core (we will also have
to make sure all drivers know they have to issue this initial event), or you
add an API for the drivers to directly inform the core of the initial state
of the switches (I have this already written) and check all drivers that
export EV_SW events to make sure they use the API (I haven't done this yet).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
