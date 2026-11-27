Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775443;
	b=PlR/dlly68Ncz25IXdl9KUZ+PYOSKc1P3vSQO2z7IXyll54QndngYuICWILvGQRW/GKD
	 Tl0l0EHupJvHpWne8xw22Th4WAMjr85I8rXG+kBMF6bvgynYAsO3lxJi00mXxAeXACWqk
	 9DLz+H+I5CPEYtiRsXM81AsesownH5dqL4ge4iYmPzYh+R9J3GGO0n+6ERA3gH830OQo/
	 7yq/XFNh3TGVbnKGWLfDZUMFUpZB44iDFObGIrPgWct0WT2ifV5TA7vNMtNxDD6tJhN9D
	 89JMEjiq7RQwlrmcxC54dNAouz2Ftdv10Ki7fTkucTduyRGPmZhYSGdciUxc1/xAd9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wDNCT5dmOQWaRk4g039B7mVnjd1E54Q443a1ugSNbRY=;
	b=4NcsQNfbsNfxA28ppvcifTJ0BCvV2N+xLDu34hd4ErG8wt/VTkePwOd9mqv6Mguw2Nxr
	 ZEo27cLjoSMr6pYx+kcXJjIBaHykzv5WwRFrVCsyNVlxHgHpOmuWP+SPVPpw5YSzquuMO
	 2PeufwUvXk6bx9IeDNZkuKAzKlymwHFyu7YCsGBBdXXoT4MT0HKD/0q5XibY4tVSTO5Mi
	 opd9jbPuyEnn9bkNsq2xP9ZrFtcVqC04DSdGBYrxXWv92EMfDcQBkDANsgjKP+iTiDW7P
	 AxBAkVfHgJsfhVG0Gl4D6+1sy+s1+gxY/IpNlYMINxVVSrAN/RbghaNicuhc2AOh68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yVSmZXRJ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790B606A324
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 10:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E790B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yVSmZXRJ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso75602355e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 02:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795775441; x=1796380241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wDNCT5dmOQWaRk4g039B7mVnjd1E54Q443a1ugSNbRY=;
        b=yVSmZXRJYx3E6v9UxQWskPzH8yjkZi2B4TVBRq4ks0OEuNtjjtwnLI+9Zk5LfuExQi
         RiVych+svllJSThx5VcfSY5OVhFCF2BNWCLl5hhkA4NvjuZcexiDDVJNLQkHhs3CauNJ
         keAgPD6I623K4zcUaUnWdGasPOZ00oqnV8/bBv2LPgz3+jFeXR8kxmBeav9u6dn7KlX6
         qiiNlmLTPZpoBiWM9QJe7emXvwPhP2IYfUQO3jZaQjxFN/qdFxKFl9fIrp8q+OelE5+O
         /ewA5wzfhSXz9WnUN9gDFirV1+qBycLZTQYLkfD/RHL5tRVrB90n/Wu7M8DYSsbkzY4h
         3Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795775441; x=1796380241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDNCT5dmOQWaRk4g039B7mVnjd1E54Q443a1ugSNbRY=;
        b=iFKduare7NGwJYS+sKmF4JVCZbIojnYynV7V5gAdyVTLcouND8lMPJ9+eKG4nB3qol
         5cA8O9hpjRW8H85A6C7icOU7wQwGzsFZzWiOrUsFUnZQ92vvNLhfJgPdGxWDoiznQk1U
         1EjXoIuhn3bzPCYFFueHrwm3JdLHS6gu85GF1105dmU6Qq2vjh88AMNZcD235IgLRHdB
         NkHDR8lSa0OxMyrHLAmf+7Hp6piXgOFlw56ATqc7ZkLmbMlaPJiVTtYz66bIsENuMZjf
         sRe+wnbhoyr+ALEkTS8+SEzmyaYS2Z1fV7tM9IHYXqIh1kztk3IbfffBkZn91JEDPTni
         iuhw==
X-Gm-Message-State: APuU4Z9IlVxez43at7SGXdYIZiuvZtaV9nC3/Ts35gH5hF9pGf1LW6iR
	8vuJ53J85GaCVakCyxTn39pKRWponu3dxpatnqGlysjAs/A7iWSu2oSBAAXYkQ==
X-Gm-Gg: AZFdTZfHmkTMRl4bempuuhAQ4uMKG6uNeoSkwj9dDTO/apoqYgJt+AbPylX4CXkKo9v
	Uex2EOXzTyWTYtXsoQH12dc1hajJgO7OdfzE9QqKl9y0DKfN84IsyOYojYV+3cpPeY429NxEIQt
	Pvf7oqZ7H1VEs+atb8hFYAwr931vV2DDQiF97ej+IdLYPxrnedu5HhEcftkF2/XJqifoEi+6gd1
	4rfpgpUJzEu4i0cKS+1djrgcxJcxjsX0Lv0zgsJlnBYnNb2LAHA8XkoSRign4tErksotJ+uhMp0
	As7jxMFhXTfVsG6WcDy32X6yfAsLEd1UDm8nlpmx1zbTQhCNY0cgJfERIvrjGx/vj5iqpRrp68U
	GS8P/8FKTaGXW0cnfzDN9jTlRB0Tfx7js1Jrj8o03xKo1d/RMOlY5hI9actqC2otoNb7uLbxXUM
	Mt8x+ng+h/BhVQCJaaceQIeGyoB0f5MyDT57RVLvBWK4dDWS13HFAcOYy0oHDLPk9xj4J6dINEt
	PuPeYp7Diebpyao2sFiiD4UdyfJUc+8dkU4UPPdzpV2pMAm76CXVW8z9BonnNswA8FwOw9DKauP
	7DOPsy11v7Le/SQqWgtvbC5S871S6XZXP+DKM1G6/fi9i9OAzMBZPtxhZK/XApz1hcAZHb1VtiL
	berWbmWvOJXItag==
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id 5b1f17b1804b1-4bb8880f283mr486885245e9.19.1795775440820;
        Fri, 27 Nov 2026 02:30:40 -0800 (PST)
