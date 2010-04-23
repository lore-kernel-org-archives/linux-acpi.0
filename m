From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Fri, 23 Apr 2010 13:24:30 +0200
Message-ID: <1272021870.29664.109.camel@pancake.fritz.box>
References: <1271762498.1537.215.camel@pancake>
	 <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com>
	 <1271853961.1537.1781.camel@pancake> <20100421133305.GA28710@srcf.ucam.org>
	 <1271860206.1537.1914.camel@pancake> <20100421143239.GA484@srcf.ucam.org>
	 <1271924488.3790.25.camel@flunder> <20100422133605.GA31680@srcf.ucam.org>
	 <1271944219.29664.42.camel@pancake.fritz.box>
	 <20100422135336.GA31984@srcf.ucam.org>
	 <20100422140518.GA32558@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100422140518.GA32558@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Am Donnerstag, den 22.04.2010, 15:05 +0100 schrieb Matthew Garrett:
> Hm. Yeah, that looks pretty messed up. I think you'd be justified in 
> just changing that entry yourself, to be honest, and then see if that 
> makes things behave more usefully.
You mean, change the initial value for ERQ0 in the DSDT and load that
through the kernel? I'll try that. I'll also try a BIOS update and see
if there's a little more sense in the DSDT afterwards..

Florian
-- 
0666 - Filemode of the Beast

