Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795170822;
	b=zHGzy1eitTk+BPAacH3/p4zuSD/dMBRs7wcmETGO7/jYsS0FEgRn36FRPwjCoCcQIODE
	 H8Gx/iivSNJfVtGN8CszubuGC10WagrGdXpVMsD80LSg/JXpWZDk3pfYJBeeBfVL2+4zS
	 PzbAEAqD1fPlCY2/fvZLY7oUTKipeyzbLIl/6FxGgL5q2FKzzdqMkbkDd4M+LMO3+KsPt
	 Sk38mBBMEifiItZsIssVRHklQZeuJ7V8nzVEHQKCGOz57ET+feBgXef0moDFYWwEp89QG
	 xIsffbj0Z6AR4fQ1NmgbhzTyiA2cK2AHBfmJOC/9yOIGqzQ6GfGADoXV/12mZMDR3yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
	b=vaQfnk5w3yIq1wzpWNqUhJMILULWr1fV5gEiSsHh9IoApMgAXGX4Te3P8zojK8UEta1y
	 ExJNa3MUq/gC/sWOI6S7mJg1ijpvINzTBLA6wzBGbjk+gLrUQ2vfVAO2xvfbxzFTenT7G
	 1c+y6MqanI/MPBggwc3wRu1fw5YuAbqFkjn6aILAvFw5lmwyYR3TPbBEsRAIGy6JBwpPt
	 HKPPEOhVc/XM1Fxy8oFtKsreWXsOvwgEdf3ypDkD4aXssM5oteVewFe/b537HjRp6TROa
	 OOAdC6rDI+no0CGVie5LBJ2uo5nGgqttlhmYTBW6/GkUIH5eDJJjcluIVHjE3v+Jb/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=clicseo.com;
	spf=none smtp.mailfrom=clicseo.com;
	dkim=pass header.d=clicseo-com.20260707.gappssmtp.com header.i=@clicseo-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j9nNkZeD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD0606A336
	for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 10:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EFD0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=clicseo.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clicseo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clicseo-com.20260707.gappssmtp.com header.i=@clicseo-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j9nNkZeD
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67be1e468a8so735479d50.0
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2026 02:33:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795170821; cv=none;
        d=google.com; s=arc-20260327;
        b=LXuUp2mBarUf0PWBwfVH3bsxIhq+w3WMdV+BgG6dQbttD+5nOsiKPCK4+CcuN2h3yn
         S55TWZZucvd5LdUS5+ihskxRz02uo8rdkgLfeWW7awBcpywdGpmTNpTI4f5NChB6e2gp
         LFPnF3PXs+AhjZw6h4XgHF9R7zPXVMHta0LCwNv6HdfJCQQUeUf5E1LczW94gxn873dI
         lqIcVdLLgvMdA/s+kMIvHxb1r3W+2Iv96iXxSd8JQ9ReXdOn1oLs/aloSZIQL6TPsJKK
         tmthtnFabi5HMUwr2vZ8JovBLTV2FFs8FmYxxRP5r5Ttswm8aRVK+dPKUYZQsCL2+3KO
         X8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
        fh=g4LCkDCG3ElvTTk1L2o3xPG7le9K0Qujm3lZomxGmtA=;
        b=Mh12dELaUJEy6VtasDvTXjIip+9hcByn7QA7lC3wwlu6bOiH4Ej2Fyc1uAg1idIsk1
         U6DYcZ5+6Lgbw0cU11u1J8P6K2YXRIIRHsJpVcPglMKH3RcKLjdexvB1a3r3MS6D+Pha
         bBEZXh8VRVC9qdONNGpic01YCqQJX6u3PRFbeJM2Xm34o6pLagiM4Duwsdq4m77yIePa
         nfUqPem0v1jK1IqhWNXSc7LSH62Qm9YHtrH2uZd6Ct+8xDSTZfeTzsKWBHzRvQZSHOVn
         DoPKl50h2lGZmdqJZiWWzrQ6wM8/Lc+acoX3h/80kx2q28XIRkHkAQL51coc7uukL1X7
         KddA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clicseo-com.20260707.gappssmtp.com; s=20260707; t=1795170821; x=1795775621; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
        b=j9nNkZeDdBKNY3+woPKfJ0pQ66f2kM+UyYLhThkF4YFs8byypohW5p0wE20vU2JuZr
         j0CNhT6Xpeschq8+92Lc/6YgEl7kHbNDb0viqj3f22ycw3bSWi2JBvJGYaqcRA1LBlYQ
         Q2XiO+4wGU3qjnHH5ajJ5u4txyVReX5PdUdKTlJUkTnsv7mwd0jXCAMd9VdiA9Vyp+2d
         bCL1miUHhRJ3N5ee3W6FCPI+5+RtWc9j5EdX57+ZkAcaNkTKjkakk/FwvF+WkvvCPZKK
         JDRXSj7R5OGKAMs65c88f5phwNToGLCZRrg2ARcIGznlb0Je+npPag5rENRTE73u9NrU
         r6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170821; x=1795775621;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
        b=f5sp0aaBdh09u0dTqQYmOBzou8akv2+qfYFJ0Uov43fB2AptAkRdPaoKiwSUMnQalm
         MMBN5AYVohvgNn9SLqeP/IgwPtz1jRjCKz76sP1kSUyw3L4Qp4obs1PWCz7FkGPdg0xY
         0l0A9QZ1q63Mwi0ZOj8KQvnbemEoblmZDqTzG61cCOU4yCBRe1JyngnjKfozw9TLEGTg
         zlx8OQrrIjrkOYIQD3PFlAdpCI5w9jPC6De80fkmGGHxxsgkVr3uA6cJnu3e3wAsSoiE
         Bj2p5JUivT9JuMr/oV7RqehiYW/FtVzNpU7WWFzVBMz5BLG7DFntlQlshwG9c1G+FNPq
         T/qQ==
