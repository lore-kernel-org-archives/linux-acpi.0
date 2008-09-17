From: "Phil Endecott" <phil_hmpau_endecott@chezphil.org>
Subject: Re: Toggling VGA out on Eee 901
Date: Wed, 17 Sep 2008 20:31:04 +0100
Message-ID: <1221679864736@dmwebmail.dmwebmail.chezphil.org>
References: <71cd59b00809170813hba237e8y2bb3b4b2e7604d04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:3521 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756AbYIQTbI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 15:31:08 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_hmpau_endecott@chezphil.org>)
	id 1Kg2jy-0006A0-HB
	for linux-acpi@vger.kernel.org; Wed, 17 Sep 2008 20:31:06 +0100
In-Reply-To: <71cd59b00809170813hba237e8y2bb3b4b2e7604d04@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Corentin Chary wrote:
> you can try the "disp" file under /sys/device/platform/eeepc-laptop/
> Try echo 1, echo 0, etc ... It may do something

Thanks for the suggestion.  It doesn't work, though I think it's trying 
to do something.  The code for the "disp" file checks a capabilities 
bitmask in which I think the DISPLAYSWITCH bit is set, and writes call 
a method called SDSP, which eventually seems to do an I/O byte write (I 
think).  I'm well out of my depth here so I'm going to move on to the 
next problem, but I'm willing to try out any suggestions that people have.

Cheers,  Phil



