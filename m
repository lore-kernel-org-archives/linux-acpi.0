From: Jes Sorensen <jes.sorensen@gmail.com>
Subject: Re: [PATCH] Toshiba Bluetooth enabler (rfkill)
Date: Tue, 08 Dec 2009 16:50:06 +0100
Message-ID: <4B1E75AE.5050901@gmail.com>
References: <4B192D08.9080608@gmail.com> <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com> <20091208125530.GA23520@srcf.ucam.org> <4B1E7481.6020902@gmail.com> <20091208154738.GC26435@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:65172 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbZLHPtk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 10:49:40 -0500
In-Reply-To: <20091208154738.GC26435@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lenb@kernel.org

On 12/08/09 16:47, Matthew Garrett wrote:
> On Tue, Dec 08, 2009 at 04:45:05PM +0100, Jes Sorensen wrote:
>> I believe I can call into BTST and determine whether the switch is set
>> to on or not. It's quite easy to add this to the resume handler and only
>> call if it's set to on.
>
> Right, but in normal use it's an issue. Unless we get notifications for
> both types of state change, we can't add an rfkill device.
>

Understand, not sure how to go about this. It doesn't seem to generate
an APIC event on off, it just pulls the USB device out of it's plug. Not
sure if it would be possible to plug into the USB unplug event?

Cheers,
Jes

