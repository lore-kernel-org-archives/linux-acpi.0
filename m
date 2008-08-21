From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Thinkpad X60s power usage on battery - Windows/Linux comparison
Date: Thu, 21 Aug 2008 12:07:34 -0300
Message-ID: <20080821150734.GF11198@khazad-dum.debian.net>
References: <8ccf2e9c0808181554o930f235maa79bdb365cd808d@mail.gmail.com> <87bpzp231z.fsf@basil.nowhere.org> <8ccf2e9c0808201705v7d4edc81kde5b6b8e7090e335@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47584 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760231AbYHUPHj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Aug 2008 11:07:39 -0400
Content-Disposition: inline
In-Reply-To: <8ccf2e9c0808201705v7d4edc81kde5b6b8e7090e335@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vedran Rodic <vrodic@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

On Thu, 21 Aug 2008, Vedran Rodic wrote:
> Yeah, or they might not be wrong and my eyes could be :( It turns out
> that Windows can get the LCD brightness down more than thinkpad-acpi,
> or whatever is turning down the brightnes when I press the Fn-End
> combination (both in X and in the console - I guess it's the BIOS).

Intel embedded graphics?  You will need something that is not in the kernel
yet, but it is in the works (IGD ioregion support).

ThinkPad-acpi really can't to much more than what it is doing already,
AFAIK.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
