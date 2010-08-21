From: Lin Ming <lin@ming.vg>
Subject: Re: 2.6.36-rc1-git3 - ACPI Warning: Incorrect checksum in table
 [OEMB] - 0x9C, should be 0x9F (20100702/tbutils-314)
Date: Sat, 21 Aug 2010 16:24:46 +0000
Message-ID: <AANLkTin4oE-bmXOWzboTccBda1mwY1=Ob56CByb=rg=m@mail.gmail.com>
References: <AANLkTinva4FS2oonhQSWr25WsRr1M0hOmrGH9penkrbK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50224 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0HUQYr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Aug 2010 12:24:47 -0400
In-Reply-To: <AANLkTinva4FS2oonhQSWr25WsRr1M0hOmrGH9penkrbK@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sat, Aug 21, 2010 at 6:27 AM, Miles Lane <miles.lane@gmail.com> wrote:
> Ran "find /sys | xargs tail" and my system locked up.
>
> ACPI Warning: Incorrect checksum in table [OEMB] - 0x9C, should be

This is harmless.
Anyway, would you please attach the acpidump output?

Lin Ming
-- 
Intel Open Source Technology Center
ming.m.lin@intel.com
