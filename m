From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: "acpi_apic_instance=2" works better
Date: Thu, 1 Jul 2010 16:01:09 +0100
Message-ID: <20100701150109.GB1061@srcf.ucam.org>
References: <AANLkTikdLXKwmD8LmIR0YJNmWTUiuVIit8TwJMrMeUP4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59704 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0GAPBO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jul 2010 11:01:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikdLXKwmD8LmIR0YJNmWTUiuVIit8TwJMrMeUP4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Serg Alexv." <agel.selena@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Jul 01, 2010 at 02:36:00PM +0400, Serg Alexv. wrote:
> "acpi_apic_instance=2" works just awesome (-:

What doesn't work without it?

> [    0.303948] ACPI Error (psparse-0537): Method parse/execution
> failed [\_SB_.PCI0._OSC] (Node f7013270), AE_NOT_FOUND

Could you provide the full dmesg output and the output of the acpidump 
command (found in the pmtools package)?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
