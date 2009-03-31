From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH 2/2] toshiba-acpi: Support TOS1900-type devices
Date: Wed, 1 Apr 2009 15:06:12 +1700
Message-ID: <74962ea30903311506m41306659td0cd70c5736f6660@mail.gmail.com>
References: <20090331214501.GC29489@srcf.ucam.org>
	 <20090331214749.GD29489@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:54462 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbZCaWGQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Mar 2009 18:06:16 -0400
In-Reply-To: <20090331214749.GD29489@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, lenb@intel.com

Hi there,

On Wed, Apr 1, 2009 at 2:47 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> Despite toshiba_acpi exporting TOS1900 as a modalias, it doesn't appear to
> support these machines. They have their HCI method implemented in a
> different but compatible manner and so need a different method address.

Indeed, my Satellite X205-9800 uses that method, however, it only provides
HCI call 0x001E (Hotkey Events) and no System Event FIFO (0x0016),
instead, hotkeys are entered on a variable called TOHK (TOshiba HotKeys?).
Located in my model in

PCI0.LPCB.EC0.TOHK

and it appears that it can be _polled_ tru' method INFO
(TOSH_INTERFACE_2 ".INFO"),
perhaps a small change in the polling to reflect to that method for
TOS1900 devices would be necessary.


On my model the complete call would be:

\\_SB.VALZ.SPFC
\\_SB.VALZ.INFO

Is it different from \\_SB_.VALZ.SPFC or it simply doesn't matter?

Saludos
Azael



-- 
-- El mundo apesta y vosotros apestais tambien --
