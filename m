Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC03AA1B2;
	Fri, 16 Oct 2026 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119470; cv=none; b=LeAAbCoGJLRnMQ8B55sXRYTLVKgrBfs9lmqdUJ2QkouzYwmX5awG0J04PgrxR6IAOjOw6MVC+eApn1L7/yLHkiXBmc6vyaShT7Y2hd8fELEdj7EeHx8eQHnqfdaVLYf4SnIGqn8r1A7eDAJtlb+vKkOOUcR1ByORKNDQ2Cd1Tjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119470; c=relaxed/simple;
	bh=rIRSv36RxPsQ95yPNEV2d6LpKKzaMMZSbNtDCDDrznE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4eHswug9nmqbMXADNwQCAxCuVSxC0MdEuIGASDZAaLli8/+/L0pCEKNuubY8qj9CkmaL4jXbO2N6rvyG0N4gEe1v0uqnnNQct0Z5MMY5UpdlYgdKUanxZL8Ndr7aPVl/6OTr+FE8qUpDROAav8XraXAr8WYECNdTxwi+/l4y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=n2XBDevQ; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="n2XBDevQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1792119462;
	bh=uYvE/H155U1b46baEfSLgR5Se7+7qQkO+xg/A0e0yME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2XBDevQsZlMfaQb6s/opOzUvDacbkIIBnLLNDeeXmQhQpRsszaUnzUkMQVH1JvTh
	 GqyhlIsheMf0xZbBB6kX6HOQp2D9t+rQxHRIcTHb0DDWq2tFXIf0fYeOIxluE2DWKQ
	 MVleNh/LnPVZlWJjNaZNf1ivDJ+s0EPuUF8tw2WY=
Received: from [127.0.1.1] ([223.66.52.202])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E683A2AA; Fri, 16 Oct 2026 10:57:40 +0800
X-QQ-mid: xmsmtpt1792119460tswdi55ed
Message-ID: <tencent_B82AAA47238236B668C04FA0547231C7A609@qq.com>
X-QQ-XMAILINFO: Nwte6vbuj0EqYRWAZQ2yEn0nnMAuyziV6eANkhZ/W29om9C1etIggSFBeZv+c0
	 ZfeA+G7V6tjxnsSTATHYU/9nONFZv3d516uyugY2AfkhRJe4U8z+IypBkKq2yjAfWixdfr+Nbz3T
	 coiw7R8gWQ+itrI/SGOozOwRKpT7uYEE8+WczTD+C6VEEUpE789S9Ag+42oaKw4h7GooY1C00oZv
	 e6WjudUT9gWwZSzX4lSnYycBpuv2PzdV0rNwvSKbD6RIeI4RdMTl3b6XrJeJriK2aA69CGqeupct
	 HNcA1ikkOlzZDRGsniwpqPB0IOtWr5LTZS6rr7FINOoJzlWygdzqgT7V9qg726GxmioNYrVV/UwD
	 mz9ZRmmC9UVSGHuf+G+BnD0m3VkcRQB5b2/eA2NDzGFNm76E2Mfbpamv8I7ioVWrfp4rBpfZhzas
	 QCzI3UNu4bvjdqjtMaXdiuiKGn9WNU1NpdCRfZeFlzPqf8xAw6Msz3cTRwoMdQHhwIS/44AcSgcF
	 PzKNEOUOzxUPpM4DbO+ycC3v60IYVhADkP28B7WLggTRYT+wOHs1KoScdaFoiwf/MzwtYk5LsXMT
	 A2cOD06KffoNCv/AAkYniMugEfO++qaW/KT3zdm5YayBZIsB3bEziXeYS/Rjt09Q4/TgJHGEl+tK
	 oOo8f90dkZmtRjYj+YDrsZYyUEI3ck7R9GEtWioO2CYUDneNBiAYtRi3vEw544esy1gSQEAn9/5G
	 nXPTBlj4EwCoA/ZAZtijb7taDcYWiZZ556T1UC8grMRas83bvZCjEuJzEbaL7UAINJSmE012v6/T
	 InDaxOLtFs/BKWCrxaGLAnqsYQahhOW5GNTSDD0MM97R+/llUE2QRXDKFfe7pc/fn4NavX3q2AJT
	 LosPS3cZQjQnmm4VUZsztmUEi6T6Yr8ZIdaKoCwxuBtzsavEE5F+E8LBZroYa9ZlAuQ1DQXklCc2
	 5fRDPiuaHrThfn/4PB1g52QiJIwemhLABn9lLIIJF9MZuLOZ2p4AgVw3qMMSFXFNJwEFji3E/KCY
	 /KKNAeQijdY5M/zVFXVaFEKMXLmKFwJ7vhbkcYfHhw8w5MI1IeMno6XL0AP46MgdGner+56sRpni
	 LPEaV4od1NoOaQGoI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Wu Zhipeng <zepwu@foxmail.com>
