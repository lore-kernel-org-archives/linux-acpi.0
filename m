Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890152D2B0
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092321; cv=none; b=aeOV9198SMpOFM4GKHmKPLN4a1/b2XbrawiHZDXruoOoBhu4nsqM7kYXfq9l8Czc1gpBqcbtQnsKUxJomncN0fJq8HVIZ6Oxp+AD3Cs3+P5By7nt1H/RfMl6MJNvIpqe8m7AlutLbTdQ+/ydjohqVZueokxuRA55VTnFO8oFoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092321; c=relaxed/simple;
	bh=CcPtFeDxuKeI+jBTd79vnC1W+hTrfRqXuZlfv/c1q98=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nz/8znW4DiImTUuI44cLhmciYR6+yOdywIQe0zzzjI9iXencJ/SchFoQLq1e5bxLEKP12PcjHLQFDY3TUKsY9lxvut35DLXS9v4vBN9zVMK1wRCZynkhN1D6jizwcNQ8jYcTBL72lwAzVa/q0ZXEw7wgWKrd1vH3IM0UQjyhCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=e0T20ARu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oxwmGVOU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="e0T20ARu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oxwmGVOU"
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfout.stl.internal (Postfix) with ESMTP id 198731D000DA
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 15:25:19 -0400 (EDT)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 15:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1792092319;
	 x=1792178719; bh=c/+iBdm2gO7P9TcxYJ8H4wJsONUr6ohW8Zzmjz+Ct04=; b=
	e0T20ARuYgy6p1RcFftV0I6DeFn6VSDE4xREtH6GoJy8WDGojNF1vBfsTmObTrDs
	8i4mWiaRe2IlRNVhTvzqjn6vSR2o1714fsd2bBTPRN5/sVR58Zm8URqH0MZNWfUb
	y9Z5MysPHfvvCATe6cQVPr93du+IrhBCeFCA5InZ19WV7cpm9kDqnFuVYD5AHOXE
	TNTGYJ6lvqrgJpobr2PLGDeKFKSC13DZaT//lTc1LO4KNU6OHn6HN/6z1ctIx+3a
	B3QZrtoJsokyiVqP6wig64UoRiltVr8sMf/Ai5t2MZlxi3ir2OfFhu5ZbQ/oDyDi
	iN9bNzKkowuI+WG2M6AqWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792092319; x=
	1792178719; bh=c/+iBdm2gO7P9TcxYJ8H4wJsONUr6ohW8Zzmjz+Ct04=; b=o
	xwmGVOUppju+0I3SeWDuq/sWd58e03JzfSX2M4n1/gEuqwvBAo2wnfdMYtLA7Ntm
	88GHGjG6QX8K1mMoz1mKX3gMckpiR25PH9HCzn5+7IMOreauanj/XSdXivtZR2Fu
	H+6CXgHyUBsmSG2ZOugZLXtdk6m/IqRo4/THf7XcM6TOqR9ixAXQXLTdLbWIhgLe
	27gRUDmEIkCgsvKmd1NWvn6mKdS+walW7glkrgJZVfbBR5WUFLI8RuUnlW3ilUod
	vsOyjl+MZLHHAcHRtir+yt8wIMaCGzRCcVY2krMFVUum7utKR43ai274ML5LSzb7
	ODMg1xZBZ14c/VgNkrKbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792092319; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:b2nC1xSAPR8oZ7bV1CEjhd1wvh4SVaCt8uTMwJKrNS+l85K
	jsJl7wCq/cXYYOiRDzt7dr9mwusgBIaqBMTTCMp5lt2mrXe01C7RKzCOcl2MGA3P
	EZ8TUF0lMCvEPr/3fuKFllkdW5WqzFEsCz/I0XENRwTnJLN5/WYiZcltpVLrPNSf
	6Qt3AnTl3HwsyDgiU/6CYu55dIMPxUhQMDwtyyoX3yTYPuXFbNk+1uvxbrkKYtKU
	BlVvg1zvVHAL4ZOXV+BIyoxJNOKFdpkuCktM8KEWsk84Y89W1tOErCQih7TJ1/uZ
	a7PUKII6AucxbAV3rYvGc2D/uUJF/wygHnWxrSQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xF0POjmysCWqOvs2RcfGn+89CQoow7ftqhYOyNRfoqU=:CcPtFeDxuKeI+jBTd79vnC1W+hTrfRqXuZlfv/c1q98=;
X-ME-Sender: <xms:nijRatgUeX-wiNn2m39J4Xn9XzR9MQph-EoBc4CapPkSm_Gl5f1dfA>
    <xme:nijRas3D9nHekhT-9jEPWZyGwdr2-CCycVtp7bBJITivbi9KZ8tBWsvwsBZ1XICbz
    KZEDNpjqL1kb_0XcZiGCCQNJ2Yjm1FkAqNh08arJMY4UDnt5hdQe5onTg>
