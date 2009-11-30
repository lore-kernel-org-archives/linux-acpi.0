From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: ACPI Exception...
Date: Mon, 30 Nov 2009 12:51:54 +0000
Message-ID: <9b2b86520911300451s63ddc589seb66f3dee48b0cbd@mail.gmail.com>
References: <20091126193221.3ed8cbf0@tux.DEF.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43304 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZK3Mvs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2009 07:51:48 -0500
In-Reply-To: <20091126193221.3ed8cbf0@tux.DEF.witbe.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Rolland <rol@witbe.net>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

On 11/26/09, Paul Rolland <rol@witbe.net> wrote:
> Hello,
>
> I'm seeing the following messages in my logs :
>
> Nov 26 19:26:27 tux kernel: ACPI Exception: AE_TIME, Returned by Handler for
> [EmbeddedControl] (20090903/evregion-424)
> Nov 26 19:26:27 tux kernel: ACPI Error (psparse-0537): Method
> parse/execution failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node ffff88013f8182e0),
> AE_TIME
> Nov 26 19:26:27 tux kernel: ACPI Exception: AE_TIME, Evaluating _BST
> (20090903/battery-393)
>
> Is there anything I can do to provide more informations ?
>
> Regards,
> Paul

Your kernel version would be a good start :-).

The Embedded Controler driver has seen a series of fixes over time.
This error may be fixed for you in the upcoming 2.6.32 release.  So
you could try testing a release candidate.

It would also be good to tell us the vendor and model of the laptop.

Thanks
Alan
