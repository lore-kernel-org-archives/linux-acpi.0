From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2 update] misc: Add dell-laptop driver
Date: Fri, 5 Dec 2008 00:08:04 -0200
Message-ID: <20081205020804.GB4365@khazad-dum.debian.net>
References: <20081127163357.GA22846@srcf.ucam.org> <20081127163444.GB22846@srcf.ucam.org> <20081202115029.2b9d1153.akpm@linux-foundation.org> <20081202201645.GB31620@srcf.ucam.org> <alpine.LFD.2.00.0812031414150.3255@localhost.localdomain> <20081203195238.GA22560@srcf.ucam.org> <4937B85C.5050808@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45273 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537AbYLECII (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2008 21:08:08 -0500
Content-Disposition: inline
In-Reply-To: <4937B85C.5050808@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, greg@kroah.com, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Ivo van Doorn <ivdoorn@gmail.com>

On Thu, 04 Dec 2008, Alan Jenkins wrote:
> I still think you need to initialise wifi_rfkill->state before you call
> rfkill_register().
> 
> It seems an easy mistake, probably the rfkill core should test for it.

Well, yes, I could add that paranoia to the core.  Added to the todo
list.

But the core will re-init rfkill->state from rfkill->get_state(), so
it is not a serious problem at all (since the drive provides
rfkill->get_state().

The reason it is recommended to always init the thing, is that if you
later move to a purely event-driven rfkill interface, you won't break
things.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
