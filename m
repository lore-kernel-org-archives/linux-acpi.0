From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SuperMicro X7DBE ACPI boot messages question
Date: Wed, 13 Jan 2010 19:09:22 -0600
Message-ID: <4B4E6EC2.2050403@gmail.com>
References: <hijl1v$r49$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:48473 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab0ANBJZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2010 20:09:25 -0500
Received: by yxe17 with SMTP id 17so23017062yxe.33
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2010 17:09:24 -0800 (PST)
In-Reply-To: <hijl1v$r49$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mike <mike-acpilist@tiedyenetworks.com>
Cc: linux-acpi@vger.kernel.org

On 01/12/2010 11:17 PM, mike wrote:
> Hello,
>
> I have a Supermicro X7DBE system. When it boots, the kernel dmesg output
> gives me:
>
> ACPI: DSDT cff60068 0445A (v01 Intel BLAKFORD 06040000 MSFT 03000001)
> ACPI: FACS cff65fc0 00040
> ACPI: APIC cff64536 000C8 (v01 PTLTD ? APIC 06040000 LTP 00000000)
> ACPI: MCFG cff645fe 0003C (v01 PTLTD MCFG 06040000 LTP 00000000)
>
>
> The '? APIC' line confuses me and I don't know what this means nor do I
> see anywhere it is documented what it means. The machine does work, but
> I have an odd problem with virtualbox and it's own apic handling when
> running on this machine and I am trying to run down wether the above is
> an actual problem on the host, or if it's a red herring. Does anyone
> have an idea what this could actually mean?

As far as I can see, the ? would be part of the ACPI OEM table ID field 
in the BIOS ACPI table. I doubt it's related to anything.