X-Forwarded-Encrypted: i=1; AL+hErHG5TjkJvUHqA74QHQnISE2xpdoWF/8kBPYbQ6dzvTcmVmPYgODl71YATNvKyPZw1PIETYJrPZhuq+v@vger.kernel.org
X-Gm-Message-State: APuU4Z8xFOjVM/kGE3pStkbXuJsk5vFBcMCe39p1vSJ340nuaiLe9cSZ
	dAydQGCH5EHDMOryn3J4FVYfA0wkjFVfjR9HKaJ3xHbhTo2LsrIEM/FBkX8bVHQKpJtVLYy1R2x
	sA1JAj7eYYI8VtjIslhKmTYwBcumcxs+BEog/8D2InQ==
X-Gm-Gg: AZFdTZcHzEAggaBMzA3nKMEGhQbYooLvReBCZwCXrsPerWY41NT5yjQvLiLBSm7z8XB
	aXWyZpg7BzB/xyCiJPimX3vCiTwfiYxBVqgM5QzlzVK7Vu6VLXtiSsj0VTeZO8/Yw1VtUTtptP1
	4mzr7d9iIdx1eMz4Jsqrdf+EUKlLhxsxmhLZ645sJnKZisq0khUats9MJpGt6Mm7MdNfxm2Gn0A
	IwcCc6+0fLII96imytRD3MbkfOFoD3jSpnMJrjTSw7wFyGbAHVHU/v+KXmHOVa4/yNi7+i4OKGZ
	O5z4iJWRqS5GeXH+4FrfMt+VT8UDEvYQBHyW+S0WeO0kZIfQJH0mRqSLF0t6I1vhIchjik9WNo2
	Mu9eXeYlHH+d3SNcowKmB1y9Kn6bKKKRcOZSczRsjXwhwGM7mWXJDi56v0K+884C4yBv+KTv4kW
	pQLcclTxUuMQzXnR1FRt318HNaKXkQLOtQVHmmwvHO2gd766AQTzMsM3giZ8WMdvRoNuOeBao=
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id
 956f58d0204a3-67df4410b69mr1252882d50.55.1795170821618; Fri, 20 Nov 2026
 02:33:41 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Gabriel Giner <gabriel@clicseo.com>
Date: Fri, 20 Nov 2026 11:33:30 +0100
X-Gm-Features: AclHuK-Z7D-2DkhRgFmpnmz9P3ePO_BbhRJI67sPtSk5ZcRRRKH6AlQJm-rND9U
Message-ID: <CAKfe=PoLDuKxiQDpVB8qcuu0+1ijQvPnOb7fVzHNc2t3oiO3AQ@mail.gmail.com>
Subject: e1000e: I219 (8086:550b) on Meteor Lake ThinkPad powers the system
 back on after S5
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On a Lenovo ThinkPad T14 Gen 5 (21MM, Core Ultra 5 125U, Meteor Lake,
BIOS N47ET30W 1.19), kernel 6.18.63, the system powers itself back on
2-3 seconds after a clean poweroff. It happens on battery, with no
Ethernet cable and nothing else plugged in.

The system stays off if e1000e is not bound to the onboard I219
(00:1f.6, 8086:550b) at poweroff:

- "modprobe -r e1000e && systemctl poweroff" stays off
- "Ethernet LAN" disabled in BIOS Security > I/O Port Access stays off
- with e1000e bound it powers back on every time

Ruled out:

- WoL (systemd .link with WakeOnLan=off, confirmed applied; the
  device's power/wakeup is "disabled")
- every power/wakeup flag under /sys/bus/{pci,usb,thunderbolt}
- every /proc/acpi/wakeup entry (LID, SLPB, AWAC included)
- Thunderbolt, USB, WLAN, WWAN and Bluetooth disabled in the BIOS
- powering off through EFI ResetSystem instead of ACPI S5

The state survives a warm reboot: after "systemctl reboot", a poweroff
from the boot loader (systemd-boot), before any kernel is loaded, also
bounces back on. After a cold start the same boot loader poweroff
stays off. Hibernate (S4) stays off.

00:1f.6 has power/control=auto and is runtime-suspended (no link)
while the system is up, so at shutdown it is runtime-resumed and then
goes through e1000_shutdown(). As far as I can tell from the source,
unloading the module does the same resume and PHY power-down, yet the
system then stays off. I have not narrowed it further than that.

The same symptom is reported by others on the T14 Gen 5, P14s Gen 5
and T16 Gen 3, without a cause so far:

https://bugs.launchpad.net/bugs/2162837
https://bugs.launchpad.net/bugs/2138359

There is also an RFC patch that tries to work around it in the ACPI
poweroff path ("[PATCH RFC v3] ACPI: PM: Use EFI power off on Lenovo
ThinkPad T14 Gen 5", linux-acpi, 2026-09-02). That approach did not
help on my machine.

As a workaround I unload e1000e from a systemd unit ordered right
before systemd-poweroff.service.

I can test patches or collect more data.

lspci -vvnn -s 00:1f.6:

00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet
Connection (18) I219-LM [8086:550b] (rev 20)
Subsystem: Lenovo Device [17aa:2327]
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupts: pin E disabled, MSI(X) routed to IRQ 193
IOMMU group: 15
Region 0: Memory at ab700000 (32-bit, non-prefetchable) [disabled] [size=128K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00b38  Data: 0000
Kernel driver in use: e1000e
Kernel modules: e1000e

ethtool -i enp0s31f6:

driver: e1000e
version: 6.18.63
firmware-version: 1.1-4
expansion-rom-version:
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

Thanks,
Gabriel
