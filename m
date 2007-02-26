From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH - 2.6.19 -0/1] Backport of psmouse suspend/shutdown cleanups
Date: Mon, 26 Feb 2007 09:34:05 -0500
Message-ID: <d120d5000702260634g3250e32ej3619a5f584f204af@mail.gmail.com>
References: <1172077685.10619.101.camel@d36.suse.de>
	 <d120d5000702210926j7e7f1ccjb8c2689640b870e8@mail.gmail.com>
	 <1172148739.10619.196.camel@d36.suse.de>
	 <d120d5000702220702r44894a51lfb5499b5c59d8563@mail.gmail.com>
	 <1172499672.10619.346.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:32472 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030283AbXBZOeH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Feb 2007 09:34:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so801436uga
        for <linux-acpi@vger.kernel.org>; Mon, 26 Feb 2007 06:34:06 -0800 (PST)
In-Reply-To: <1172499672.10619.346.camel@d36.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Hi Thomas,

On 2/26/07, Thomas Renninger <trenn@suse.de> wrote:
> On Thu, 2007-02-22 at 10:02 -0500, Dmitry Torokhov wrote:
> >
> > Hope this makes sense (I must admit it makes little sense to me ;) ).
>
> Same for me at the beginning.
> I tracked two of the HP problems (wrong temperature, wrong _PPC value)
> down to wrong EC reads -> BIOS issue.
>
> Someone (this is the guy who actually solved this) reported that
> unloading psmouse helps. When I saw this report confirmed by other
> people a .shutdown workaround was easy and got also confirmed working...
>
> And now it even makes a bit sense...
> There is a little microprocessor (Embedded Controller) pre-processing
> sensor or other data which gets accessed via ACPI. This one also access
> mouse/keyboard hardware (described a bit in ACPI specs).

Yes, I am aware that KBC is usually emulated by EC chip nowadays, what
does not really makes sense to me is how crazy the firmware is.

...
> FYI:
> You might stumble again over the EC in future...
> I saw reports where mouse jittering or similar bugs where fixed in
> drivers/acpi/ec.c
> If trying ec_intr=0 boot param, not loading any ACPI modules or the big
> hammer: acpi=off helps to solve mouse or keyboard problems it's probably
> Embedded Controller related (which might need a fix in ec.c, AML or EC
> BIOS code (in this case we seem to have the latter problem :) )...).
>

Yep, seen that, except for AML workarounds. Do you have any examples?
Although there seem to be lees complaints about mice jittering
nowadays... Or maybe they simply got tired of complaining ;)

-- 
Dmitry
