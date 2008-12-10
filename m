From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [PATCH] PNPACPI: Enable Power Support
Date: Wed, 10 Dec 2008 20:30:49 +0100
Message-ID: <494018E9.2060507@gmx.net>
References: <493D8A1F.2090907@gmx.net> <20081210095315.GA20627@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45437 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755503AbYLJTbI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2008 14:31:08 -0500
In-Reply-To: <20081210095315.GA20627@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <abelay@mit.edu>, rjw@sisk.pl

Henrique de Moraes Holschuh wrote:

> On Mon, 08 Dec 2008, Witold Szczeponik wrote:
>> This patch sets the power of PnP ACPI devices to D0 when they
>> are activated and to D3 when they are disabled.  The latter is
> 
> This will likely fix my T43 to power down USB during STR. THANKS!!
> Now, I just need to check if the ACPI BIOS is smart enough to not do
> it when they are configured as wake devices [in the BIOS].
> 

Most likely it won't. :-(  My patch takes only care of devices that are
properly registered as PnP by ACPI: attached USB devices don't fall
under that category.

--- Witold

