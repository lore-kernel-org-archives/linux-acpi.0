From: Joschka Sulzer <joschkasulzer@aol.com>
Subject: Re: ACPI-Problems with debian-etch & Kernel 2.6.16
Date: Tue, 28 Mar 2006 19:39:52 +0200
Message-ID: <442974E8.5000403@aol.com>
References: <E1FO4hA-0000e4-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imo-d20.mx.aol.com ([205.188.139.136]:18929 "EHLO
	imo-d20.mx.aol.com") by vger.kernel.org with ESMTP id S1751203AbWC1Rks
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 12:40:48 -0500
In-Reply-To: <E1FO4hA-0000e4-00@skye.ra.phy.cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sanjoy@mrao.cam.ac.uk
Cc: linux-acpi@vger.kernel.org

sanjoy@mrao.cam.ac.uk schrieb:
>> These messages appear every 10 seconds!
>>     
>
> Do you have thermal polling turned on?
>
> more /proc/acpi/thermal_zone/*/polling_frequency
>
> Not that you should turn the polling off, but maybe every time a
> thermal poll is run, the embedded controller (ec) does an UPDT, which
> also means it looks at the battery state.  And maybe the UPDT causes
> the namespace AE_NOT_FOUND.  Perhaps it didn't cause a problem before
> because the default used to be ec_intr=0, and the ec worked fine with
> that setting.
>
> You could try booting with ec_intr=0 to see if it suppresses the
> problem.
>
> I've spent a while (see bugzilla #5989) debugging the consequences of
> changing the default from ec_intr=0 to ec_intr=1 (which happened in
> 2.6.16-rc* sometime -- see the #5989 bugzilla entries for the exact
> git commit id).  Probably it's a good change in general -- I leave
> that to the experts -- but it has certainly exposed a few troubles in
> the mangy BIOS on my TP 600X.
>   

I don't care anymore; updating to 2.6.16 solved my problems ;-)
Now the Kernel boots without any Kernelparameters at all !

