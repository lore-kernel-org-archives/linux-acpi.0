From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Tue, 20 Feb 2007 15:18:13 +0000
Message-ID: <20070220151813.GA6581@srcf.ucam.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com> <20070218183805.5a4fd813.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:42071 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965015AbXBTPSe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Feb 2007 10:18:34 -0500
Content-Disposition: inline
In-Reply-To: <20070218183805.5a4fd813.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Sun, Feb 18, 2007 at 06:38:05PM +0100, Jean Delvare wrote:

> ACPI is broken here, not k8temp, so let's fix ACPI instead. ACPI
> doesn't conflict with only k8temp, but with virtually all hardware
> monitoring drivers, all I2C/SMBus drivers, and probably other types of
> drivers too. We just can't restrict or blacklist all these drivers
> because ACPI misbehaves.

No, the simple fact of the matter is that if you're running on an ACPI 
platform you need to change some of your assumptions. ACPI owns the 
hardware. The OS doesn't. To an extent this has always been true on 
laptops and servers /anyway/ - the BIOS is free to have a wide variety 
of SMM insanity that invalidates basic assumptions like "If I hold this 
lock, nothing can interrupt me between this write and this read". That's 
simply not true.

So this isn't about fixing ACPI. It's about trying to find a mechanism 
that allows ACPI and raw hardware drivers to coexist, which is made 
somewhat harder by it not being a situation that the platform designers 
have considered in the slightest. The suggested low-level driver for 
io-port arbitration would certainly be a step forward in making this 
work better.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
