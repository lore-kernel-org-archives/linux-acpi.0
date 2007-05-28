From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: RTC_DRV_CMOS can break userspace interface
Date: Mon, 28 May 2007 20:16:11 +0100
Message-ID: <20070528191611.GA3462@srcf.ucam.org>
References: <20070527190351.GA21387@srcf.ucam.org> <20070527233911.GA23491@srcf.ucam.org> <20070528003822.GA23759@srcf.ucam.org> <200705271844.54589.david-b@pacbell.net> <20070528021622.GA24517@srcf.ucam.org> <loom.20070528T094140-471@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:51508 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXE1TQR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2007 15:16:17 -0400
Content-Disposition: inline
In-Reply-To: <loom.20070528T094140-471@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthieu CASTET <castet.matthieu@free.fr>
Cc: linux-acpi@vger.kernel.org

On Mon, May 28, 2007 at 07:45:33AM +0000, Matthieu CASTET wrote:

> Did you check if there aren't multiple configuration for rtc (one with irq, and
> one without it) ?

Yup. The options file is empty, and the resources file doesn't contain 
an IRQ.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
