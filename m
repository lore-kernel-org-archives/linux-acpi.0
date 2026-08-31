Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E775242D9B
	for <linux-acpi@vger.kernel.org>; Mon, 31 Aug 2026 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151878; cv=pass; b=NVje7eHxyDfZGBXaTMJfS2xP+1U540HD+f5d+L8GZCAsiqktXgQCEdxWmHwkJYAiMt26b98cf6SwqTBGgfrDd0pfgtqSm0LjKYCHUay9vKtNi0n6/afs3T1OX5pkpyTCQYicNA1E8csiCw8/7zByfcC3OGXvSHtf2fN11VE2lVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151878; c=relaxed/simple;
	bh=WKCcWG6M9D3HK7ksGCxvm13nQugy9jLnt/UCw0FgxC8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KVKRhOTFYMO8A2M5W2ssX0xXJ+xNGneaqcBd69Y3MyfNsHXm+ZRdGPBaFk8ofwj+4/a8hkf72jRHAewr5ddVgK1AabqbR1xzhUem00bwfY/8VEaoVUbX6XQ99C4mGNy4UU6kppjztbmjP8vuu5/uqjfb++NKIN/pHoYd3sb2LVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnHm55Or; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnHm55Or"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b396d2fb9bso1343752b6e.0
        for <linux-acpi@vger.kernel.org>; Sun, 30 Aug 2026 21:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788151876; cv=none;
        d=google.com; s=arc-20260327;
        b=D6ZvKOwULMcFoYaVQvtnl4C1Yd+0xp6gl0o/OdCYSvUvc6CloB2Tedmcmu3MyMZrF0
         sk28v0ZxhUKqnzoEwXsTTudZ/eShVJoGOajv09Gyh0ecnrH5NUg410E5iSHm/ZkIhY+f
         kza5HSLxXyCRH7DNTUWHz8fHDWB+9z8gx0Hoj2H4HvtvPKZnPCwad9TrjfmZ9dzQqUE/
         mt3cX3DENZy9w33g+v0EZEAWfuSoaPQpEJYRulCXqgSpnRMR2PMmlxep5TjCKiV+g/D8
         9FQgZsXzJSyTF9PpjsZujUi50gMiMxWubA5PYR86qNhCP0qDU2pPhVySmKqcz3WoJfvm
         Yv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=P+nFVBv9eiHP0PuDzH2ES9eH8Ohgbx/K7gKOqXMbw/Q=;
        fh=Lv1PQKCiwJhRqmUze++5uq++dc30uMjwl51IGJ8jamw=;
        b=LjuAJvYGuSX8jVkIMugKIq3AmQbo0QmvxeyD8mSgMpnyUIkm2pbGlbYZGMgMZ7gU0Z
         0025HlXWw62uZfLcy0HFWNyQ1jK5o4u+5Jsxj5jMXZgTkrfP2QY56/U3Kc16QK/rxE7I
         RSkxAw9llGIZSKfv8KjOcQwmMTgWnmHX1WhtigAVAQmE+cSHU994nEnks/kJlOng2o/1
         5efTWx9jQXg0uFohi3gE9K7rPCwdmhtGETm9d63gasDfpW2ZdPkspmdSUNMh3waJowzx
         +Qo63/K4MXrNxlEEyx1NVFSb+l3+Q//QzMwaCsMrc9o1EOK1bmaYS1EC2s0chm4l20mZ
         UtaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151876; x=1788756676; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+nFVBv9eiHP0PuDzH2ES9eH8Ohgbx/K7gKOqXMbw/Q=;
        b=HnHm55OrI5WaCAKWx+RznGnrMDJCDB27fGvX6x/n06Rlmv1yMyOZ5aAlFCBPOncMs5
         Krm5vSNtf//UgLZ6ZCdKWW2Tzg/VmmtHLFoZLMCDMLfL47wOR4XJdxf0gu0iiScSgtqG
         vOaq8MmRhw1wSW0pH1rLLFNumGlL3/znb4G1FmfwzQQxcKZBjk38g8ViW6w50XEfgA2/
         4bpA5FnsjgnI54f3LfvmfyRxxbAncZWI7cFtGHsWtTYpX/hpLChTJFQLWkIAUW0v4uue
         hoIl/6eohdyfkUhZDN5yqZaPlpXRqnI040y1c6g5Y7+Ank0x+iBwxPZsvYeRfW2H7BBy
         FoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151876; x=1788756676;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P+nFVBv9eiHP0PuDzH2ES9eH8Ohgbx/K7gKOqXMbw/Q=;
        b=B/Z0nCA+mtWV6xOBqv8DeUwSJWaViwRhwfjxU0VmaGEqB7XMvcs0ig+bK7I3UqO3AC
         knf+ZQnyunk6y3jE0AmH8l3PlxACjZZ6PQvMy7YeN5GYTL6ExFgBQX3mNmhcbidkmQYY
         9+9MyKrbOHID84+y3jlnA4gFkD/YVEohRZZaJiFZtWpiNHBGrflHvkjTaVUULt1qpv9x
         c+/8wK8mznuTg1ijQ5Cam3hYl1ezVAhRBNenckUZzLqRxdOItms06yL2ZP50CqasM7yU
         l1Xl2iW+F7f+CuQ2eBYfgJ2eEqVwNWgEcZvV/L2ZJCkeG9LdAL+Jal0wwvwY8tAULB5+
         gpXg==
