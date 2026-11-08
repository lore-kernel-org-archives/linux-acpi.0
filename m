Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121953;
	b=TZG7M7mqmgeu2fM2KAzOnR793eliTisPx8K93bppvYwkxnxSt3C3LmUs3bNpha2VTbz4
	 kWrZQDqMPzRxVXiy3QKRUTDxFOOuoyYHd5akl4uh8jzzz1ZOlJN1TW2tWvhHXijLRut5T
	 DpEjl7ublhXxvEMM2XmXy23fX4RYQWE7FULGJeCRmXtLoVpFXJ8i9FwEqBUmiv/du7hRT
	 yJkOraZ4epl8JvsVkqClCW2ckjD3aqOrjCB85QFo81FGP6Il4umG2wDEp1KXwmmjp0zXQ
	 F0IR9uDvalhGLrgTNvR0kug+SbT7Vej3hc/9Ekm/RBYnz/iI5IRjQUdeB3O+U18aptg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QaX11FKlbrrxel5yt5lItqhWglhL95q0Q/UWvFGwSEM=;
	b=tblOyjk/lW/2CkcrZCi18//biRHQIXqqOXpiEUZiuMCh7Ak7bja9yn2Zs6jStKqmOode
	 Eba2gAjcpNwhrw2eTLhpa4hh3Wrz3HKs6i5zxmwZwSpZG2G6NBau0YEG9rTh7VzZEHOYX
	 IJpfJjRzDVKdRGX1yhMACdocNcz6ulAwxnli9v131Gbpyo/kTsSebFV5tBZa0OMMPAGBd
	 9/vfbKqJg8zJdEpyLVRgbob2XxLlyZ2URTjMoAVsq40ijwMbRWUCDaCDCPBcKI+HpeOJd
	 757u0aCeqhPVRzmq+wVXijHxep9bPhwN64Xa8dwYhoS+/VcTNdi9PJLVtWr5ll/TOrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhNZ3HwP;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7517606A321
	for <linux-acpi@vger.kernel.org>; Sun,  8 Nov 2026 07:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7517606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhNZ3HwP
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-491aaed7565so99146f8f.2
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2026 23:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794121951; x=1794726751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaX11FKlbrrxel5yt5lItqhWglhL95q0Q/UWvFGwSEM=;
        b=UhNZ3HwPUWb+xsU+LrB9nBdbR1CFNHYoIhf8bYXVRaVpgKnz85xHpaEmfk/PNrPQz2
         mkMtHK2+IOess921ezEeH1kaRuBfb1gRfzVjCmdCWR9LH7w2KHZGG68DeZhrcceB2OU1
         nLjzBlJ96rhGWGjufIbJWTcZUd36JkJIaSs/tRDfWq1Spntglf+D+fYA+1Bt1w+Ques8
         VW75Ng9OJxgQQ7+E7v/TaEC3oUbpdnkI0pKBR5Swp4G9Q6ql8S3Gwo+ouc8SlzXxCVki
         17aStwfzlHx+IEg63Da0M4w1/j//VSshjYL7I284x4JTIumEQokRrMouIruXdmvbSUOH
         jtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794121951; x=1794726751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QaX11FKlbrrxel5yt5lItqhWglhL95q0Q/UWvFGwSEM=;
        b=dt9M7SaM/E8YfmxNydTn8qMh1lcrSA6gGqpRi/L1v/GaCApFkGkAJuAA7bkOZvbT60
         vvzWMyyoTjpw0v+ZlDtUnGntF8EYhTWgQZZvL6EuF1cx9DG99onsGuUf8fXiQVi/U/WZ
         UXiNKDkbANC6++ulRXXYqcJ8r9r1piHP/vcrugSLGdKKwX1IuLYZxztIrrMnq4D0KF+y
         AH7YGy7+hjJ8mGuGgKuHSGWatpB0bwOngtW9g3u14A0PMjyCZAVTWjPnoRhAkhrMpnsX
         Lov/uByDa7QcqCV1/UiqV/jzbuvdgTBUMMjtvInnPnDCq9wKYFFang1yRNZfiCjMJbo9
         8gLA==
X-Forwarded-Encrypted: i=1; AL+hErFhMMiUTugyXCxCuengHTuOfAUQq22feQPkQz62Oif8TgfPxsBksw9ob1I2tOQHxllzgzTlW3xbncCK@vger.kernel.org
X-Gm-Message-State: APuU4Z+fOt+b89bR3ToR/ovwgZ3HQGCb6OTVwVfZX5EkSSzlmRpxxz1N
	K0Jlechb5iAPosTHyc1hlBV7swEOsabvCP+keYFuJJjlFoxub366xwn7
