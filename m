Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795253832;
	b=XwLfRHGteSP+ksiVUIXiBlfxqZ2Gqn3L0/6wljYIDWleQkIODGhG+geRb/CXqWy9UJ05
	 BEFLaAC/7tvqmcI0rxz69oOdvJRTi9o7WXdRAOk74AMzZgMr3MxZJ6i/t5P8G69VuwhRy
	 Bk1YYz3Om21Jn5TmWPWj9gowt+Fw3kQs/11IQPUlzaih9uj5Iehvv6kqTmjn/WHPNxF4f
	 3ZL/Sb2UKjtCfko644hgCVKYIVyq6q5/4AdbByUHf/45ukpoBDgBNrg27HY+O406zf8R0
	 T7MrYGGtrkc15R0ix+55x85BSIX7664+quXTLucAp2nAuEaYcP65cNazv5wUDNugAZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795253832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZuSymGZ4BXaXBXcW5O68ed8bMUtsN8ja2SYO3J1EHJc=;
	b=kPQkBmuNFM4XP2K85IBYqvJlWLiaCNW0BVWLR7YMXCu0gVvpKltoqn4osjat4YnpRFT9
	 qUshdpoddIoIpg1Kv5gzcfJhoGg2SIGI0IyrLrQ4uV3UYBI4Iu/1VL9GNzk21Vi97o6HM
	 MWb+B5XLuKfKkFj8jl35cQG4U/tbPypPo3Wk8Z3kdcg37BwxWcQ/iApE+3vrlIsXpC5wj
	 HCvgH4+2XLdW6RKEgltrA/BvSCelLHyc0yItWKf0ST27X8BTo7BuHecdPSEuViRzqXd3i
	 IF0cq+JS4Jk8edKFzo9acWnV1/p/Y6Dy9XiqPNquCaYmfeGc+uDJthdMVoPX72w6PlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUf5VfrK;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23F606A325
	for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 09:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C23F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUf5VfrK
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492690dd5daso1259379f8f.1
        for <linux-acpi@vger.kernel.org>; Sat, 21 Nov 2026 01:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795253830; x=1795858630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuSymGZ4BXaXBXcW5O68ed8bMUtsN8ja2SYO3J1EHJc=;
        b=wUf5VfrKUaALiMDFWECJZVwwO8uOhGSA8wHRTh31ht5ubpXd4KSGvNl7BhKcF0eFsW
         h7m69WfERS3XHnuKLe+oUOhZZ6xrInEWOi4vOd+x5uxMNdhlz744hlPZrMJ3BNelduuW
         /PuTMloYC+HUXFarUxZV7OKsxI9P88SGbwgK9fA4GJz1sbZxJADci3RPHa5k6u8TkYiB
         YEV1ip8vglYzBy01t7Noo/VZ+4r4xMisItO+B5J/kFNSOMGdj2etXBq24D4mV1gxdPk8
         v7fdgT+AZlPDBGhAbv+FER6Xu4eEZHfTQKQrzfwemCEx9fhz+7wRWEOnda0Dkt0l5eqW
         tI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795253830; x=1795858630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZuSymGZ4BXaXBXcW5O68ed8bMUtsN8ja2SYO3J1EHJc=;
        b=2wqAp/IyX3RXowavOzLexF+kMkAGHnZ3RaqDBjfWpKw7d3ADcsmj/PEiikGae9JiCe
         JBkJ2mFnRNWQG03y7fbI7qhD6/p5PwlzGgg3TVe+j0+3SgTXv4CrKgfsdTOFQunu9HeI
         lWFBELkNQfef9gv8cN0NPXDGSCv4cdDerRg5Myz09Jwxyq0QT6ORrxqxbRM4QKjR16xi
         oFJVilJwWYyobLxm+S7DUEBM+O+VTdGHboWXMSWjJ60GH+zD450ejZN7Rb8p7jyKMWk8
         Amf0ldAN9Wtlrv6Hyua2tn+3V9dwfRslC/asOdNlkZddXnZLuHJxvgd8SUACeKiA5bKW
         zDRQ==
X-Gm-Message-State: APuU4Z/XrqTWVbTz+H355lc/VEsYhaA8WZhiA9K8Txx4D4RfNqA6Fs0U
	SfA5ZNj20Gfc9fpD0evjWqsZDKjKsSPaRC2gO7FkrP1WD/IePkM4w60mZDNYTA==
