From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: the role of the dstd
Date: Wed, 13 Sep 2006 19:10:30 +0100
Message-ID: <E1GNZBu-0007zu-00@skye.ra.phy.cam.ac.uk>
References: <9d90148c0609131004r5217843fiebcaf6f537f617e8@mail.gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:40446 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750800AbWIMSKc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Sep 2006 14:10:32 -0400
In-Reply-To: Your message of "Wed, 13 Sep 2006 12:04:07 CDT."
             <9d90148c0609131004r5217843fiebcaf6f537f617e8@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmagarza@gmail.com>
Cc: linux-acpi@vger.kernel.org

> Is this option "act like windows" really available? Is it a boot
> parameter?

It is.  Add these options to your boot parameters:

  acpi_os_name="Microsoft Windows" acpi_serialize

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
