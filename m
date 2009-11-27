From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Fri, 27 Nov 2009 17:25:22 +0000
Message-ID: <20091127172522.GA5422@srcf.ucam.org>
References: <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258312767.545625.1812.1000@eeekiste> <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com> <cone.1259253925.112628.13921.1000@eeekiste> <20091126164856.GA19208@srcf.ucam.org> <cone.1259320879.557715.3035.1000@eeekiste> <4B0FB7B9.9040902@tuffmail.co.uk> <cone.1259324857.296100.3035.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36290 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbZK0RZZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2009 12:25:25 -0500
Content-Disposition: inline
In-Reply-To: <cone.1259324857.296100.3035.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

On Fri, Nov 27, 2009 at 01:27:37PM +0100, andrej.gelenberg@udo.edu wrote:
> Hi,
>
> the problem is, when i press wlan-key, the hotplug-work is triggerd,
> but you can not say, which device to unplug.

That's because the eee firmware gives us no control over which device is 
unplugged. I think you're missing the point of how the eee rfkill code 
works - we don't unplug any devices, the firmware does that. We then 
need to tell Linux that the PCI device has vanished in order to prevent 
drivers from attempting to use a piece of hardware that's no longer 
accessible.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
