From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Automatic S1 sleep
Date: Tue, 11 May 2010 18:19:00 +0100
Message-ID: <20100511171900.GA17704@srcf.ucam.org>
References: <4BE97FC9.4040302@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37621 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab0EKRTG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2010 13:19:06 -0400
Content-Disposition: inline
In-Reply-To: <4BE97FC9.4040302@cfl.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-acpi@vger.kernel.org

On Tue, May 11, 2010 at 12:03:21PM -0400, Phillip Susi wrote:

> Unlike S3, S1 keeps the Vcc power plane on and all devices remain in D0
> or D1, so the screen remains on and visible, so it should be possible to
> use this state transparently without the user even being aware of it.
> Since everything remains on, no hardware needs reinitialized when
> resuming from S1.  Here seems to be a problem with the current kernel code:

You'll need wakeup events on mouse, keyboard, network packets and so on. 
Some of these are possible, some aren't really.

> Does anyone have any thoughts on my conclusion or advice on how to
> trigger S1 without generating PM_EVENT_SUSPEND?

Just have suspend_devices_and_enter conditionalise the device suspend on 
whether or not it's PM_SUSPEND_STANDBY.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
