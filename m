Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895580;
	b=Y72GWg9ktl3Dv0lhrwG9VPaZOKmuQTfpdtxgzrDuDnjjyGtCK4FoFMP9Ucu0Xhomivcg
	 xUEuo1LmgxO9sPMn8JUSDldWNKJSgll6YmwRBk6IAO60wMvb+4JjJFQ7YrSkr314gL1KP
	 DVX44pZZ2EtjSAbEVCSmkc3WlV5HUcHDGAlXHdgqXV3tHHF/r8WLzYatcGXY6rAhNsk/w
	 /9OCFjkpldBWcI35vI7peFII3AOo8AO3DLqxj73gYzccIQ6dosI3sa7lk4oJ2wdOuho+n
	 o4UbQswHnGKh6wOBz1uOWI0snT2f6vNZNuadNHZJXXJR7gg67nXKCLvOQEZaBxTds2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ESeTTW6wFpKX7mVc3CHBGco8ILcDPa1w9yplxA4cLdc=;
	b=hWfhYt6FoNoIDlywMfGW3RI7bJwSL8JvGM0NMqGaEtcDPZU7tDhUBsQpmp0Xl2RU3MIL
	 Jb57RjuRdKAue8W1RybT0atad/gphyoGjAHf8XQYdMBvQRQA348U1mI/BMXTeeWKsp/xp
	 9zQOm9RpYViDyOYzhO8DbfShz8MCOCgM6fXAKLq3H2RgJu6kT/zrYjN5vBkDf/TPxtFNT
	 E4REHmFv6HpT1g4DzNEw8kpZzEz1iS2XIo7qwGNSFvr/J3hbOG6jGFNhuawo/Vlkqhysn
	 oYmMikePBxgIkr2BZ3RmQXfFTT9I/sTi7O85M23TRcQ3eWdbpfwkBy1HoVU4LUX/28A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LkoXDgvh;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1962606A32A
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 06:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1962606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LkoXDgvh
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38190551625so291616eec.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 22:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895579; x=1795500379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ESeTTW6wFpKX7mVc3CHBGco8ILcDPa1w9yplxA4cLdc=;
        b=LkoXDgvhalnAA8ouck501ae9873i5sxddH1ZKbCGscwEzF2A/N3VfDdSHGmLEzeoDR
         ZYiMAB8/oPkTNJuJOwktOWW+PknC7n/5ne41wSplSMl6O27mcyr6ETLBLve6fRE8W3yP
         U7cSHhbihugKsv1NWvUC53LppaWQU3m05TZ3w8SEhWCPrXhfbPzyfHNNLZdK879iRHUX
         1AAWlN+Bari7LWVoC53zkoQnLwzuHxP/30UlnqgNSBAH7jSuS7Q84JGg1ksbhC0uEWUu
         Ths/MyjtP3bVma/Pe8PLMTaEWi15C4SvKIOk2j/Bzv/Tc05V0ZBuyETtqefWSAjbvVvY
         vjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895579; x=1795500379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESeTTW6wFpKX7mVc3CHBGco8ILcDPa1w9yplxA4cLdc=;
        b=xpmprcNq6NdhxHeAbw1kimIuVLfGjQcWDMLNSTKhvUqGHzQL564za9/jwtUXr5oTk4
         zbaQWFq0M9LNxvnM+pZuPS86K0fR9O+ifwBkP/OzeNb3yQHU+rVopFb0u4njiB4M9cu2
         5aDvjNg6xL40dWrzKAOc9Zc6vLN/lM6P5MTzDWwZib9TItbDDk+yiIKG/MoFYVbCV7Az
         /qdlz6D6O/p//QQZhhGVspcVrzS2vqWVk4QJW9Ok5MOGv9hG9j8TYqr1g/5YqhKbANwC
         nB1AVkM0/EBDK9+fduvcwvDx2tpXkCsX69YkH8KbtdJutzTgFSftVnINrWbg5FrHfWmp
         LnUg==
X-Gm-Message-State: APuU4Z8ZVeEgSLh3KnELFMGX/2REuUkhW9R5Hu8Dzg+HhmpsJle4uLYT
	MJYL8iBq4fPzRr91YfGQMgWzJ074mJsUiTC46TQdLKOK5FHiX42ppTu983b7AxxeyrA=
X-Gm-Gg: AZFdTZdmRgHW6NtKpR+oQJHUo96CwqUbRk5jICMtoN/KeGZjfJ1eGmPEixW3FIaCdaa
	QDWvEIgw9AvADx+ZdDPQu9ZN31HzAP2DoFwNTiNy66uab/FNk18w529HHBw09mWfWer4Ixf8lnS
	hQd8LBfAmMffoy7Ym3dUdAMQY0FcZqJzgP8jIJX/pe3KIr/zdnrR0XFe1T5R2E/eckOLJFReHct
	YoTUDJdRHfZf1frHuE+eFlNhcu7v02rcKHmOALnAsZo3vPjrkh1cNXiq6yc//PbW7nXvzO8pZ85
	huq6gDqi+Wx2Wj1yYbRPniYzgdK+t2UtX957KUy94DpTWqRGK/30XdwQtMepeJrTj+U3Fo6InU7
	PoLTSy3LKBMUCrS+ggpsp1U6q97AemSx/mc6p4N0MTbujFTkTmQy/5H3UK7kpPYIu1p9Tqxwwi5
	amIOxvKuCwe39X7JHznGKpHwvwMn8es2JGgddCfEl2jcs4IA4tB4c4xshgTWONlD3rJCxLj+Q4d
	JdCMiudJ/wdPjV/G+CaV0OAQYNyqZSPeDD4HohKTYeXBJURCc0EmRnyfLm703WIth9JBXpVhWB0
	o2FbP20rfxle0sIIhAArca8tgyg47RBLmBdvYRQhy4tg+nntX4uHpQ==
