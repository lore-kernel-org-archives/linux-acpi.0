From: Jes Sorensen <jes.sorensen@gmail.com>
Subject: Re: [PATCH] Toshiba Bluetooth enabler (rfkill)
Date: Tue, 08 Dec 2009 16:45:05 +0100
Message-ID: <4B1E7481.6020902@gmail.com>
References: <4B192D08.9080608@gmail.com> <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com> <20091208125530.GA23520@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:38666 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbZLHPpK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 10:45:10 -0500
In-Reply-To: <20091208125530.GA23520@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lenb@kernel.org

On 12/08/09 13:55, Matthew Garrett wrote:
> The problem with that is that there's no event to indicate that the
> switch has been turned back on, so there's no way to update the rfkill
> core appropriately. Giving userspace potentially stale information
> doesn't seem helpful.

I believe I can call into BTST and determine whether the switch is set
to on or not. It's quite easy to add this to the resume handler and only
call if it's set to on.

Cheers,
Jes
