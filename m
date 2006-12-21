From: "Balaji Rao" <balajirrao@gmail.com>
Subject: Re: Power States
Date: Thu, 21 Dec 2006 22:30:23 +0530
Message-ID: <569c97d20612210900k2b537c2avb824c257ffd0f365@mail.gmail.com>
References: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>
	 <45898257.5060004@linux.intel.com>
	 <569c97d20612201051la543b85r11a789affe356e1@mail.gmail.com>
	 <458A34C5.3000406@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:27944 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422980AbWLURAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Dec 2006 12:00:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2704370uga
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 09:00:23 -0800 (PST)
In-Reply-To: <458A34C5.3000406@imag.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Henriot <Oliver.Henriot@imag.fr>
Cc: linux-acpi@vger.kernel.org

On 12/21/06, Oliver Henriot <Oliver.Henriot@imag.fr> wrote:
> Dans sa grande sagesse, Balaji Rao a =E9crit, le 20.12.2006 19:51 :
> > Also, power management is reported as not available.
> Do you mean power management as in apm? In that case, it is most
> probably normal behavior, it seems some recent core2duo setups simply=
 do
> not support apm at all.
No i am talking about ACPI and CPUFREQ.
> > Where can i look for a solution?
> I've given up apm altogether and use only cpufreq + acpi on my core2d=
uo
> T7200 and appart from getting C3 to work even when on mains, I haven'=
t
> had any particular hassles.
>
I think you are talking about core 2 duo mobile processor. But mine is
a desktop one.
But the error 'ACPI Exception (acpi_processor-0680): AE_NOT_FOUND,
Processor Device
is not present [20060707]' makes me feel there is a error in the kernel=
=2E
> Sorry I can't give you more precise directions...
>
> Cheers,
>
>
>


--=20
warm regards

Balaji Rao
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
