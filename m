Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4456E06F;
	Thu, 15 Oct 2026 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088717; cv=none; b=L9u+BWNcJJj26zI2Qok/+odooBKhxK+LSqwvfsWsGCWx5BB7aUgfONdJxoG0WtaVfbhDRtlvF5LhMuZ/mK0ILDl/i8lYxN7/ZAGaAB0YJnhnwMSW8sWBsNBhXVmpOhzodG/Rc90fFbqmMomC9V4dtoauUVdH3b45Dy6D5xF5Ln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088717; c=relaxed/simple;
	bh=8Q22xltorP1VAfdf0/11kX0FhYrB8cL0Z1mqGlN+qfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTA89XASP+NDQpBpIEOxpgbgfeom44bmO6RSO3X+tUz8Nvl5X9MuBlBTUmFrVx8/xaCgaBY0lGL0dc3ndn9RcGVR8gJkj63rKpkRVHOpYz55hAlyUZKgN2zMWP1OeNpwh3lLUxzvRK41uOZBK77xtxNgIxRs3Fr7in9WPk3U3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GzEKMZn6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GzEKMZn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792088712; x=1823624712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Q22xltorP1VAfdf0/11kX0FhYrB8cL0Z1mqGlN+qfQ=;
  b=GzEKMZn6dodIWlmD+bLT82pLGwEvpvlKr8plvyLBU3u4EnVusgFvUmAQ
   PP1yChvT96R6wY7xCiX1jOD1aOrjRBPhJPKJyIa/6k4vvX1VVFMBGHJbo
   +W8C8MagRcE4RQaCxa0525EcU0NTJa3h1ZfZ7xmRYJ+aSGq+CDFC9rpcY
   Uvnh2L1qjWX2l2DalgU+V8Hd7qjRVQ0CgpsHQKshzgZYjKl0wPCb7plzT
   fIqX/i2t/Ihv153BLh4frOhAJTxw6Q97SHIMHrWiKETw+QaBoNDxg77oV
   pmQF9mLUi7CEz2fsCbAozGySh55+f4Axgv741nUD4iWcEM5iTc8hMtp7j
   w==;
X-CSE-ConnectionGUID: 9Fc1qiHeQJanfUR12i4asA==
X-CSE-MsgGUID: DUwE0ptlRnSBxulg6lS1DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="901028"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="901028"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:25:11 -0700
X-CSE-ConnectionGUID: lXgWYvOQQ+q7VShg8kGiUQ==
X-CSE-MsgGUID: 7IvGDqL4TaaoDIviXjXdyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1723271"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:25:09 -0700
Date: Thu, 15 Oct 2026 21:25:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nikodem Sanecki <nikodemsanecki@gmail.com>,
	Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: westeri@kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad L13 Gen 2 AMD (21AB): Caps Lock LED broken by ACPI GPIO
 11 interrupt conflict
Message-ID: <atEaguJD7dh7xNs0@ashevche-desk.local>
References: <CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Dmitry (as it might be related to keyboard configuration), others for
the previously reported same IRQ on the same GPIO controller but for some
camera stuff.