X-Gm-Gg: AYBFou3sKeujKUjOZlFADXZR+7Y6v1iqMlnqgX3TcoKSsN1hUYNz737uv0eT9vVs7jr
	J38bZcYvRP/oxTjkjUZbdbrd84o0Q/Zy77VigAetXiJmYeS2TkTnfDbLICJiswE4GrFtkl6rtsD
	R5O/T4miHJ3cS+FU2cuNfUuerId54mLQa3SbZaC7t+eTAP1QUADFiF7suPCoSFQK1Rlnso1BsZ8
	dRkfZP2Rq255U9xPaMBjoVNX+LcPZ7j3wBnN1ozzntUGWBbJCrdUY0FUIdZS5uEJoaMywHdfSHB
	i5UNAXbPfEwiTEsBAwvwbpMLeNLfPHLt1UIULMNfPm3ozS9ZhgohODq29VcWq39YWPV15JdsNAm
	/uvtibwrBq9oVFs93mz0aGPsQY3jlXsXT5p2YygXTmATtgMS0xzmANFjLiHBe0OYtmVHq2j3FkT
	rcQ6AEqf4C8MWaCZMGnmbcHClIBPCwfFv2IOdb+9GNZd5CqPJezbfBw5u3KtnJLeX6sV4763L3K
	kN4Q8RJuR2LVGqKwg9/5Qir4ZbjrYycjXgi2kx4Amf3KNUnZMvHrx9FoXlDkcdY8gE0JfjxB22z
	KzO31SNOJXitnLUsZAH/cETCijbHXuSErjhKf1EhIfZMcwCNb+6Zts/+rwnDxm0OBJn8RLanf2d
	WkW6xknbj3HEAMjFxNw==
X-Received: by 2002:adf:e193:0:b0:491:e28b:1e1e with SMTP id ffacd0b85a97d-4958335a7efmr1603970f8f.28.1794121950867;
        Sat, 07 Nov 2026 23:12:30 -0800 (PST)
Received: from localhost.localdomain (bba-217-164-30-115.alshamil.net.ae. [217.164.30.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495b90701c7sm2609204f8f.10.2026.11.07.23.12.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 23:12:30 -0800 (PST)
From: Ximing Zhang <xzhangjr@gmail.com>
To: Hugo Sales <hugo@hsal.es>
Cc: Ximing Zhang <xzhangjr@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Ashton A." <me@ashtonantila.com>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: intel_pstate: Send CPUFREQ_UPDATE_CPUINFO on max_freq changes
Date: Sun,  8 Nov 2026 11:12:25 +0400
Message-ID: <20261108071225.54656-1-xzhangjr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101185807.112449-3-hugo@hsal.es>
References: <20261101185807.112449-1-hugo@hsal.es> <20261101185807.112449-3-hugo@hsal.es>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hugo,

I tested the four patches unchanged on an Intel Core i7-10510U using
intel_pstate in active/HWP mode, on the stated base commit
5854d2ce4b0b9ccb37b154319d8283bad889a694.

Cooling states 0 through 3 followed Turbo changes in both directions.
I also ran 100 CPU 7 offline/online cycles concurrently with Turbo and
cooling-state writes, followed by the same sequential checks, and a
suspend/resume via rtcwake -m mem -s 15. Turbo was disabled before suspend
and enabled afterward. Those checks passed with lockdep enabled and no
new warnings. The test kernel was already tainted by unsigned modules;
that taint did not change during the tests.

There is one remaining Intel hotplug case: changing Turbo while CPU 7
is offline leaves that policy's cpuinfo.max_freq stale when it returns.
I reproduced the same stale CPU information on the stock
7.2.5-1-cachyos kernel, so this behavior predates the RFC.

On the patched kernel, starting with all CPUs online, Turbo enabled and
cooling state 0, I ran the following as root:

    cpu=/sys/devices/system/cpu
    cdev=/sys/class/thermal/cooling_device0
    echo 1 > $cpu/intel_pstate/no_turbo
    echo 1 > $cdev/cur_state
    echo 0 > $cpu/cpu7/online
    echo 0 > $cpu/intel_pstate/no_turbo
    echo 1 > $cpu/cpu7/online
    cat $cpu/cpufreq/policy7/cpuinfo_max_freq
    cat $cpu/cpufreq/policy7/scaling_max_freq

These report 1800000 and 1440000 kHz. The policies for the other CPUs
report 4900000 and 3920000 kHz. With the Turbo transition reversed,
CPU 7 returns with a cpuinfo maximum of 4900000 instead of 1800000,
and an effective cap of 1800000 instead of 1440000 kHz.

I restored the starting state with all CPUs online:

    echo 1 > $cpu/intel_pstate/no_turbo
    echo 0 > $cpu/intel_pstate/no_turbo
    echo 0 > $cdev/cur_state

intel_pstate_update_max_freq() uses cpufreq_cpu_get(), whose raw lookup
rejects an offline CPU. The reused policy then takes
intel_pstate_cpu_online(), which does not refresh cpuinfo.max_freq.
This appears to prevent the new notification from covering that case.

Is this case intended to be covered by this series, or would a separate
intel_pstate follow-up be more appropriate?

Thanks,
Ximing
