From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: cpu voltage change question
Date: Thu, 27 Jan 2011 16:31:08 -0200
Message-ID: <20110127183108.GG18579@khazad-dum.debian.net>
References: <1296119453.4653.1.camel@genix>
 <4D41996C.1060600@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52813 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805Ab1A0SbL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jan 2011 13:31:11 -0500
Content-Disposition: inline
In-Reply-To: <4D41996C.1060600@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: mihn <mihnsk@gmail.com>, linux-acpi@vger.kernel.org

On Thu, 27 Jan 2011, Phillip Susi wrote:
> The voltage is controlled by the platform and should already be set to a
> level appropriate for that frequency.  AFAIK, recent intel cpus have
> MSRs that configure the voltage for each P-state, but these are set up
> by the bios and shouldn't need changed.

"Need", certainly not.

But downvolting and downclocing are very effective ways to get some extra
battery time (or at least used to be, I have no idea if they still are that
useful in the newest processors), so you will find that there is a community
of "downclockers" among laptop enthusiasts, much like the "overclock"
community on the gaming enthusiasts :P

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
