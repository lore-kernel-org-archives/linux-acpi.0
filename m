From: Stephen Gildea <stepheng+linux@gildea.com>
Subject: Re: [PATCH RFT] fujitsu-laptop: Add BL power, LED control and radio state information
Date: Tue, 30 Dec 2008 11:39:47 -0500
Message-ID: <20424.1230655187@ma.gildea.net>
References: <20081229185605.BF1DF10080@gold.linx.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phobia.gildea.net ([63.193.242.231]:4632 "EHLO mail.gildea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbYL3REu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 12:04:50 -0500
Received: from owl.ma.gildea.net (static.unknown.charter.com [75.128.3.30] (may be forged))
	by mail.gildea.net (8.12.11/8.12.11) with ESMTP id mBUGf8Mh062477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Tue, 30 Dec 2008 08:41:10 -0800 (PST)
	(envelope-from stepheng+linux@gildea.com)
In-Reply-To: Message from tony@linx.net of 29 Dec 2008 18:56:05 GMT
    <20081229185605.BF1DF10080@gold.linx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Peter Gruber <nokos@gmx.net>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

>    Stephen, please add a Tested-By header if this works right on
>    your P8010.

Patch applied to 2.6.28 base, works on my LifeBook P8010.  Builds
and installs with or without CONFIG_LEDS_CLASS.

Thanks for the new hardware support, Tony.

Signed-off-by: Stephen Gildea <stepheng+linux@gildea.com>
Signed-off-by: Tony Vroon <tony@linx.net>
Tested-by: Stephen Gildea <stepheng+linux@gildea.com>