X-ME-Proxy-Cause: dmFkZTFwmCjNujHbBkHusQg8CZ2BUYVK1XOI7DMSmwsBQu+oTumJXizOvldmKb3C3NQv84
    eC/HQ1QkzO/ntc8ucYiFyUUukY3+9BVO28OeOznziM5FengWPn5UUJ3+T/IadGPLU7C8rE
    fO+VW4wG++cdewglY/oaFpFYqDLPjvyRcbebAcZbpgZ7CzYdVlmm7Zgq0F7SoVU5r32ElB
    uor0XmwbMOlfrS8w+Xv+D3DWSEbW7pLS4E66vrlkBJOnK3A1Ys/TeNy2LrBqiYhAW3l++A
    zmH6w9J8s4zwMZxNNAUFdhx5QeKFQjIrpn9LU4qX6cZmfpr69DYOtkR6u/9QE9y2tC91Hs
    y4y0HXQpy7eSoEjqX++EXUqj/BJKahom+YI/SkNdQ9hilKMDzwLasR1L1WRm4iALaeQfII
    y2jApkupE3xHcW0Lk4lRYnwdiKeQCuFBy/+bxRIyM2D2kryoxo1kKJyG4Dj0MIlpT5UpoD
    k4wB1x2EJdbjesv7gk+Ss1j4RJOQb+fuY/8JEIViwbajhMFu4lK1Ek+btU23bROFy0Fooe
    vOjr9MH5uNA7J+C4IrKMuPQWuwoLwp39bJJVAvGBcyBFAich56vQ/26Wmc1pKe7J/eJUKG
    dYqo1Z1P6Chyv6NgEo3cAaoLuUxgemWnP3IV/9SxI3FgnLDiU+q5DlqLUKiQ
X-ME-Proxy: <xmx:nijRapDQu7D2WOliG5bG3z2sQJyoEKClcGzzGqk4jI6Y83aio6cRtQ>
    <xmx:nijRaqkujlLA3P2fZ-uzZtGlzsb4DoMfwgyXGWJDirBQqFOsQG5d8w>
    <xmx:nijRavOLX9LBAWrmIl4HdOQFNqJheNZQetr8Cs669hm85bwA9MZ_EA>
    <xmx:nijRav9fcQGMiYP-99qAoNWUOS0mY_NMc6OBrRkTfMd_qtO9Ky13Aw>
    <xmx:nyjRatzse7V40q_umRKFJ2WAdu6spqe1xR2MhwMQY0872256YZttce1k>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id AF62B2C0007C; Thu, 15 Oct 2026 15:25:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVhcxyZ0WazV
Date: Thu, 15 Oct 2026 15:24:57 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Nikodem Sanecki" <nikodemsanecki@gmail.com>,
 "Abduvaliy Abdulazizov" <abduvaliy.hbai@gmail.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Mika Westerberg" <westeri@kernel.org>, linux-gpio@vger.kernel.org,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <4ba482fe-8b34-48ad-9d13-99ab532cbd97@app.fastmail.com>
In-Reply-To: <51c151fd-31cb-4ebe-8f3b-eb7634e68c31@amd.com>
References: 
 <CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com>
 <atEaguJD7dh7xNs0@ashevche-desk.local> <atEb6FN6ZbKI9xgf@ashevche-desk.local>
 <51c151fd-31cb-4ebe-8f3b-eb7634e68c31@amd.com>
