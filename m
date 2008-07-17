From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other GPEs)
 on Asus EeePC
Date: Thu, 17 Jul 2008 20:07:22 +0100
Message-ID: <487F986A.3070504@tuffmail.co.uk>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F31D7.30803@suse.de> <20080717121309.GF31732@khazad-dum.debian.net> <487F3B6D.3090507@suse.de> <20080717162628.GB18457@khazad-dum.debian.net> <487F7724.5080905@tuffmail.co.uk> <20080717185032.GD18457@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:21066 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757932AbYGQTHG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 15:07:06 -0400
Received: by nf-out-0910.google.com with SMTP id d3so19910nfc.21
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jul 2008 12:07:05 -0700 (PDT)
In-Reply-To: <20080717185032.GD18457@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Thu, 17 Jul 2008, Alan Jenkins wrote:
>   
>> Actually Alexey has another patch in bugzilla (#10919) which resolves
>> this issue in a better way.  It avoids polling altogether, which is good
>> because it means you get events immediately.  My laptop has backlight
>> adjustment hotkeys with hardware autorepeat, so it looks really jerky
>> with polling.
>>     
>
> We need to get ALL pending events from the EC, whether in polling mode or in
> interrupt mode 

> (and we must make sure that we ARE going to queue any new
> interrupt before we stop checking for an empty pending event queue,
> otherwise there is a small window where a new event might get queued, and we
> are still masking the GPE and don't notice it).  As long as the fix does
> that, it is all I care :-)
>   
OK, I forgot about that. I need to do some reading on kernel
programming, workqueues in particular, and redo my patch again. Sorry,
Alexey! AFAICS there's still this (very) small window where events could
be dropped.

Alan
