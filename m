From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: RTC_DRV_CMOS can break userspace interface
Date: Mon, 28 May 2007 00:39:11 +0100
Message-ID: <20070527233911.GA23491@srcf.ucam.org>
References: <20070527190351.GA21387@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:52739 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbXE0XjU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 May 2007 19:39:20 -0400
Content-Disposition: inline
In-Reply-To: <20070527190351.GA21387@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: david-b@pacbell.net

On Sun, May 27, 2007 at 08:03:51PM +0100, Matthew Garrett wrote:

> (It doesn't really help that rtc-cmos doesn't load on this machine, but 
> I'll try to track that down later - right now I suspect some sort of PNP 
> issue)

Ah, no, it's because the ioports for the rtc-cmos driver are already 
claimed by the old driver from CONFIG_RTC. The following configuration 
is valid in Kconfig:

CONFIG_RTC=y
CONFIG_RTC_CMOS=m

but will disable /proc/acpi/wakeup. It'll also be impossible to load 
CONFIG_RTC_CMOS because CONFIG_RTC has grabbed the io ports, so it's not 
possible to use the new interface. This situation doesn't appear to be 
documented, which is less than ideal...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
