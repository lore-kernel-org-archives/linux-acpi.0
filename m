From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: thinkpad_acpi: define _sta only when needed
Date: Wed, 16 Jan 2008 19:54:00 -0200
Message-ID: <20080116215400.GA554@khazad-dum.debian.net>
References: <1200488504-6789-1-git-send-email-hannes@saeurebad.de> <20080116191317.GA29449@khazad-dum.debian.net> <87sl0xcw8s.fsf@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48038 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750917AbYAPVyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 16:54:12 -0500
Content-Disposition: inline
In-Reply-To: <87sl0xcw8s.fsf@saeurebad.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Weiner <hannes@saeurebad.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 16 Jan 2008, Johannes Weiner wrote:
> > Johannes, thanks for the patches, but NAK.  A similar group of patches that
> > clean up the _sta and heander file (kills it, actually) has already been
> > sent to Len Brown to be merged for 2.6.25.
> 
> Sorry, I missed to check his tree in advance.  And if the work is
> already done - even better! :)

I don't think Len merged the latest version of the patchset yet, but a
previous version is available in the acpi-test tree.  The latest version was
posted to linux-acpi recently.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
