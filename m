From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: Power-button event after resume from S3
Date: Thu, 06 Apr 2006 23:15:57 +0100
Message-ID: <E1FRclh-0005A4-00@skye.ra.phy.cam.ac.uk>
References: <1144354328.30190.32.camel@localhost.localdomain>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:55031 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751327AbWDFWP7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Apr 2006 18:15:59 -0400
In-Reply-To: Your message of "Thu, 06 Apr 2006 16:12:08 EDT."
             <1144354328.30190.32.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felix Kuehling <fkuehlin@ati.com>
Cc: linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>

> I am investigating a problem where acpid receives a power-button
> event immediately after resuming from S3. I looked at the mailing
> list archives and found that this problem is not entirely uncommon.

Yes, I noticed this problem once I turned on acpi_serialize and told
ACPI to pretend I'm running "Microsoft Windows".  Then the Fn key no
longer resumed from S3, and I had to slide the power switch, which
generated wakeup and powerbutton events -- so it woke up and then shut
down.  [this is with a TP 600X]

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
