From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2 update] misc: Add dell-laptop driver
Date: Fri, 5 Dec 2008 00:05:47 -0200
Message-ID: <20081205020547.GA4365@khazad-dum.debian.net>
References: <20081127163357.GA22846@srcf.ucam.org> <20081127163444.GB22846@srcf.ucam.org> <20081202115029.2b9d1153.akpm@linux-foundation.org> <20081202201645.GB31620@srcf.ucam.org> <49368329.19e7300a.0526.5a68@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57395 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753545AbYLECFy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Dec 2008 21:05:54 -0500
Content-Disposition: inline
In-Reply-To: <49368329.19e7300a.0526.5a68@mx.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: none <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, greg@kroah.com, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Ivo van Doorn <ivdoorn@gmail.com>

(I feel weird replying to "none" :-) )

On Wed, 03 Dec 2008, none wrote:
> > +		wifi_rfkill->get_state = dell_wifi_get;
> 
> The rfkill doc (and code) say that you also need to initialize
> wifi_rfkill->state to the current state of the hardware.

I may have screwed up and ommited from the docs the fact that it is not
strictly necessary to do so if you provide rfkill->get_state.  So that is
not a serious problem with the patch at all.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
