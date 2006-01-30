From: Vasileios Gkanis <gkanis@cems.umn.edu>
Subject: Re: High pitched sound with 2.6.15-ck1 --  Update info
Date: Mon, 30 Jan 2006 17:32:47 +0200
Message-ID: <200601301732.47677.gkanis@cems.umn.edu>
References: <200601280105.44804.gkanis@cems.umn.edu> <43DB511B.5020605@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tyr.cems.umn.edu ([134.84.164.251]:31944 "EHLO
	mail.cems.umn.edu") by vger.kernel.org with ESMTP id S932327AbWA3Pcw
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jan 2006 10:32:52 -0500
In-Reply-To: <43DB511B.5020605@tzi.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-acpi@vger.kernel.org

> Jep,
> this happens because your power converters starts "singing". If
> you switch the C-State, you need a different amount of power. So if
> you have a kernel frequency of 1000 herz, your power converter has
> to adjust the amount of power 1000 times per second. And because
> of that it starts "singing". By the way, you can also modulate the sound
> by scaling your CPU frequency up or down. (Perhaps you could also write
> a programm, that can play some melody based on this phaenomenon ;-) )
>
>     Janosch

What you said is correct. But, do you know why this happens when I plug in the 
USB-mouse and not when I plug in the USB-stick?

Vasilis
