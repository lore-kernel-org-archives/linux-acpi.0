From: G L <glafranceweb@yahoo.com>
Subject: Re: Problem with s3 suspend to ram
Date: Mon, 28 Jan 2008 02:24:50 -0800 (PST)
Message-ID: <986804.87015.qm@web55214.mail.re4.yahoo.com>
Reply-To: G L <glafranceweb@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web55214.mail.re4.yahoo.com ([206.190.58.178]:31407 "HELO
	web55214.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751324AbYA1KYw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 05:24:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

Hello,

Today I tried the 2.6.24-5-generic.  Also, I tried to suspend/resume with two different SATA settings in the bios (IDE and Linux AHCI).
I also played with various settings in /etc/default/acpi-support. 

The problem is still there, but it's different.

Instead of getting:
ata1 soft reset failed
ata1 COMRESET failed

It does:
ata1 soft reset
failed ...[above line about 5 times]
then it says something like "giving up"


----- Original Message ----
From: Rafael J. Wysocki <rjw@sisk.pl>
To: G L <glafranceweb@yahoo.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; pm list <linux-pm@lists.linux-foundation.org>
Sent: Sunday, January 27, 2008 6:13:36 AM
Subject: Re: Problem with s3 suspend to ram

On Sunday, 27 of January 2008, G L wrote:
> Hello,

Hi,

> Thanks for replying!
>
> Well I updated Mythbuntu 7.10 to the latest kernel offered, which is 2.6.22-14-generic.

Please don't drop CCs in the next messages, thanks.

Would you be able to install a kernel.org kernel?

Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
