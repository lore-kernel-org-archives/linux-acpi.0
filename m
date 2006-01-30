From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: High pitched sound with 2.6.15-ck1 --  Update info
Date: Mon, 30 Jan 2006 22:59:05 +0100
Message-ID: <43DE8C29.1030007@tzi.de>
References: <200601280105.44804.gkanis@cems.umn.edu> <43DB511B.5020605@tzi.de> <200601301732.47677.gkanis@cems.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m1.informatik.uni-bremen.de ([134.102.201.18]:26844 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S932276AbWA3V67 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Jan 2006 16:58:59 -0500
In-Reply-To: <200601301732.47677.gkanis@cems.umn.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasileios Gkanis <gkanis@cems.umn.edu>
Cc: linux-acpi@vger.kernel.org

Vasileios Gkanis schrieb:
>>Jep,
>>this happens because your power converters starts "singing". If
>>you switch the C-State, you need a different amount of power. So if
>>you have a kernel frequency of 1000 herz, your power converter has
>>to adjust the amount of power 1000 times per second. And because
>>of that it starts "singing". By the way, you can also modulate the sound
>>by scaling your CPU frequency up or down. (Perhaps you could also write
>>a programm, that can play some melody based on this phaenomenon ;-) )
>>
>>    Janosch
> 
> 
> What you said is correct. But, do you know why this happens when I plug in the 
> USB-mouse and not when I plug in the USB-stick?

I would guess that the mouse has a higher power consumption as the 
stick. Try to put in some other usb-devices, that needs a lot of power 
(one of this usb-harddrives without external AC for example) and test it 
  ;-)
   Janosch
