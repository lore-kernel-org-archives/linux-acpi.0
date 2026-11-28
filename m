Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795831255;
	b=jD+7wGd7vjJsT5WpQGsWJWWhVEgce7NxAbaDmMgmFKuMuMTXtokJ7k/nFWwblSxrwCgn
	 Ifz7tnHHFIq3RmJIizCO6NMC4FzJKLc+LBIdGCLZxeNXvqgf383ecLZKbsme+5bBWkFJ3
	 ADtSwDVGOBYkA+nnmKlRg/sQHrgaRJlyhZScI9It33P+BOARtbCCMFwtj4AZhSzGlZObf
	 hhBJ/nSO1TAw9mg2hrJl4sgiaOdbCCa6V9DkpqNXmNsPPZqcuGZaosTwN1oykL7EuHqjC
	 62xrYRDIKWHXpXUnSLpK4sDg5MPPCWO1/MCPXSsxLuUEqrEfTh4qIg2bUGklwtVr/Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=THiOG6yeDwGvR8nJmqjVk5/9O8jrhV6Y0gw1+16ztmY=;
	b=gMU0/xZjdve7J+RlGvJ/lnvwzjIjYRV1yPCETs/X3ukC/U/Om3jJAIyEj0s0yG/lObOZ
	 MN0uDee4oaq3Fi+ZDTUOartUd42f6eKxeJrdiNgPeASEXDiOUzgJ1DwIKuAoUtaED622E
	 p8KRFFMYGwTDApPGNXr67DZx0CMFukSPdFTSJ3jqLprq42kebi635L4mEngvud4RCaX4W
	 5n0fbxGaFT8t285OEi+dkLWiSKbN4bem5/pV9smTluRnTosszawVyz9WcgvnLUGnZYDTn
	 IxUeVMNLpANAYMza8Ca8oqSI7VVOgQBG09njWHytRi6roV9/h8Lk7mAzmj8QlxS0sKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxeRMwCR;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB58606A31E
	for <linux-acpi@vger.kernel.org>; Sat, 28 Nov 2026 02:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DB58606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxeRMwCR
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f0464dd6b6so53124795ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 18:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795831254; x=1796436054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THiOG6yeDwGvR8nJmqjVk5/9O8jrhV6Y0gw1+16ztmY=;
        b=dxeRMwCR5ld93fq20sgEi/k/9/69SDSHHUAUZmz1+nRqmOgoQaSJPe9t+yAFf0JNKy
         UbajOzgB7dxgeN6YocfeWYqYnKa/HXrHfeYk9eYbI5XmBFPTgqdhi/ijjBpEjJktvwK4
         BfAkOdqfguAUSyVb7tYYDJAKepBGfmi41Ke5EV1dnSFMFsxG8LYrk7NDKs6uLJ0Wm5dl
         tMyJpc+akLa2FCIaRuofbaffyZ5ox8j1ND2K0PJ63FN4f/LQX4We8mPJbCwkGWUMV7Ut
         P428ycNUBwI6I+XYA/iDBp6/jOBTGZ4TJv8ZGr5FGqsMI68GVT8rnu6rC0RJteLTqaOw
         kxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795831254; x=1796436054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THiOG6yeDwGvR8nJmqjVk5/9O8jrhV6Y0gw1+16ztmY=;
        b=qz5PzGeD0ygFUmlDiWmZ6ow6TTwZWWroLjxnibmZqO//hJYLFBdnuxOPO5w/jHvaNB
         4Z6ChZIKnAscqnsjHiW7ICVesBgaCRIg1feWhC+fnyyUGf0wNgZP2Yvs8AC+ZRQSy6Gq
         XlKjzTPk0A9n7o0B/tZBnYGkwejFJqYDEq3m21qJMrMq8RV/lychQkqCeHxU1O1dMblE
         KLVLWCX3LI6/sQG8xH2tA8MqMMVjTQJMG1qs6c+jFbsoyPCdfijdnzbDR54Y9UDD4frA
         XTFO8CqyOAZ8p+qljDYiWu/QqD1QARSw2AJYaFNc9RtQbY1gfygFXYGdqaTx3B8vat6m
         5bZg==
