From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: a question about lid input device
Date: Mon, 05 Jul 2010 09:47:24 +0800
Message-ID: <1278294444.4537.6134.camel@rzhang1-desktop>
References: <1276412011.19052.19294.camel@rzhang1-desktop>
	 <20100614020127.GA30773@khazad-dum.debian.net>
	 <alpine.LFD.2.00.1006212156140.26824@localhost.localdomain>
	 <20100704083553.GE32427@core.coreip.homeip.net>
	 <1278292140.4537.6088.camel@rzhang1-desktop>
	 <C5204E20-E9CE-40D7-9398-A32D6E993EE0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23497 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758097Ab0GEBqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Jul 2010 21:46:39 -0400
In-Reply-To: <C5204E20-E9CE-40D7-9398-A32D6E993EE0@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2010-07-05 at 09:28 +0800, Dmitry Torokhov wrote:
> On Jul 4, 2010, at 6:09 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> 
> > On Sun, 2010-07-04 at 16:35 +0800, Dmitry Torokhov wrote:
> >> On Mon, Jun 21, 2010 at 09:56:37PM -0400, Len Brown wrote:
> >>> Dmitry,
> >>> Is there a reason not to simply add a "state" attribute
> >>> to a LID input device?
> >>>
> >>
> >> Len,
> >>
> >> There is no LED input device, there is an input device that happens  
> >> to
> >> report EV_SW/SW_LID state. If we did that we'd need to add attributes
> >> for all types of switches, keys, current values of REL and ABS axis,
> >> min/max/fuzz/flat settings of ABS axis and so forth that input device
> >> might report. I do not think it is a good idea.
> >>
> > I agree.
> > How about adding a field in uevent file that reports the switch  
> > status?
> >
> 
> 
> I think if you can listen to uevents you can just as easily open /dev/ 
> input/eventX and listen to proper input events.
> 
the question is users may want to get the lid switch STATUS,
asynchronously.

thank,
rui


