From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: drivers/acpi/ac.c, re-enabling CONFIG_ACPI_PROCFS_POWER?
Date: Thu, 19 Jun 2014 01:17:45 +0200
Message-ID: <1891948.UFv8RnVsZc@vostro.rjw.lan>
References: <53A1F65C.9090907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53A1F65C.9090907@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sorin Manolache <sorinm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Lan Tianyu <tianyu.lan@intel.com>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 18, 2014 10:28:12 PM Sorin Manolache wrote:
> Hello,
> 
> Would it be worth considering re-enabling the old procfs interface for 
> ac.c? There are old tools still around (kpowersave from kde 3.5.10) that 
> expect /proc/acpi/ac_adapter.

Can you please CC ACPI-related messages to linux-acpi@vger.kernel.org?

I'm not sure how much effort that would require at this point.  Rui, Tianyu?

Rafael