On Thu, Oct 15, 2026 at 03:13:02PM +0100, Nikodem Sanecki wrote:
> Hello,
> 
> I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad L13 Gen 2 AMD
> running Arch Linux. I found a workaround that completely fixes it, and I
> hope the findings might help implement a permanent kernel fix.
> 
> *A quick note:* This is my first time using Linux, and I'm a complete
> beginner when it comes to kernel development. I used ChatGPT (GPT-6) to
> guide the troubleshooting process, analyse my laptop's ACPI firmware, and
> interpret the results. I personally ran the diagnostic commands and
> verified the observed behaviour, but the technical explanation below is
> AI-assisted. Please correct me if any of the analysis is inaccurate.
> Problem
> 
> Under Linux, the physical Caps Lock indicator LED never illuminates, even
> though the Caps Lock key itself works normally.
> 
> The LED works correctly under Windows and during certain stages of boot, so
> the hardware itself is functional.
> 
> After investigating, GPT-6 identified what appears to be a conflict
> involving GPIO 11 on the AMD AMDI0030 controller.
> 
> Booting Arch Linux with this kernel parameter completely fixes the problem:
> 
> gpiolib_acpi.ignore_interrupt=AMDI0030:00@11
> 
> The Caps Lock LED now works normally, and I haven't noticed any other
> hardware issues.
> System information
> 
>    -
> 
>    Device: Lenovo ThinkPad L13 Gen 2 AMD
>    -
> 
>    DMI product name: 21AB004LSP
>    -
> 
>    DMI product version/family: ThinkPad L13 Gen 2a
>    -
> 
>    DMI vendor: LENOVO
>    -
> 
>    DMI product SKU: LENOVO_MT_21AB_BU_Think_FM_ThinkPad L13 Gen 2a
>    -
> 
>    Kernel: 7.2.9-arch1-1
>    -
> 
>    Distribution: Arch Linux
>    -
> 
>    BIOS: R1QET54W (1.40)
>    -
> 
>    BIOS date: 2026-04-14
>    -
> 
>    DSDT OEM ID: LENOVO
>    -
> 
>    DSDT OEM Table ID: TP-R1Q
> 
> Diagnostic findings
> 
> The following is GPT-6's analysis of the diagnostic output and decompiled
> ACPI tables.
> 
> *1. Linux sends the correct keyboard LED commands*
> 
> Using bpftrace, we observed that atkbd_set_leds() consistently returned 0.
> 
> Tracing ps2_command() for command 0x10ED produced:
> 
> SETLEDS: value=4, caps=1
> SETLEDS: value=0, caps=0
> SETLEDS: value=4, caps=1
> SETLEDS: value=0, caps=0
> 
> The driver reports success and sends the expected Caps Lock states, but the
> physical indicator stays off.
> 
> *2. The embedded controller tracks Caps Lock correctly*
> 
> The DSDT defines the CPLS field at EC offset 0x0F, bit 7.
> 
> Reading that byte through the read-only ec_sys interface showed it changing
> from 0x00 to 0x80 when Caps Lock was toggled.
> 
> Enabling dynamic debugging in drivers/acpi/ec.c confirmed that each Caps
> Lock press triggered EC query 0x78, which was scheduled, started and
> stopped successfully.
> 
> *3. Lenovo's firmware controls GPIO 11*
> 
> The DSDT contains:
> 
> Method (_Q78, 0, NotSerialized)
> {
>     If (CPLS)
>     {
>         WFIO (0x0B, 0x00)
>     }
>     Else
>     {
>         WFIO (0x0B, 0x01)
>     }
> }
> 
> The WFIO method writes bit 22 using WMEM(), targeting address 0xFED81500 +
> (11 * 4) = 0xFED8152C.
> 
> This appears to control the Caps Lock indicator using GPIO 11.
> 
> *4. The same GPIO is declared as an ACPI interrupt*
> 
> In SSDT12, _SB.GPIO._AEI declares GPIO 11 as an edge-triggered, active-low,
> exclusive wake interrupt.
> 
> Its _EVT handler includes:
> 
> Case (0x0B)
> {
>     MSTP (0x3911)
>     Notify (\_SB.PCI0.GPP1, 0x00) // Bus Check
> }
> 
> This appears to conflict with the firmware's use of GPIO 11 as an output.
> 
> *5. GPIO registers confirm the suspected conflict*
> 
> Without the workaround, /sys/kernel/debug/gpio showed:
> 
> #11 ... input ... 0x457a00
> #11 ... input ... 0x057a00
> 
> Pressing Caps Lock changed bit 22, but bit 23 (output enable) remained
> cleared.
> 
> After booting with:
> 
> gpiolib_acpi.ignore_interrupt=AMDI0030:00@11
> 
> The result was:
> 
> #11 ... output ... 0xc50000
> 
> The output-enable bit was now set, and the physical Caps Lock LED worked
> flawlessly.
> 
> The system was already using atkbd.reset=1 for a separate
> keyboard-backlight problem. That parameter alone had not fixed the Caps
> Lock LED.
> Possible explanation
> 
> GPT-6's interpretation is that Linux's ACPI GPIO handling configures GPIO
> 11 as an interrupt input because of the firmware's _AEI declaration.
> 
> That disables the output driver, even though the firmware continues
> updating the GPIO output-value bit when Caps Lock changes.
> 
> Ignoring the interrupt allows the pin to remain configured as an output,
> restoring the indicator.
> Related upstream fix
> 
> This seems very similar to the Acer Nitro V 16S AI issue addressed by:
> 
> 6da1f3437435c82eaa15b121022474bb358ffe20
> 
> "gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro V 16S AI"
> 
> https://lists.openwall.net/linux-kernel/2026/10/02/1029
> 
> However, there is an important difference.
> 
> On my ThinkPad, the GPIO 11 _EVT handler issues a PCIe bus-check
> notification. I therefore don't know whether permanently ignoring the
> interrupt could interfere with PCIe-related events, hot-plugging or wake
> behaviour.
> 
> So far, normal use with the workaround appears unaffected, but I haven't
> exhaustively tested those scenarios.
> Question
> 
> Would a DMI-specific gpiolib ACPI quirk be appropriate for this ThinkPad,
> or should the conflicting GPIO declaration be handled differently because
> of the PCIe notification?
> 
> I can provide the relevant decompiled DSDT/SSDT excerpts, additional
> diagnostic logs, or test a proposed fix if that would help.
> 
> Thanks very much for your time, and apologies if I've misunderstood any of
> the technical details. I'm happy to run further tests with guidance.

-- 
With Best Regards,
Andy Shevchenko


