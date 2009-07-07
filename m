From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [stable] [PATCH] PNPACPI: Enable PNPACPI _PSx Support, v3
Date: Tue, 07 Jul 2009 22:06:41 +0200
Message-ID: <4A53AAD1.1050308@gmx.net>
References: <49D101DA.50201@gmx.net> <200904021510.37517.trenn@suse.de> <20090630230314.GD2634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42135 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755185AbZGGUGu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jul 2009 16:06:50 -0400
In-Reply-To: <20090630230314.GD2634@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Thomas Renninger <trenn@suse.de>, stable@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, abelay@mit.edu, bjorn.helgaas@hp.com

Greg KH wrote:

[snip]

> 
> What specific git commit id in Linus's tree is this?
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

the git commit id of this patch would be 
6328a57401dc5f5cf9931738eb7268fcd8058c49, but the patch triggered a 
regression which is described in 
http://bugzilla.kernel.org/show_bug.cgi?id=13243 and which was fixed in 
19bde778c1fd2574cc020a618d7d576f260271ca.

Hope this helps.


--- Witold
