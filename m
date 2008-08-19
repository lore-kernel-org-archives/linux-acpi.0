From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Thinkpad X60s power usage on battery - Windows/Linux comparison
Date: Tue, 19 Aug 2008 03:42:32 +0200
Message-ID: <87bpzp231z.fsf@basil.nowhere.org>
References: <8ccf2e9c0808181554o930f235maa79bdb365cd808d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:51234 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbYHSBmf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Aug 2008 21:42:35 -0400
In-Reply-To: <8ccf2e9c0808181554o930f235maa79bdb365cd808d@mail.gmail.com> (Vedran Rodic's message of "Tue, 19 Aug 2008 00:54:58 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vedran Rodic <vrodic@gmail.com>
Cc: linux-acpi@vger.kernel.org

"Vedran Rodic" <vrodic@gmail.com> writes:
>
> Windows power monitoring tool from Lenovo reports power usage of 6.5 W under
> the same LCD brightness level and with wireless disabled.

It would be better if you compared using the same "neutral" method.

Most cheap power measurements tend to quite inaccurate and who
knows in which direction this Windows power monitoring tool is wrong.
It might be wrong in a different direction than what you used 
under Linux.

A reasonable accurate method might be to just measure the time how
long the battery lasts in both cases using a similar workload
(e.g. keeping it completely idle)

-Andi
