From: Hernan G Solari <hgsolari@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Tue, 02 Oct 2007 07:44:14 -0300
Message-ID: <470220FE.2090506@gmail.com>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com> <47014740.5080002@df.uba.ar> <4701EA71.2000609@gmail.com>
Reply-To: hgsolari@gmail.com, solari@df.uba.ar
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:47435 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbXJBKnI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 06:43:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3585631wxd
        for <linux-acpi@vger.kernel.org>; Tue, 02 Oct 2007 03:43:08 -0700 (PDT)
In-Reply-To: <4701EA71.2000609@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>


>>   netconsole, pritty nice debunging system... but (yes, there is alw=
ays
>>a but) it does not get to run.
>>   the method was well implemented, adding the acpi=3Doff it sends th=
e
>>information to the receiving machine (I can even see passing a
>>netconsole probing message in the machine under testing), but without
>>turning off acpi it does not reach the point of loading and,
>>consequently, it does not send a byte to the receiving machine.
>>
>>Hence, result: empty output.
>>   =20
>>
>
>Hmmm.. Are netconsole support and network driver built into the kernel=
?
>
> =20
>
yes, they are
                      Hernan

--=20
Hern=E1n Gustavo Solari, solari@df.uba.ar, http://www.df.uba.ar/~solari

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