X-Forwarded-Encrypted: i=1; AL+hErFHafsn5PlRXJYZswqx8B+2cln4PAEP+ZUq4hhZkv4CtqvYTknbDiHZtrWlnmCZYClz95BVPAVsPPDc@vger.kernel.org
X-Gm-Message-State: APuU4Z/99Hk/sr1Kckrx/BBnWFPDGotfzzRXa23QgqffNW8ly9VIOC1R
	Aie3Rctrn+MdHeP+uw09sLZb9ayL4dtHxXX58aKs6afd7pXkdX7L7tY6
X-Gm-Gg: AZFdTZdBOJZAiA9rSWx4HHAzc8BM5W2rqhcN6MLKggmTv1hQpV8MaQmGRmm2OuyrgA9
	d4xmKo7s8NjxP8BP3FPJiJ6mkTx8U5isOzHPIkD/dQWQMoF+hFQISVBxaFJ0wnHqSbbBEHAMltM
	IPTIeNQ8UD/m4nQCy4G9K9MrwbOPor+CpMg1LdFUEoxRjQ0rRa6gSFAZkhxPndd1OBTjuhviBK2
	8E0XJKwhDW90DD1O9vKv1zwAMhGN/OaA59S5BxqJ3014yzKdkTJjWLKm8Pd3Oj6hER/IIKfK5Go
	7sR4u8kw4OewAlJsDg/QE7JxeLEVi7x4O0R4XmQDnGrp9Vdo+po2ZezHyhCcwQS6pZHWTU4pvQN
	mBGhUv6Sk9/xMyXXLG8liVGyXpTKsWw3EnkvOV+Stgj1jPeoi6G1C5D1G8aCXRtST+9VYn0qNiL
	5k5MBFo4KqFAJlkyg/zYLhke6RlaO6DyrXKqzijP1lWSty4hBp9tzecHTVbjcoG02v2GfW0+OLU
	b8cf40zSqDzLFY5fBdPI07s9kSfhTiljog/n0WoczWNftGlO0Mnofo5BwCst37CcgNAGAHW/lBw
	tLYNbBi8NzQ6JQ52/dMrDEXpyfhTE1zv2viSZNvtvfU=
X-Received: by 2002:a17:902:cf0b:b0:2f0:25ea:8fa7 with SMTP id d9443c01a7336-2f03f18a1a5mr265082035ad.38.1795831254335;
        Fri, 27 Nov 2026 18:00:54 -0800 (PST)
