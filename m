From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 16:02:01 +0000
Message-ID: <20091115160201.GC1019@srcf.ucam.org>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF7B8.2070508@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40106 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZKOQB5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 11:01:57 -0500
Content-Disposition: inline
In-Reply-To: <4AFFF7B8.2070508@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: andrej.gelenberg@udo.edu, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

On Sun, Nov 15, 2009 at 12:44:40PM +0000, Alan Jenkins wrote:

> Unfortunately, the BIOS doesn't tell us in advance which device it is  
> going to unplug.  Hence the hardcoded bus/slot.

Mm. Thinking about it, it does - it's sending a bus check notification, 
which means we're supposed to look at children of the device it 
notifies. Shouldn't be a difficult fix.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
