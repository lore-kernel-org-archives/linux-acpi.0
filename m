From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop rfkill, stupid question #4
Date: Tue, 04 Nov 2008 15:57:32 +0000
Message-ID: <491070EC.4030309@tuffmail.co.uk>
References: <20081102040008.GB29606@khazad-dum.debian.net>	<490D8C4E.3010201@tuffmail.co.uk>	<20081102130655.GA12766@srcf.ucam.org>	<20081103141628.GB31078@khazad-dum.debian.net>	<20081103141836.GA31894@srcf.ucam.org>	<490F0ACC.4000808@tuffmail.co.uk>	<20081103145145.GD31078@khazad-dum.debian.net>	<20081103145543.GA496@srcf.ucam.org>	<20081103150229.GF31078@khazad-dum.debian.net>	<20081103150843.GA1107@srcf.ucam.org>	<20081103163311.GA2417@khazad-dum.debian.net> <20081104134832.6c596d54@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:32858 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923AbYKDP5j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Nov 2008 10:57:39 -0500
In-Reply-To: <20081104134832.6c596d54@doriath.conectiva>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Luiz Fernando N. Capitulino wrote:
> Em Mon, 3 Nov 2008 14:33:11 -0200
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> escreveu:
>
> | On Mon, 03 Nov 2008, Matthew Garrett wrote:
> | > On Mon, Nov 03, 2008 at 01:02:29PM -0200, Henrique de Moraes Holschuh wrote:
> | > > Right now, you should still rfkill_force_state().  Please wait for an hour
> | > > or two while I clean up that broken resume handling, and I will tell you for
> | > > sure.
> | > 
> | > Cool. I'll hold off posting my cleanups until then in that case.
> | 
> | Ok, two bugs reproduced, the fixes are ready and tested, and I will be
> | sending it now to linux-wireless.  You're in the CC, so you will get them.
> | 
> | I will also need to send patches for -stable, as the ones for mainline won't
> | apply to -stable.
>
>  Great.
>
>  Do the patches have anything to do with the problem I have reported?
>   

No.  These patches don't affect what happens when the rfkill device is
unregistered.

>  Rafael has opened a bugzilla ticket for it:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=11928
>   