X-Received: by 2002:a05:693c:40c3:b0:370:1e50:a485 with SMTP id 5a478bee46e88-379679df0a1mr13892104eec.37.1794895579022;
        Mon, 16 Nov 2026 22:06:19 -0800 (PST)
Received: from omarchy ([157.10.22.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380d5135221sm5199846eec.24.2026.11.16.22.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:06:18 -0800 (PST)
From: Jamil Khan <khanjamilahmed202@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [BUG] ACPI: EC: Samsung DMI quirk (ec_clear_on_resume) costs 2.5 s per resume and stalls s2idle on Galaxy Book4
Date: Tue, 17 Nov 2026 11:36:14 +0530
Message-ID: <20261117060614.17677-1-khanjamilahmed202@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The DMI quirk in drivers/acpi/ec.c that matches every machine with

    DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")

and calls ec_clear_on_resume() (added for Samsung Series 5/9, bugzilla 44161) misbehaves on a current
Samsung model. It sets EC_FLAGS_CLEAR_ON_RESUME and ec_event_clearing = ACPI_EC_EVT_TIMING_STATUS.

Machine: Samsung Galaxy Book4, product 750XGK, board NP750XGK-LG2IN, BIOS P11CFP.025.251116.HQ,
Intel Core 5 120U (Raptor Lake-U), s2idle only. Kernel 7.2.15.

On this machine the EC does not answer QR_EC when no event is pending. The transaction is restarted five
times and then fails, so every such query costs 5 * ec_delay = 2.5 s. Two visible effects:

1. Resume. acpi_ec_clear() always issues at least one query with nothing pending.
   The acpi-ec resume callback takes 2.5 s on every resume:

       device_pm_callback: acpi-ec PNP0C09:00 [resume]   2510 ms
       ACPI: EC: 0 stale EC events cleared

   "PM: resume of devices complete after 2509 msecs" on every cycle; nothing else is above 0.3 s.

2. s2idle on AC. Shortly after entering s2idle the EC reports fan changes (Query 0x56 -> Notify(FAN1, 0x80))
   in a burst. With the STATUS timing the driver submits more queries than there are events. With
   pm_debug_messages and dyndbg on ec.c:

       13430.605 PM: Triggering wakeup from IRQ 9
       13430.606 ACPI: EC: ACPI EC GPE dispatched
       13430.607 ACPI: EC: Query(0x56) started / stopped
       ...  (8 real queries in 3.5 s, on a 500 ms cadence)
       13434.111 ACPI: EC: Query(0x56) stopped
       13449.109 ACPI: EC: ACPI EC work flushed

   function_graph shows acpi_s2idle_wake() -> acpi_ec_dispatch_gpe() -> __acpi_ec_flush_work() blocked for
   18.5 s, and the workqueue trace shows one acpi_ec_event_handler run of 18.503 s: 6 unanswered queries of
   2.5 s each after the real ones. The system only goes back to sleep after that. On battery there are
   no fan events and the stall does not happen.

Awake, with a CPU load to generate fan events, per ec_event_clearing mode (function tracer on acpi_ec_*):

    status (set by the quirk): 19 queries submitted for 11 real events, event handler busy for the whole run
    query  (driver default)  : 14 submitted for 11 real events
    event                    :  5 submitted for  5 real events, no transaction restarts

As far as I can see the EC driver only ever issues QR_EC here: a kprobe on acpi_ec_space_handler saw no
calls across a full suspend/resume cycle, so EC RAM is not accessed through it.

Workaround in use, set at runtime because the quirk overrides the command line:

    echo query > /sys/module/acpi/parameters/ec_event_clearing
    echo 50    > /sys/module/acpi/parameters/ec_delay

Result on AC through a real suspend: 0.4 s awake in total for EC events instead of 18.5 s, and the
acpi-ec resume callback takes 261 ms instead of 2510 ms. Events (lid, Fn keys, AC) still arrive.
ec_delay only shortens the unanswered query in acpi_ec_clear(); it does not remove it.

Questions:

- Should the Samsung match be narrowed (the original report was for Series 5/9), or should newer models
  such as the Galaxy Book4 family be excluded?
- Independently of the quirk, is there a better way to handle an EC that does not answer QR_EC when
  nothing is pending than waiting 5 * ec_delay?

I can test patches on this machine and provide full traces (ftrace, dmesg with ec.c dyndbg, acpidump).

Thanks,
Jamil Khan <khanjamilahmed202@gmail.com>
