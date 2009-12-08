From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Toshiba Bluetooth enabler (rfkill)
Date: Tue, 8 Dec 2009 15:47:38 +0000
Message-ID: <20091208154738.GC26435@srcf.ucam.org>
References: <4B192D08.9080608@gmail.com> <9b2b86520912080205x478b47eek2377dacdbe44a522@mail.gmail.com> <20091208125530.GA23520@srcf.ucam.org> <4B1E7481.6020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39028 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbZLHPrl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 10:47:41 -0500
Content-Disposition: inline
In-Reply-To: <4B1E7481.6020902@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jes Sorensen <jes.sorensen@gmail.com>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lenb@kernel.org

On Tue, Dec 08, 2009 at 04:45:05PM +0100, Jes Sorensen wrote:
> On 12/08/09 13:55, Matthew Garrett wrote:
>> The problem with that is that there's no event to indicate that the
>> switch has been turned back on, so there's no way to update the rfkill
>> core appropriately. Giving userspace potentially stale information
>> doesn't seem helpful.
>
> I believe I can call into BTST and determine whether the switch is set
> to on or not. It's quite easy to add this to the resume handler and only
> call if it's set to on.

Right, but in normal use it's an issue. Unless we get notifications for 
both types of state change, we can't add an rfkill device.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
