From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 15:56:55 +0000
Message-ID: <20091115155655.GB1019@srcf.ucam.org>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57460 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbZKOP4u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 10:56:50 -0500
Content-Disposition: inline
In-Reply-To: <cone.1258285991.924736.2588.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

On Sun, Nov 15, 2009 at 12:53:11PM +0100, andrej.gelenberg@udo.edu wrote:

> Is it not better to use rfkill-switch provided from wlan-driver when? At  
> least Atheros drivers support rfkill propertly. You can make it LED for 
> that eeepcs and set the default trigger to rfkill. I have tried to make 
> it so, but on 1005ha it is a proper rfkill.

No. The platform is designed (for whatever reason) such that rfkill 
turns the device off and disassociates it from the PCI bus. Support for 
that is necessary.

> I have tried to make the devicesearch for hotplug propertly, but it cause
> the system freeze. (http://bugzilla.kernel.org/show_bug.cgi?id=14570#c1)

rt2860 is buggy.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
