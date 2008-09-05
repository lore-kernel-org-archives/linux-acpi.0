From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: ACPI (atlas_btns) locks my box for minutes
Date: Fri, 5 Sep 2008 08:31:37 +0200
Message-ID: <200809050831.37422.hs4233@mail.mn-solutions.de>
References: <200809041300.20141.hs4233@mail.mn-solutions.de> <alpine.LFD.1.10.0809041731160.3662@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:56512 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbYIEGcE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 02:32:04 -0400
In-Reply-To: <alpine.LFD.1.10.0809041731160.3662@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Jaya Kumar <jayakumar.acpi@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

On Thursday 04 September 2008 23:36:14 Len Brown wrote:
> Does the hang and interrupt storm only happen
> upon pressing the button?
> (ie. it does not happen if you do not press the button,
>  and it does not happen if atlas_btns is not loaded)

Yes, it is related to pressing the buttons. I suspect that it 
migth have something with the frequency of the pressings, e.g. 
when I do it very fast. Or maybe the connectors of the button to 
bounce (not sure if this is the right english word for 
german "prellen").


If I don't press buttons, the box doesn't lock up.

I need to find out if the existence of atlas_btns makes a 
difference. My guess is that it shouldn't make any difference, 
the atlas_btns driver doesn't do anything with the interrupt 9. 
It's the ACPI subsystem that handles this interrupt, atlas_btns 
just "subscribes" into it and filters out some events ...

/me going to find out
