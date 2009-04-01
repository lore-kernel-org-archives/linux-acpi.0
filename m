From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH 2/2] toshiba-acpi: Support TOS1900-type devices
Date: Thu, 2 Apr 2009 09:50:59 +1700
Message-ID: <74962ea30904010950u31fbdca3w51eafb9b7ec1ca73@mail.gmail.com>
References: <20090331214501.GC29489@srcf.ucam.org>
	 <20090331214749.GD29489@srcf.ucam.org>
	 <74962ea30903311506m41306659td0cd70c5736f6660@mail.gmail.com>
	 <20090331221107.GA30383@srcf.ucam.org>
	 <74962ea30903311519s2fb6087fxfe8859e3c570ac99@mail.gmail.com>
	 <20090331230217.GA31599@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:60978 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbZDAQvC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 12:51:02 -0400
In-Reply-To: <20090331230217.GA31599@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org

On Wed, Apr 1, 2009 at 4:02 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> Ok, can you try this and let me know what codes it generates (if it
> generates any)? It should go on top of the previous patches.

Nothing gets generated, even if I change the method to ".INFO" and hotkey
events enabled with hci_write2(HCI_HOTKEY_EVENT, 1, 1, &hci_result) and
TECF set to 1 (see my DSDT).

I was playing with the code yesterday trying to get some events reported, but no
luck so far.

It appears that TOHK variable is _volatile_ and it just stores hotkey events
temporarily and they don't get _stored_ like in the System Event FIFO.

On the patches I sent to the omnibook module I'm able to get events but they
seem to get repeated 3 times, or perhaps I'm polling to often.


Saludos
Azael


-- 
-- El mundo apesta y vosotros apestais tambien --
