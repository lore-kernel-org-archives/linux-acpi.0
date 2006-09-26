From: Peter Pregler <Peter_Pregler@email.com>
Subject: Re: S3 on acer travelmate 3022WTMi
Date: Tue, 26 Sep 2006 21:01:11 +0200
Message-ID: <efbtdo$s4f$1@sea.gmane.org>
References: <966a04530609260106y2bea58del50732ba061cdc9a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:27018 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932476AbWIZTK0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 15:10:26 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GSIJe-0007qQ-8M
	for linux-acpi@vger.kernel.org; Tue, 26 Sep 2006 21:10:03 +0200
Received: from 85-124-175-159.dynamic.xdsl-line.inode.at ([85.124.175.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2006 21:10:02 +0200
Received: from Peter_Pregler by 85-124-175-159.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2006 21:10:02 +0200
In-Reply-To: <966a04530609260106y2bea58del50732ba061cdc9a9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Arto Pastinen wrote:
> Hi,
> 
> Has anyone got Suspend to Ram work on Acer TravelMate 3022WTMi?
> 
> I even fixed DSDT, but it still freezes on return from sleep, the hard
> disc shows little action, but then everything is blank..

I think this describes the problem with all Acer TM 3xxx. I have a
TM3201 and have the same problem. Additional symptons: display backlight
is off, fan is running. I tried about all the tricks including all
debugging that is possible without a serial console with no success.
And since I have no docking station, i.e. no chance for a serial
console, I simply gave up.

-Peter

