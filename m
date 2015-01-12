From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] ACPI on arm64 TODO List
Date: Mon, 12 Jan 2015 20:55:31 +0100
Message-ID: <6510884.pqfMoSc7Kv@wuerfel>
References: <548F9668.6080900@linaro.org> <CACxGe6ub0UsUNs1-2NziK_sGEtpxTjcDD+Eto3YOsNkvWxaNcw@mail.gmail.com> <20150112193905.GB5281@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52827 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425AbbALTzo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jan 2015 14:55:44 -0500
In-Reply-To: <20150112193905.GB5281@amd>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, Al Stone <al.stone@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Olof Johansson <olof@lixom.net>

On Monday 12 January 2015 20:39:05 Pavel Machek wrote:
> 
> Ok, so what is the primary reason? As far as I could tell it is
> "Microsoft wants ACPI" and "hardware people want Microsoft" and
> "fragmentation is bad so we do ACPI" (1) (and maybe "someone at RedHat
> says they want ACPI" -- but RedHat people should really speak for
> themselves.)

I can only find the first two in Grant's document, not the third one,
and I don't think it's on the table any more. The argument that was
in there was that for a given platform that wants to support both
Linux and Windows, they can use ACPI and Linux should work with that,
but that is different from "all servers must use ACPI", which would
be unrealistic.

	Arnd