Subject: Re: ThinkPad L13 Gen 2 AMD (21AB): Caps Lock LED broken by ACPI GPIO 11
 interrupt conflict
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, Oct 15, 2026, at 2:48 PM, Mario Limonciello wrote:
> On 10/15/26 13:31, Andy Shevchenko wrote:
>> On Thu, Oct 15, 2026 at 09:25:10PM +0300, Andy Shevchenko wrote:
>>> +Cc: Dmitry (as it might be related to keyboard configuration), others for
>>> the previously reported same IRQ on the same GPIO controller but for some
>>> camera stuff.
>>>
>>> On Thu, Oct 15, 2026 at 03:13:02PM +0100, Nikodem Sanecki wrote:
>>>> Hello,
>>>>
>>>> I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad L13 Gen 2 AMD
>>>> running Arch Linux. I found a workaround that completely fixes it, and I
>>>> hope the findings might help implement a permanent kernel fix.
>>>>
>>>> *A quick note:* This is my first time using Linux, and I'm a complete
>>>> beginner when it comes to kernel development. I used ChatGPT (GPT-6) to
>>>> guide the troubleshooting process, analyse my laptop's ACPI firmware, and
>>>> interpret the results. I personally ran the diagnostic commands and
>>>> verified the observed behaviour, but the technical explanation below is
>>>> AI-assisted. Please correct me if any of the analysis is inaccurate.
>>>> Problem
>>>>
>>>> Under Linux, the physical Caps Lock indicator LED never illuminates, even
>>>> though the Caps Lock key itself works normally.
>>>>
>>>> The LED works correctly under Windows and during certain stages of boot, so
>>>> the hardware itself is functional.
>>>>
>>>> After investigating, GPT-6 identified what appears to be a conflict
>>>> involving GPIO 11 on the AMD AMDI0030 controller.
>>>>
>>>> Booting Arch Linux with this kernel parameter completely fixes the problem:
>>>>
>>>> gpiolib_acpi.ignore_interrupt=AMDI0030:00@11
>>>>
>>>> The Caps Lock LED now works normally, and I haven't noticed any other
>>>> hardware issues.
>>>> System information
>>>>
>>>>     -
>>>>
>>>>     Device: Lenovo ThinkPad L13 Gen 2 AMD
>>>>     -
>>>>
>>>>     DMI product name: 21AB004LSP
>>>>     -
>>>>
>>>>     DMI product version/family: ThinkPad L13 Gen 2a
>>>>     -
>>>>
>>>>     DMI vendor: LENOVO
>>>>     -
>>>>
>>>>     DMI product SKU: LENOVO_MT_21AB_BU_Think_FM_ThinkPad L13 Gen 2a
>>>>     -
>>>>
>>>>     Kernel: 7.2.9-arch1-1
>>>>     -
>>>>
>>>>     Distribution: Arch Linux
>>>>     -
>>>>
>>>>     BIOS: R1QET54W (1.40)
>>>>     -
>>>>
>>>>     BIOS date: 2026-04-14
>>>>     -
>>>>
>>>>     DSDT OEM ID: LENOVO
>>>>     -
>>>>
>>>>     DSDT OEM Table ID: TP-R1Q
>>>>
>>>> Diagnostic findings
>>>>
>>>> The following is GPT-6's analysis of the diagnostic output and decompiled
>>>> ACPI tables.
>>>>
>>>> *1. Linux sends the correct keyboard LED commands*
>>>>
>>>> Using bpftrace, we observed that atkbd_set_leds() consistently returned 0.
>>>>
>>>> Tracing ps2_command() for command 0x10ED produced:
>>>>
>>>> SETLEDS: value=4, caps=1
>>>> SETLEDS: value=0, caps=0
>>>> SETLEDS: value=4, caps=1
>>>> SETLEDS: value=0, caps=0
>>>>
>>>> The driver reports success and sends the expected Caps Lock states, but the
>>>> physical indicator stays off.
>>>>
>>>> *2. The embedded controller tracks Caps Lock correctly*
>>>>
>>>> The DSDT defines the CPLS field at EC offset 0x0F, bit 7.
>>>>
>>>> Reading that byte through the read-only ec_sys interface showed it changing
>>>> from 0x00 to 0x80 when Caps Lock was toggled.
>>>>
>>>> Enabling dynamic debugging in drivers/acpi/ec.c confirmed that each Caps
>>>> Lock press triggered EC query 0x78, which was scheduled, started and
>>>> stopped successfully.
>>>>
>>>> *3. Lenovo's firmware controls GPIO 11*
>>>>
>>>> The DSDT contains:
>>>>
>>>> Method (_Q78, 0, NotSerialized)
>>>> {
>>>>      If (CPLS)
>>>>      {
>>>>          WFIO (0x0B, 0x00)
>>>>      }
>>>>      Else
>>>>      {
>>>>          WFIO (0x0B, 0x01)
>>>>      }
>>>> }
>>>>
>>>> The WFIO method writes bit 22 using WMEM(), targeting address 0xFED81500 +
>>>> (11 * 4) = 0xFED8152C.
>>>>
>>>> This appears to control the Caps Lock indicator using GPIO 11.
>>>>
>>>> *4. The same GPIO is declared as an ACPI interrupt*
>>>>
>>>> In SSDT12, _SB.GPIO._AEI declares GPIO 11 as an edge-triggered, active-low,
>>>> exclusive wake interrupt.
>>>>
>>>> Its _EVT handler includes:
>>>>
>>>> Case (0x0B)
>>>> {
>>>>      MSTP (0x3911)
>>>>      Notify (\_SB.PCI0.GPP1, 0x00) // Bus Check
>> 
>> This looks like some GPIO related notification. I dunno what Windows driver does.
>> Mario?
>> 
>
> Honestly - this sounds like a copy / paste BIOS bug that they copied the 
> SSDT from one system and didn't change it.
>
> I would think quirking it makes sense if the BIOS isn't going to be fixed.
>
> Before we go much further can you check if this is the latest BIOS? 
> Check Lenovo's website, in case it wasn't brought to LVFS.
>
> Also; Mark can you ask BIOS guys to look this over?
>
> It sure seems like GPIO 11 shouldn't be in _AEI.
>
Yep - created internal ticket LO-4711
Just a note though - the platform was not in the Linux program (and is rather old) - so my expectations of getting a fix is rather low I'm afraid

I'd get the quirk ready, and if I don't get any feedback from the FW team by next week go ahead with that.

Mark
