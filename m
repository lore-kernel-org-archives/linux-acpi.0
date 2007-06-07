From: Richard Hughes <hughsient@gmail.com>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Thu, 07 Jun 2007 17:58:59 +0100
Message-ID: <1181235539.2610.72.camel@work>
References: <1180614979.2693.26.camel@localhost.localdomain>
	 <1180788652.2355.27.camel@localhost.localdomain>
	 <20070602142333.GA3452@srcf.ucam.org>
	 <200706030048.40393.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:28093 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbXFGQ7B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jun 2007 12:59:01 -0400
Received: by nf-out-0910.google.com with SMTP id g13so18269nfb
        for <linux-acpi@vger.kernel.org>; Thu, 07 Jun 2007 09:58:49 -0700 (PDT)
In-Reply-To: <200706030048.40393.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Bastien Nocera <hadess@hadess.net>, John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Sun, 2007-06-03 at 00:48 -0400, Dmitry Torokhov wrote:
> 
> 
> It looks like KEY_COFFE comes from 0x0c/0x19e - AL Terminal
> Lock/Screensaver
> so your interpretation is indeed correct. I guess I better add an
> alias to
> input.h

What's the status of this patch? Good for merging? Do you want me to
redo the current patch using input-polldev and the new setkeycode stuff?

Richard.