Received: from localhost ([20.89.137.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f15663fsm127058405ad.76.2026.11.27.18.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:00:52 -0800 (PST)
Date: Sat, 28 Nov 2026 10:00:50 +0800
From: Mingyou Chen <qby140326@gmail.com>
To: Ferdinand Porsche <akiletschne@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, W_Armin@gmx.de, ilpo.jarvinen@linux.intel.com, hansg@kernel.org, 
	foxido@foxido.dev, wolf109909@outlook.com, Chris Taraszka <chris@miget.com>
Subject: Re: [BUG] Xiaomi Book Pro 14 (TM2424): ECON undefined, EC hotkeys
 (Fn+F4 mic mute) never reported
Message-ID: <awoz1BKtliVN7dk4@qby-laptop>
References: <CAPQ11N91cTtpeynVHOE4zkO3UTMKm_3iNR5iN8PEp_Byo_EQug@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPQ11N91cTtpeynVHOE4zkO3UTMKm_3iNR5iN8PEp_Byo_EQug@mail.gmail.com>

On 26/11/27 10:29PM, Ferdinand Porsche wrote:
> Hi,
> 
> On the Xiaomi Book Pro 14 2026 (Panther Lake, Bitland "MIFS v2" firmware)
> the Fn+F4 microphone mute key does not work. The key's LED toggles (driven
> by the EC itself), but no input event ever reaches userspace. I think this
> is the same firmware issue that breaks lid events on this machine. Armin
> asked for an acpidump of this device in the "bitland-mifs-wmi: MIFS v2"
> thread. I can provide one, see below.
> 
> Machine:
> - DMI: XIAOMI Xiaomi Book Pro 14/TM2424, BIOS XMAPT4B0P0A0A 06/17/2026
> - Kernel: 7.3.0-11-generic (Ubuntu 26.10, based on 7.3.1)
> - Secure Boot on (lockdown=integrity), so no debugfs/dynamic debug.
> 
> The kernel is tainted (O) by the out-of-tree xiaomi-book14 module mentioned
> below. The ECON errors and the missing Fn+F4 event were the same before I
> installed it. I can retest on a vanilla mainline build if that helps.
> 
> Firmware bug:
> ECON is referenced as External (ECON, IntObj) in the DSDT and used in
> \_SB.PC00.LPCB.Q_EC._STA, Q_EC.ADP1._STA and Q_EC.LID0._STA, but no table
> defines it:
> 
>   ACPI BIOS Error (bug): Could not resolve symbol
> [\_SB.PC00.LPCB.Q_EC._STA.ECON], AE_NOT_FOUND
>   ACPI Error: Aborting method \_SB.PC00.LPCB.Q_EC._STA due to previous
> error (AE_NOT_FOUND)
> 
> acpi-ec still binds to PNP0C09:00 (\_SB.PC00.LPCB.Q_EC) on this kernel:
> 
>   ACPI: EC: EC started
>   ACPI: EC: interrupt unblocked
>   ACPI: EC: event unblocked
>   ACPI: EC: GPE=0x6e
> 
> Observed when pressing Fn+F4:
> - /sys/firmware/acpi/interrupts/gpe6E increments by 2 per press.
> - No EV_KEY on any evdev device. I tried redmi-wmi bound to
> 46C93E13-EE9B-4262-8488-563BCA757FEF (keymap has no KEY_MICMUTE), and also
> bitland-mifs-wmi bound to that GUID instead (its keymap has KEY_MICMUTE at
> scancode 0x04). Neither reported anything.
> - Nothing on the acpi_event genetlink group either. I had no positive
> control for that, so it is only weak evidence.
> 
> DSDT/SSDT notes:
> Most Q_EC._Qxx methods call \_SB.WMID.QV20(One, code) (SSDT "WMID", _UID
> "MIFS"). That stores EVTP/EVFN in the XGNS SystemMemory region at
> 0x6FDB8000 and does Notify(WMID, 0x20), e.g. _Q04 -> 0x21, _Q08 -> 0x01,
> _Q15/_Q16 -> 0x25/0x26. _Q0A/_Q0B/_Q61 (AC/battery notifications) and _Q79
> (UCSI) also live under Q_EC.
> 
> The out-of-tree xiaomi-book14 driver (
> https://github.com/wolf109909/xiaomi-book14-dkms) works around the same
> root cause by polling the EC RAM window for the lid. Its author is Cc'd,
> and the hotkey part is filed there as
> https://github.com/wolf109909/xiaomi-book14-dkms/issues/2
> 
> Questions:
> 1. Since acpi-ec binds anyway, is it expected that the _Qxx handlers
> apparently never run, or am I misreading this? If they don't run, would a
> DMI quirk that treats ECON as 1 (or forces Q_EC present) be acceptable?
> 2. Which driver should eventually map the Fn+F4 event to KEY_MICMUTE on
> this machine: redmi-wmi or bitland-mifs-wmi?
> 
> I can send the full acpidump off-list to anyone who wants it, and I can
> test patches on this machine.
> 
> Thanks,
> Ferdinand

Hi,
I've noticed lots of temporary workarounds in the xiaomi-book14 dkms driver.
This is out-of-scope of a WMI driver.

redmi-wmi was removed in the next branch (now replaced by bitland-mifs-wmi).

And by-the-way, the TM2424 quirk is already available in the next
branch.
But I've noticed a problem: The platform profile map is different
between the in-tree bitland-mifs-wmi driver and the xiaomi-book14-dkms driver.

xiaomi-book14-dkms defined those values:

#define QFAN_QUIET		0x02
#define QFAN_BALANCED		0x03
#define QFAN_SPEED		0x04
#define QFAN_EXTREME		0x09
#define QFAN_EXTREME2		0x0A

but bitland-mifs-wmi got another:

static const struct bitland_profile_entry tm2424_profile_entries[] = {
	{ PLATFORM_PROFILE_LOW_POWER,   0x02 },
	{ PLATFORM_PROFILE_LOW_POWER,   0x0a, true },
	{ PLATFORM_PROFILE_BALANCED,    0x09 },
	{ PLATFORM_PROFILE_PERFORMANCE, 0x04 },
	{ PLATFORM_PROFILE_PERFORMANCE, 0x03, .battery = true },
};

Here's the answer of your questions:

1. I consider this is a linux-acpi problem...I'm not familiar with it.
I'd suggest Cc'ing the linux acpi mailing list and maintainers to see how
they want to handle the problem.
2. bitland-mifs-wmi (in linux-next) should handle it. It already maps
event ID 0x21 (WMI_EVENT_MIC_MUTE) to KEY_MICMUTE.
