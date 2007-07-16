From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and
	getkeycode key table.
Date: Mon, 16 Jul 2007 18:06:05 +0100
Message-ID: <1184605565.2228.57.camel@work>
References: <1184520879452-git-send-email-malattia@linux.it>
	 <1184520879991-git-send-email-malattia@linux.it>
	 <11845208793336-git-send-email-malattia@linux.it>
	 <11845208793678-git-send-email-malattia@linux.it>
	 <11845208794064-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
	 <20070715211128.GA6291@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:39298 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbXGPRJi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 13:09:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1021327ugf
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 10:09:36 -0700 (PDT)
In-Reply-To: <20070715211128.GA6291@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sun, 2007-07-15 at 22:11 +0100, Matthew Garrett wrote:
> On Mon, Jul 16, 2007 at 02:34:37AM +0900, Mattia Dongili wrote:
> > +		/* we emit the scancode so we can always remap the key */
> > +		input_event(kp.dev, EV_MSC, MSC_SCAN, event);
> 
> As I said to Henrique, I don't think this is the right solution. We know 
> what these keys do - we should send the appropriate keycode, rather than 
> asking userspace to remap it.

We don't - the decal on FnF2 changes between different models, and I'm
sure others are the same.

Richard.