X-Gm-Gg: AZFdTZc3ai+U6O0UTqZLz+DKMaA+BKBLp4ZP2n6xktzd0q3PVPpBWo6V837o6F7lq+m
	XYPNQ7zNWCZlk46B3QJ5zg4XN+WsRR+P0Cu3nyobAbQN6/RFc/KakYCs1tgcr4ciJ3o6m2GO85V
	cGNx1Op3TgV3xnz9PS1JWwqrbWIYwMeP64LGPxZM52+UjgXlQio6wAusIfNkxLR7jSfE0CtXw+F
	T7DPcYcVBHNwaVU45cpqRICFCZtsm8IhA9W2GCdKqnSKya+xs39wk2BJy1dyYB3ZZEL3t+wZhrl
	2vvh/W318mqVS+ey7uwXpzBcH2B5FzrF7yyri0bfkMEv5cX1cfaSPqPueW1QJe+mjM5DwbydpBC
	pbh82js6JT8WhVzlxPcfLEgHO88aaAiUPfv5SdAaaYNd5hNP1l87Ib210pW7RAZnFo2ZJz25SmS
	eV44fjXbUFn+ZiEkiu24t+ZC1ym7KGJIDVHwexHx/SdyoD/OIMgJarMk20Req6IvhnD4M1tnNqT
	WeYhq1yKkOxsJ2qIZogUDf0HXyig0MpEe8qDdRTQbbrtcux7VvzI403NIm6ZMQBJagp8HLmE6Sv
	hCybx3CtxpkP8jGJLqBrZSJmzkBIpOEw31zYau7+wvRR7XoEUUGn8NjXHa8YuTh6xhXPvjqq1yl
	a8aNbpsajWvoHHobgb4onmURbhPg=
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4bb88804d4dmr137546885e9.7.1795253830173;
        Sat, 21 Nov 2026 01:37:10 -0800 (PST)
Received: from archlinux.fritz.box ([178.197.200.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm238322245e9.0.2026.11.21.01.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 01:37:09 -0800 (PST)
From: Tobias Predel <tobias.predel@gmail.com>
To: linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG] HP Dragonfly G4: AML deadlock (ECMX vs. Serialized GBAP) between EC _Q08/_Q18 and int3400_notify() -> ODVP
Date: Sat, 21 Nov 2026 10:37:08 +0100
Message-ID: <20261121093708.5097-1-tobias.predel@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120191423.10876-1-tobias.predel@gmail.com>
References: <20261120191423.10876-1-tobias.predel@gmail.com>
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

A short follow-up: it happened again today (2026-11-21), now on
7.3.5-arch1-1, same BIOS 01.13.01, and despite booting with
acpi.ec_max_queries=1 (/sys/module/acpi/parameters/ec_max_queries reads 1).

This time no int3400/ODVP worker was involved. It was the EC-only variant
I suspected in my first mail: two kec_query workers deadlocked against each
other, about 67 minutes after boot.

  - kworker/10:1 waits in acpi_ds_begin_method_execution(), i.e. on the
    sync mutex of a Serialized method. This matches _Q09 holding ECMX
    and calling GBAP.
  - kworker/9:1 waits in an explicit Acquire. This matches _Q08/_Q18
    inside GBAP waiting for ECMX.

hung_task reports each one as waiting on what the other holds (excerpt
below). Behind them: six more kec_query workers, thermald
(int340x_thermal_get_zone_temp), and upowerd (acpi_battery_get_state). Every
read of .../power_supply/BAT0/uevent hung in acpi_battery_get_property().
A kworker in i915_flip was also stuck in D state, but I rebooted before
anything else happened.

Why ec_max_queries=1 did not help, as far as I can tell: the stuck workers
are per-CPU kworkers (kworker/10:1, kworker/9:1, kworker/3:0, ...), so
kec_query looks like a bound workqueue. There, max_active limits
concurrency per CPU, not globally. On this 12-thread CPU that still
allows several _Qxx methods to run at the same time. I haven't checked
this against the source, so please correct me if I'm misreading it.

If that is right:
1. Is ec_max_queries=1 meant to fully serialize EC queries? If so, would
   you take a patch that makes kec_query unbound (or ordered when
   ec_max_queries == 1)? I can write and test it.
2. Until the firmware is fixed, is there another way to fully serialize
   _Qxx evaluation on this machine?

Excerpt (unreliable frames and scheduler frames removed):

  INFO: task kworker/10:1:94 blocked for more than 122 seconds.
        Tainted: G           OE       7.3.5-arch1-1 #1
  task:kworker/10:1    state:D stack:0     pid:94    tgid:94    ppid:2      task_flags:0x4208060 flags:0x00080000
  Workqueue: kec_query acpi_ec_event_processor
   acpi_os_wait_semaphore+0x76/0x1d0
   acpi_ex_system_wait_mutex+0xb6/0x110
   acpi_ds_begin_method_execution+0xb3/0x420
   acpi_ds_call_control_method+0xae/0x490
   acpi_ps_parse_aml+0x3f2/0x610
   acpi_ps_execute_method+0x185/0x430
   acpi_ns_evaluate+0x196/0x5d0
   acpi_evaluate_object+0x1f4/0x470
   acpi_ec_event_processor+0xe5/0x130
  INFO: task kworker/10:1:94 blocked on a semaphore likely last held by task kworker/9:1:14859
  INFO: task kworker/9:1:14859 blocked for more than 122 seconds.
        Tainted: G           OE       7.3.5-arch1-1 #1
  task:kworker/9:1     state:D stack:0     pid:14859 tgid:14859 ppid:2      task_flags:0x4208060 flags:0x00080000
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
  INFO: task kworker/9:1:14859 blocked on a semaphore likely last held by task kworker/10:1:94

The full hung_task output (10 tasks) and the acpidump are available on
request.

Thanks,
Tobias Predel