Received: from archlinux ([178.197.204.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm710882185e9.8.2026.11.27.02.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:30:40 -0800 (PST)
From: Tobias Predel <tobias.predel@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG] HP Dragonfly G4: AML deadlock (ECMX vs. Serialized GBAP) between EC _Q08/_Q18 and int3400_notify() -> ODVP
Date: Fri, 27 Nov 2026 11:30:39 +0100
Message-ID: <20261127103039.5035-1-tobias.predel@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121093708.5097-1-tobias.predel@gmail.com>
References: <20261120191423.10876-1-tobias.predel@gmail.com> <20261121093708.5097-1-tobias.predel@gmail.com>
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

Hi,

A third occurrence today (2026-11-27), on 7.3.6-arch1-1 (not tainted),
same BIOS 01.13.01, again with acpi.ec_max_queries=1. It started about
33 minutes after boot.

This time it was the original variant from my first mail again, not the
EC-only one from 2026-11-21:

  - kworker/2:2 (kacpi_notify): int3400_notify() -> evaluate_odvp()
    waits in acpi_ds_begin_method_execution(), i.e. on the sync mutex of
    the Serialized GBAP, while ODVP already holds ECMX.
  - kworker/2:1 (kec_query): waits in an explicit Acquire, matching
    _Q08/_Q18 inside GBAP waiting for ECMX.

hung_task reports each as waiting on what the other holds (excerpt
below). Behind them were four more kec_query workers (kworker/5:1,
7:1, 10:1, 11:1) and thermald (int340x_thermal_get_zone_temp).

Two observations:

1. This correction concerns my question in the previous mail. Making
   kec_query unbound or ordered would not have prevented this
   variant, because the other side runs on kacpi_notify, not on
   kec_query. Both workers were even on the same CPU. Fully serializing
   EC queries only covers the EC-only variant (_Q09 vs. _Q08/_Q18).

2. It does support the max_active observation, though: with
   ec_max_queries=1 there were five kec_query work items inside
   acpi_ec_event_processor() at the same time, on CPUs 2, 5, 7, 10
   and 11.

The practical impact is that poweroff hangs. thermald and upowerd stay
in D state, systemd's SIGKILL after the stop timeout has no effect, and
the journal ends there. Only holding the power button turns the machine
off.

Since the firmware takes the two locks in opposite order on two kernel
paths (EC query and Notify(IETM, 0x88)), is there a reasonable
mitigation on the kernel side for this machine, for example a DMI
quirk that runs EC query handlers and these notify handlers on one
ordered workqueue? Or would you rather leave it to HP? I reported it to
HP (case 5166872861) with the acpidump, but there's been no fix so far.

Excerpt (unreliable frames and scheduler frames removed):

  INFO: task kworker/2:2:247 blocked for more than 122 seconds.
        Not tainted 7.3.6-arch1-1 #1
  task:kworker/2:2     state:D stack:0     pid:247   tgid:247   ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: kacpi_notify acpi_os_execute_deferred
   acpi_os_wait_semaphore+0x76/0x1d0
   acpi_ex_system_wait_mutex+0xb6/0x110
   acpi_ds_begin_method_execution+0xb3/0x420
   acpi_ds_call_control_method+0xae/0x4c0
   acpi_ps_parse_aml+0x3f2/0x610
   acpi_ps_execute_method+0x185/0x430
   acpi_ns_evaluate+0x196/0x5d0
   acpi_evaluate_object+0x1f4/0x470
   evaluate_odvp.isra.0+0x4c/0x240 [int3400_thermal]
   int3400_notify+0x192/0x1b0 [int3400_thermal]
   acpi_ev_notify_dispatch+0x4e/0x70
   acpi_os_execute_deferred+0x1a/0x30
  INFO: task kworker/2:2:247 blocked on a semaphore likely last held by task kworker/2:1:33130
  INFO: task kworker/2:1:33130 blocked for more than 122 seconds.
        Not tainted 7.3.6-arch1-1 #1
  task:kworker/2:1     state:D stack:0     pid:33130 tgid:33130 ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: kec_query acpi_ec_event_processor
   acpi_os_wait_semaphore+0x76/0x1d0
   acpi_ex_system_wait_mutex+0xb6/0x110
   acpi_ex_acquire_mutex_object+0x61/0x150
   acpi_ex_acquire_mutex+0x8a/0x2a0
   acpi_ex_opcode_2A_0T_1R+0x163/0x1e0
   acpi_ds_exec_end_op+0x204/0x890
   acpi_ps_parse_loop+0x13d/0xb80
   acpi_ps_parse_aml+0x419/0x610
   acpi_ps_execute_method+0x185/0x430
   acpi_ns_evaluate+0x196/0x5d0
   acpi_evaluate_object+0x1f4/0x470
   acpi_ec_event_processor+0xe5/0x130
  INFO: task kworker/2:1:33130 blocked on a semaphore likely last held by task kworker/2:2:247

The full hung_task output and the acpidump are available on request.

Thanks,
Tobias Predel