X-Gm-Message-State: AFuF++mfGvYEvrCcGsmD9JAs/fndb1fzhoAPuOqw5BGokX1HbjzDba9/
	AVYhm2g8Z88oEJaHNbTm9IX1MSQPtDWfS3y0/u/qC5YgVMQfthrWizhyILxcDDLQzOP8o19P+Nw
	4cDvqvcM8wl6TdXU//xKhs//lJeb/WNyE5s2w
X-Gm-Gg: AR+sD111ecPkUtFT+IutAG1IUnKo7ZHJ//PuKNGUHXsGyYNHkpVNXio5/hsMazH1p/E
	K4q2M2fpKLrf5XKxIX/m8MxsTDIplA3J39YvPr4W0hKsW8wH/PQAJDkj+R2NA3jccIJxQI4XyHv
	vU5p7AKgjASamzZOshlA5yLoqpJDyMErB5jouNKVP7vjYHZczqvXKAL4FpGbeWIsE56hJr9Gcvn
	JeDDbFd4tKMkudh/cuUE05eVZ/wkB/GRYDlFIC4U4rbDsRXI0ENIaQBhgwirpEpOr9SuAcz7LEl
	i/JIa9rlq39Mlm9mpL1hMfmOJDzhQK5l5HGW2HEHZ0LuI0GMUJ8lnkR0jjkkB5XE0r22cZ45/Em
	6hlHBLcfdMsDA
X-Received: by 2002:a05:6808:c3e9:b0:496:301:36b9 with SMTP id
 5614622812f47-4b397ccc04amr19876180b6e.0.1788151875862; Sun, 30 Aug 2026
 21:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
Date: Mon, 31 Aug 2026 06:51:04 +0200
X-Gm-Features: AcwNN1W76nbmYjHXL0ApMDn3yFjcj57OVzxqT4-S595EIFTlZ-dxFt9DD7rHWJw
Message-ID: <CAPAw8HEMdsNN6WhizHkv2Orp2pkQ2-g009XCGFnKnhXoRhcKZQ@mail.gmail.com>
Subject: [PATCH] ACPI: osl: use vsnprintf() in acpi_os_vprintf()
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

acpi_os_vprintf() formats every ACPICA diagnostic into a 512-byte static
buffer with an unbounded vsprintf():

    static char buffer[512];

    vsprintf(buffer, fmt, args);

ACPICA interpolates table-derived namespace paths into its messages, so the
length is driven by table content. A malformed ACPI table can therefore
produce a diagnostic longer than the buffer and overwrite whatever follows
it.

From the System.map of an x86_64_defconfig build, acpi_ioremap_lock sits 624
bytes into that buffer - 112 bytes past its end - so bytes 624..631 of an
over-long message land on the mutex's owner field, which __mutex_lock() then
dereferences.

The overwritten bytes are attacker-influenced but not attacker-controlled:
they are printable ASCII from a NUL-terminated string, so the resulting
pointer is always non-canonical and always faults. This is a reliable denial
of service, not a demonstrated pointer-control primitive.

Because acpi_tb_load_namespace() parses the DSDT and every SSDT during
acpi_init(), a table supplied by firmware triggers this in PID 1 inside
do_one_initcall(), panicking the kernel before userspace exists.

Bound the write with vsnprintf(). Truncating a diagnostic is strictly better
than corrupting adjacent kernel objects.

Tested on pristine Linux 7.2.2 - tag: v7.2.2., Stock x86_64_defconfig
(no KASAN, no debug options), table supplied by firmware via
"qemu -acpitable":
[    0.022259] ACPI: SSDT 0x000000003FFE1C52 000640 (v01 _ASUS_
Notebook 00000005 MSFT 0100000D)
[    0.353684] Oops: general protection fault, probably for
non-canonical address
               0x41435f2e345f2e64: 0000 [#1] SMP NOPTI
[    0.353727] RIP: 0010:__mutex_lock.constprop.0+0xbd/0xa40
[    0.353727] RAX: 41435f2e345f2e30 RBX: 00000000fed00000
[    0.353727] R15: ffffffff8c248530
[    0.353727] Call Trace:
[    0.353727]  acpi_os_map_iomem
[    0.353727]  acpi_ex_system_memory_space_handler
[    0.353727]  acpi_ev_address_space_dispatch
[    0.353727]  acpi_ex_access_region
[    0.353727]  acpi_ex_read_data_from_field
[    0.353727]  acpi_ex_resolve_node_to_value
[    0.353727]  acpi_ds_evaluate_name_path
[    0.353727]  acpi_ps_parse_loop
[    0.353727]  acpi_ps_execute_method
[    0.354729] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000009

RAX is the corrupted owner; the faulting address is RAX + 0x34.
R15 matches acpi_ioremap_lock. On a KASAN build the overflow is
reported directly as:
BUG: KASAN: global-out-of-bounds in string.

Signed-off-by: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
---
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index ed2162a97..5b7aefb48 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -159,7 +159,7 @@ void __printf(1, 0) acpi_os_vprintf(const char
*fmt, va_list args)
 {
        static char buffer[512];

-       vsprintf(buffer, fmt, args);
+       vsnprintf(buffer, sizeof(buffer), fmt, args);

 #ifdef ENABLE_DEBUGGER
        if (acpi_in_debugger) {
