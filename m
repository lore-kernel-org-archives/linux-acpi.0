From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 18:27:35 +0000
Message-ID: <20091115182735.GA3585@srcf.ucam.org>
References: <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF7B8.2070508@tuffmail.co.uk> <20091115160201.GC1019@srcf.ucam.org> <4B00283C.3040807@tuffmail.co.uk> <20091115161458.GA1653@srcf.ucam.org> <20091115181631.GB3013@srcf.ucam.org> <cone.1258309336.428593.1656.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56042 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZKOS1c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 13:27:32 -0500
Content-Disposition: inline
In-Reply-To: <cone.1258309336.428593.1656.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

On Sun, Nov 15, 2009 at 07:22:16PM +0100, andrej.gelenberg@udo.edu wrote:
> Matthew Garrett writes:
>> Though, thinking about it, you're right - we still need to know whether 
>> it was a wifi device so we know whether to update the rfkill status. Do 
>> Atheros devices still have their PCI class set to ethernet rather than  
>> wireless?
>
> cat /sys/bus/pci/devices/0000\:02\:00.0/class
> 0x028000

Unfortunately it's 0x020000 on some earlier Eees, so that's not going to 
work. I'd be almost inclined to just leave eeepc-laptop as is, and write 
a new driver for the systems with the new interface.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
