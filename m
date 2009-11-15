From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 18:56:22 +0000
Message-ID: <20091115185622.GA3810@srcf.ucam.org>
References: <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF61E.6090707@tuffmail.co.uk> <cone.1258301205.852230.1663.1000@eeekiste> <4B002951.4080704@tuffmail.co.uk> <cone.1258304218.643429.1671.1000@eeekiste> <4B00354A.7000300@tuffmail.co.uk> <71cd59b00911150917k7d677fd0g509ab4edc1786fb1@mail.gmail.com> <cone.1258306366.446137.1656.1000@eeekiste> <4B003DDA.5020508@tuffmail.co.uk> <71cd59b00911151031h2e0e768dgedb22cee9979c04b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44911 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZKOS4T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 13:56:19 -0500
Content-Disposition: inline
In-Reply-To: <71cd59b00911151031h2e0e768dgedb22cee9979c04b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, andrej.gelenberg@udo.edu, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 15, 2009 at 07:31:55PM +0100, Corentin Chary wrote:

> There is new wmi interface, without any documentation of course.
> Even Xandros had not been aware of that.
> You can find a dsdt with that here :
> http://dev.iksaif.net/attachments/download/83/eeepc_1000h_2204.dsl.gz
> Search "ASUSWMI".

Looks easy enough to implement. From the hotkey perspective, it seems 
that you'll get a notification on the WMI device and get the event from 
the WMI event data. The rest of the programming model looks pretty 
similar to the old interface.

The slightly odd thing is that there's no bus check notifications sent 
for the 1005, so we should never be running the hotplug code to begin 
with at runtime - looks like the only case we'll cover is on suspend and 
resume. On the other hand, I've just realised that this is likely to go 
horribly wrong with the PCI runtime power management code. It may 
actually be possible to make the eee stuff generic after all, but that's 
going to take a small amount of work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
