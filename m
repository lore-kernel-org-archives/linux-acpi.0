From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Wed, 30 Jun 2010 11:40:55 +0200
Message-ID: <4C2B1127.50203@suse.cz>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz>	<4C27E965.80508@gmail.com>	<4C283D84.6080504@suse.cz>	<20100628171410.GA27367@srcf.ucam.org>	<4C290245.2040001@suse.cz>	<20100628204820.GA32503@srcf.ucam.org>	<AANLkTil-sdbojCXBp6sR_4xL3JIe6ZENqXuueB61VJ8c@mail.gmail.com>	<4C2A3E27.4060407@suse.cz> <AANLkTimkElR1u-iRyFfCEQR5VTZvcyEIGQodfmFNtbC_@mail.gmail.com> <4C2B0C73.9050200@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:62049 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab0F3Jko (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2010 05:40:44 -0400
In-Reply-To: <4C2B0C73.9050200@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Robert Hancock <hancockrwd@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

On 06/30/2010 11:20 AM, Jiri Slaby wrote:
> I still no point in comparing this to Windows' setup. We can't find out
> whether it is quirked or better (without some bug) handled there.

Whatever, how can one find the interrupt links setup on windows?
Something like
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 9 10 *11 12)
etc.? Without that it doesn't make much sense.

regards,
-- 
js
suse labs
