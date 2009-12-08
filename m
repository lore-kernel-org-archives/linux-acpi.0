From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] Toshiba Bluetooth enabler (rfkill)
Date: Tue, 8 Dec 2009 21:30:39 +0000
Message-ID: <9b2b86520912081330s18b692d5me712dba0fa9b4c82@mail.gmail.com>
References: <4B192D08.9080608@gmail.com>
	 <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com>
	 <20091208125530.GA23520@srcf.ucam.org> <4B1E7481.6020902@gmail.com>
	 <20091208154738.GC26435@srcf.ucam.org> <4B1E75AE.5050901@gmail.com>
	 <20091208155103.GA27118@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:57733 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966216AbZLHVad (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 16:30:33 -0500
In-Reply-To: <20091208155103.GA27118@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jes Sorensen <jes.sorensen@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lenb@kernel.org

On 12/8/09, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Dec 08, 2009 at 04:50:06PM +0100, Jes Sorensen wrote:
>
>> Understand, not sure how to go about this. It doesn't seem to generate
>> an APIC event on off, it just pulls the USB device out of it's plug. Not
>> sure if it would be possible to plug into the USB unplug event?
>
> In principle, I guess, but I don't think there's a great deal of
> advantage in it.

Agreed.  I think the rfkill device would be a nice-to-have for
troubleshooting, but nothing more.  If you can't implement it using
ACPI events alone, it seems less useful for troubleshooting anyway.

Regards
Alan
