From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_apic_instance=2
Date: Tue, 4 Dec 2007 14:07:57 -0500
Message-ID: <200712041407.57160.lenb@kernel.org>
References: <4755957B.2040607@doube.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42610 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbXLDTIM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Dec 2007 14:08:12 -0500
In-Reply-To: <4755957B.2040607@doube.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Doube <michael@doube.net>
Cc: linux-acpi@vger.kernel.org

On Tuesday 04 December 2007 12:59, Michael Doube wrote:
> Hello,
> 
> I saw this in my dmesg and tried it:
> 
> [    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
> [    0.000000] ACPI: If "acpi_apic_instance=2" works better, notify 
> linux-acpi@vger.kernel.org
> 
> And software (RAM) suspend seems to work a bit better.  I'll test it 
> some more and let you know.  At least, nothing overtly bad has happened 
> since I set acpi_apic_instance=2.
> 
> The machine is a Sony Vaio SZ650N, and I'm keen to get everything going 
> on it so let me know if I can help in any way.

please send me the output from acpidump.

thanks,
-len


> Major problem at the moment is that screen brightness control does not work.
> 
> Cheers
> 
> Mike
> 
