From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Mon, 28 Jun 2010 22:12:53 +0200
Message-ID: <4C290245.2040001@suse.cz>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz> <4C27E965.80508@gmail.com> <4C283D84.6080504@suse.cz> <20100628171410.GA27367@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51301 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab0F1UNB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jun 2010 16:13:01 -0400
In-Reply-To: <20100628171410.GA27367@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

On 06/28/2010 07:14 PM, Matthew Garrett wrote:
> On Mon, Jun 28, 2010 at 08:13:24AM +0200, Jiri Slaby wrote:
>> On 06/28/2010 02:14 AM, Robert Hancock wrote:
>>> That seems a rather serious DSDT flaw. Do devices in that slot work in
>>> Windows?
>>
>> Yes, the DSDT is pretty broken this way there. Regarding Windows, I
>> don't know and I doubt anybody will ever try.
> 
> http://www-07.ibm.com/hk/products/pos/300/specs.html indicates that 
> Windows is supported on this hardware. It would be good to verify that 
> it also fails before we try a model-specific quirk.

It would be good for what? I don't see the point, DSDT is broken on that
machine and the patch works this around. Why do we need testruns from
Windows? And why you think Windows will fail anyway, they can very have
the pretty same quirk there.

-- 
js
suse labs
