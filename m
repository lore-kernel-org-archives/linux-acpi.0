From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 06/13] ACPI: updates rtc-cmos device platform_data
Date: Mon, 5 Feb 2007 17:07:34 -0800
Message-ID: <200702051707.35256.david-b@pacbell.net>
References: <200702060010.l160AEfC003735@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:27021 "HELO
	smtp108.sbc.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965430AbXBFBOR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 20:14:17 -0500
In-Reply-To: <200702060010.l160AEfC003735@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, len.brown@intel.com

By the way ... in case I was unclear about this, this does need to _follow_ the
patch defining the rtc-cmos driver and its platform data.  Which I'm sure it
does in the MM tree, as it does in my own patchsets.  :)

- Dave

