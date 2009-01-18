From: Stephen Gildea <stepheng+linux@gildea.com>
Subject: Re: [PATCH RFT] fujitsu-laptop: Use RFKILL support bitmask from firmware
Date: Sun, 18 Jan 2009 02:29:58 -0500
Message-ID: <6054.1232263798@ma.gildea.net>
References: <20090118015303.DF36D10077@gold.linx.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phobia.gildea.net ([63.193.242.231]:2622 "EHLO mail.gildea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458AbZARHbO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 02:31:14 -0500
Received: from owl.ma.gildea.net (c-24-61-40-140.hsd1.ma.comcast.net [24.61.40.140])
	by mail.gildea.net (8.12.11/8.12.11) with ESMTP id n0I7VAP2005943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2009 23:31:13 -0800 (PST)
	(envelope-from stepheng+linux@gildea.com)
In-Reply-To: Message from tony@linx.net of 18 Jan 2009 01:53:03 GMT
    <20090118015303.DF36D10077@gold.linx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Peter Gruber <nokos@gmx.net>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

The /sys/devices/platform/fujitsu-laptop/{dock,radios,lid} files
still work on my P8010.  I applied this patch to 2.6.29-rc2.

Tested-by: Stephen Gildea <stepheng+linux@gildea.com>