To: Alex Yeo <alexyeo362@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: Re: [RFC PATCH v3] platform/x86: panasonic-laptop: Add
 platform_profile support
Date: Fri, 16 Oct 2026 10:57:40 +0800
X-OQ-MSGID: <179211946029.956581.435333470375911880@foxmail.com>
In-Reply-To: <2df90a2a-770b-4439-9d01-bd8105084719@gmail.com>
References: <20261007190446.38862-1-alexyeo362@gmail.com>
 <tencent_7F39F02728B55CE3B1878AAB51BAA0FE2D07@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alex,

Thanks for the follow-up. A correction first, then what I can say about
the power unlock, and the tests you asked for.

1. Correction to my previous AC numbers

The 12 AC runs behind the tables in my last mail have to be discounted:
they were taken with the machine in its efficiency profile -- EPP=power
with turbo disabled -- and a small thermal control tool I wrote was still
running, which re-applies the profile's EPP. Only the battery session was
pinned to EPP=performance.

  AC session (last mail) : epp=power       5412-5510 e/s
  Battery session        : epp=performance 8122-8497 e/s
  Earlier AC, same day   : epp=performance 8143-8515 e/s

On this CPU, EPP=power at 8-thread load draws ~8.5 W and the PL is not
the binding constraint, so "the TDP toggle moves essentially nothing" is
an artifact of that state, not firmware behaviour. The fan deltas are
unaffected (both arms shared the state); it is the power columns that
should be disregarded, not the fan conclusion.

I will rerun the AC matrix with EPP=performance, turbo enabled and the
tool stopped, and send the corrected table.

2. What I can say about the power unlock now

TL;DR: on this unit the EC enforces its own power limit, and any
SEFM/SEPL write re-derives the EC PL registers from the IETM tables, so
a direct PL write does not stick. The ~10 W "locked" plateau is EPP plus
that EC enforcement, not the PL failing to bind; with EPP=performance
and turbo on the PL binds again, and "unlocked" only removes the
firmware table PL.

Details:

 - Both PL write paths bind with EPP=performance and turbo on: on the
   direct path, set points of 3/10/20 W give 3.7/9.9/19.9 W and 255 gives
   ~26 W (the RAPL ceiling, not a firmware cap); on the SEFM/SEPL path,
   set points of 10/15/18/20 W give 9.98/14.98/17.98/19.98 W (package
   reaching ~4.2 GHz). An earlier ~17 W reading for the 20 W set point was
   a thermal state, not a wall.

 - MSR 0x610 (RAPL PL1/PL2) stays at 28 W / 60 W across all of that.
   The EC enforces the limit through its own path instead of
   reprogramming the RAPL registers, so the ~10 W of the locked states
   does not show up in the MSR either, and the missing TDPL() call is
   not the explanation.

 - Any SEFM/SEPL write re-runs REFM/REPL, which re-derives 0xCA/0xCB
   from the IETM tables (P140/P143 here) -- so a PL override does not
   survive, which fits your decision to drive only SEFM/SEPL and leave
   the PL alone.

3. Tests you asked for

 - Windows: I am setting up a Windows 11 install on the same unit and
   will run a comparable 8-thread load with HWiNFO logging package power
   and temperature, and dump the ACPI tables from that side as well. I
   have no wall or USB-C PD meter, so those will be package power
   numbers.

 - thermald: not tested yet; it belongs in the picture because it is the
   component that drives _OSC -> SEFM/SEPL here. I will report CEFM/EPLE,
   MSR 0x610 and package power before and after starting it. For
   reference, in an earlier run a single SEPL write during 8-thread load
   moved package power from ~8 W to 27.7 W within ~5 s, so an OS-level
   writer can move the power state here.

On the DMI quirk: I would rather hold it until the above is in, so that
you are not asked to carry a model whose power side is still half
measured. Say the word if you would rather have it earlier.

If you have a load you prefer for the Windows comparison, I will match
it so the numbers are directly comparable.

Wu Zhipeng <zepwu@foxmail.com>

