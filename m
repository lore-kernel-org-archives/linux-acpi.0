From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: cpu voltage change question
Date: Thu, 27 Jan 2011 16:47:43 -0200
Message-ID: <20110127184743.GH18579@khazad-dum.debian.net>
References: <1296119453.4653.1.camel@genix>
 <4D41996C.1060600@cfl.rr.com>
 <AANLkTimrrD+mgwMMcqBNoZgOXfipG+XoCDGKVWOxYbRC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33324 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751889Ab1A0Srp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jan 2011 13:47:45 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimrrD+mgwMMcqBNoZgOXfipG+XoCDGKVWOxYbRC@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mihn leigh <mihnsk@gmail.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-acpi@vger.kernel.org

On Thu, 27 Jan 2011, mihn leigh wrote:
> Yes, you're right. As you said, MSR register contains the frequency
> and voltage information of cpu. By writing the register, we can change
> voltage as well (it's the information from intel datasheet). But, i
> cannot find the detail of this register.
> 
> BTW, what's the reason that MSR register can not be changed in OS
> level? is it only possible to change in BIOS?

Well, while we do provide users with enough rope to hang themselves as a
regular friendly kernel service (especially if it is limited to root
access), we usually refrain from giving them hand grenades with the safety
pin removed...

And sometimes the hardware does the same, and thus the notion of the
write-once register was born.  I don't think it is the case here, but...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
