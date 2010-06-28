From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Mon, 28 Jun 2010 08:13:24 +0200
Message-ID: <4C283D84.6080504@suse.cz>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz> <4C27E965.80508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4C27E965.80508@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-acpi@vger.kernel.org

On 06/28/2010 02:14 AM, Robert Hancock wrote:
> On 06/27/2010 03:21 PM, Jiri Slaby wrote:
>> On IBM Bartolo machines, cards in 00:09.0 are defunct (if use
>> interrupts). DSDT says that this slot (with function 0, i.e. pin A) is
>> routed to \_SB_.PCI0.PIB_.LNKB. But it's not, it's wired to LNKC, so
>> interrupts are misrouted. Add a quirk for this to workaround the
>> issue.
> 
> That seems a rather serious DSDT flaw. Do devices in that slot work in
> Windows?

Yes, the DSDT is pretty broken this way there. Regarding Windows, I
don't know and I doubt anybody will ever try.

regards,
-- 
js
suse labs
