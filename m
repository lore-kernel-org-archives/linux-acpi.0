From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Fri, 27 Nov 2009 21:58:15 +0000
Message-ID: <20091127215815.GA9173@srcf.ucam.org>
References: <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258312767.545625.1812.1000@eeekiste> <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com> <cone.1259253925.112628.13921.1000@eeekiste> <20091126164856.GA19208@srcf.ucam.org> <cone.1259320879.557715.3035.1000@eeekiste> <4B0FB7B9.9040902@tuffmail.co.uk> <cone.1259324857.296100.3035.1000@eeekiste> <20091127172522.GA5422@srcf.ucam.org> <cone.1259353583.101492.2926.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:32830 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbZK0V6U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2009 16:58:20 -0500
Content-Disposition: inline
In-Reply-To: <cone.1259353583.101492.2926.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

On Fri, Nov 27, 2009 at 09:26:23PM +0100, andrej.gelenberg@udo.edu wrote:

> The eepc-latop-rfkill should be hard block. If the LED is not on,
> my wlan-card won't transmit. The eeepc-laptop is only driver
> which use hotplug-subsystem to hide the hardware.

No. The *hardware* disables the PCI device, at which point all reads 
return errors and drivers fall over. The eeepc-laptop driver then hides 
the device because it's no longer there.

Now, it's entirely possible that this behaviour is no longer present on 
the 1005h. That's fine, and it necessitates changing the behaviour of 
the driver. But it's not a reason for removing the functionality 
entirely, because the 700s, 900s and earlier 1000 series *do* require 
that PCI hotplugging be peformed.

(Well. There's a separate situation where the PCI runtime power 
management code is going to interfere with the way eeepc-laptop does 
things, and this functionality is going to need to be added to the PCI 
core and removed from eeepc-laptop)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
