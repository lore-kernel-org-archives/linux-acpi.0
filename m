From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: FAN Processor and Thermap
Date: Sun, 12 Apr 2009 10:37:48 -0600
Message-ID: <51f3faa70904120937y262855b4k90f466b72ca4da9d@mail.gmail.com>
References: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
	 <49DFE506.8040307@gmail.com>
	 <335b7d740904120419x548018caqd7f41c5b24639bec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:24968 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZDLQht convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 12:37:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1885932ywb.1
        for <linux-acpi@vger.kernel.org>; Sun, 12 Apr 2009 09:37:48 -0700 (PDT)
In-Reply-To: <335b7d740904120419x548018caqd7f41c5b24639bec@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

On Sun, Apr 12, 2009 at 5:19 AM, Ken Perl <kenperl@gmail.com> wrote:
> I entered the bios but don't find a option to enable/disable ACPI. th=
e
> dmesg output is below,
>
> [ =A0 =A00.000000] Initializing cgroup subsys cpuset
> [ =A0 =A00.000000] Initializing cgroup subsys cpu
> [ =A0 =A00.000000] Linux version 2.6.26-1-686 (Debian 2.6.26-13lenny2=
)
> (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian
> 4.1.2-25)) #1 SMP Fri Mar 13 18:08:45 UTC 2009
> [ =A0 =A00.000000] BIOS-provided physical RAM map:
> [ =A0 =A00.000000] =A0BIOS-e820: 0000000000000000 - 000000000009f800 =
(usable)
> [ =A0 =A00.000000] =A0BIOS-e820: 000000000009f800 - 00000000000a0000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000000f0c00 - 0000000000100000 =
(reserved)
> [ =A0 =A00.000000] =A0BIOS-e820: 0000000000100000 - 0000000008000000 =
(usable)
> [ =A0 =A00.000000] =A0BIOS-e820: 00000000ffff0c00 - 0000000100000000 =
(reserved)
> [ =A0 =A00.000000] 0MB HIGHMEM available.
> [ =A0 =A00.000000] 128MB LOWMEM available.
> [ =A0 =A00.000000] Entering add_active_range(0, 0, 32768) 0 entries o=
f 256 used
> [ =A0 =A00.000000] Zone PFN ranges:
> [ =A0 =A00.000000] =A0 DMA =A0 =A0 =A0 =A0 =A0 =A0 0 -> =A0 =A0 4096
> [ =A0 =A00.000000] =A0 Normal =A0 =A0 =A0 4096 -> =A0 =A032768
> [ =A0 =A00.000000] =A0 HighMem =A0 =A0 32768 -> =A0 =A032768
> [ =A0 =A00.000000] Movable zone start PFN for each node
> [ =A0 =A00.000000] early_node_map[1] active PFN ranges
> [ =A0 =A00.000000] =A0 =A0 0: =A0 =A0 =A0 =A00 -> =A0 =A032768
> [ =A0 =A00.000000] On node 0 totalpages: 32768
> [ =A0 =A00.000000] =A0 DMA zone: 32 pages used for memmap
> [ =A0 =A00.000000] =A0 DMA zone: 0 pages reserved
> [ =A0 =A00.000000] =A0 DMA zone: 4064 pages, LIFO batch:0
> [ =A0 =A00.000000] =A0 Normal zone: 224 pages used for memmap
> [ =A0 =A00.000000] =A0 Normal zone: 28448 pages, LIFO batch:7
> [ =A0 =A00.000000] =A0 HighMem zone: 0 pages used for memmap
> [ =A0 =A00.000000] =A0 Movable zone: 0 pages used for memmap
> [ =A0 =A00.000000] DMI not present or invalid.
> [ =A0 =A00.000000] ACPI Error (tbxfroot-0218): A valid RSDP was not f=
ound [20080321]

This looks like a 440LX chipset, that's pretty old. Are you sure this
board supports ACPI at all?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
