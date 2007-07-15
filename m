From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Sun, 15 Jul 2007 22:11:28 +0100
Message-ID: <20070715211128.GA6291@srcf.ucam.org>
References: <1184520879452-git-send-email-malattia@linux.it> <1184520879991-git-send-email-malattia@linux.it> <11845208793336-git-send-email-malattia@linux.it> <11845208793678-git-send-email-malattia@linux.it> <11845208794064-git-send-email-malattia@linux.it> <11845208791511-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:56667 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbXGOVLg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 17:11:36 -0400
Content-Disposition: inline
In-Reply-To: <11845208791511-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Jul 16, 2007 at 02:34:37AM +0900, Mattia Dongili wrote:
> +		/* we emit the scancode so we can always remap the key */
> +		input_event(kp.dev, EV_MSC, MSC_SCAN, event);

As I said to Henrique, I don't think this is the right solution. We know 
what these keys do - we should send the appropriate keycode, rather than 
asking userspace to remap it.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
