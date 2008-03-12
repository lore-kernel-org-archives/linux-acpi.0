From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Wed, 12 Mar 2008 14:39:08 -0300
Message-ID: <20080312173908.GA30864@khazad-dum.debian.net>
References: <20080226184937.GA4280@ics.muni.cz> <20080304194513.GY6704@kernel.dk> <47CDBA74.5080304@gmail.com> <20080304211212.GD6704@kernel.dk> <47CDBE11.4010900@gmail.com> <20080312125912.GM17940@kernel.dk> <20080312131737.GA21290@khazad-dum.debian.net> <20080312132419.GN17940@kernel.dk> <20080312133529.GB21290@khazad-dum.debian.net> <20080312135521.GE8141@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49797 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750968AbYCLRjM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 13:39:12 -0400
Content-Disposition: inline
In-Reply-To: <20080312135521.GE8141@ics.muni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 12 Mar 2008, Lukas Hejtmanek wrote:
> On Wed, Mar 12, 2008 at 10:35:29AM -0300, Henrique de Moraes Holschuh wrote:
> > You shouldn't need to do anything other than teach userspace to respond to
> > them, as they generate the proper KEY_* events.  If you are giving the AML
> > _OSI(Linux), at least...
> > 
> > But maybe looking at the keyboard output in console mode, to make triple
> > sure the events ARE being sent over the KDC as they should, would be in
> > order?
> 
> so, do I understand correctly that volume keys have been controlled by ACPI
> and seemed to work independently on SW and now (exactly since when?) are
> passed complety to the user space as key codes?

Yes, since the first *61 model.  And field-upgradeable firmware revisons
have a say on how this thing works, since the entire KDC is software in a
Lenovo ThinkPad (it is just a small part of the EC firmware, that comes with
the BIOS upgrades).

I have some long email sitting on my draft folders about how to restore full
sanity to thinkpad mixer behaviour on Linux, but I have to cool down for a
few days before I revise it and send it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
