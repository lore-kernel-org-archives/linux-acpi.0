Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792851240;
	b=aZg1DZ6fcjx1PJdJxCYsG9botmEZuiEnqE20JOpSzhU7pu0q4RAtpBkzIUd+WFyoZRrK
	 e04FZpcmi08kyZTqvHFw4PJT2X7oowYrpmEZLL4Oe9maQZ5UDyyRj3Blp5DOnl27xfvEA
	 V6gJfJymS/30NtNuheI6yhEhO8dcTq+TdXEawj90Ofjxmez2jH1NPWejzJVGk9q8YIyun
	 C4IQiB8EbyPnd+pR5qFNyjKWKyxlE9umveYTUhgYEjWcvOxFIgvgWaqX11KzDWXyOxUyP
	 haznghKMPFOTuI2GMSqMUBb0L4H484X7IOzsk5mwSNYh/pPbhehcDyIz1EcLHehoHpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
	b=VXps11y6gmr5/c3pUKTs9GTOpDwEXj4XMapTSRzF7c/vA4QwvnFwTezqIEFYpJkoNEPi
	 FtTJJpLDDbDo4zVWhx39WveW78EtgryNjlyeCTFnw2Gopdq5RDAGEKGVHB4VjvLja//J1
	 duMKwMdCJ4GSWp+km3VEwBEkwJuvLeP7TVy1FAb/hggl9cG+x4ghpOSihILxFLi8jjaUt
	 qdC0dHND9kMidxqOS9/cffpellGmT4DVsqY1iEeJSBgPXOIso2W0uJVWF9yzsQhF2BuQl
	 9hklWKePjR6VO17hrPIdE7K/L0bZbfaomsSv6t2KcSTvjCQOlhuh3SqZzrWJUEyq/3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ezdj4S4x;
	arc=fail smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58E606A31D
	for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 14:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E58E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ezdj4S4x
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1045354e87.0
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2026 07:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792851238; cv=none;
        d=google.com; s=arc-20260327;
        b=q+ONBSNd9WwHgfu8IcivxxgOcRUgi1MN0Fub1bJtnXZYtQjmczDabJBcdOsfTth/Bl
         3iD/uaT7P/mgI4N4ksT1J5w9BxsjKNc5O2FynUVXXnAG5XdKSkSW5XfzzsnKe+daqkT7
         5MOsTrllJ599uZWzBGNtzL55l/gUKphHqmSxiYS87KrEVfyB/LQP3cx1n96yy7Kre8//
         HvR39gwzlm55RrJ0WYG+SVw8PE/MhFqnV9Vxt8NS8wOPnbVq+y3bYpgC9oAErsxOcpk3
         Y62UQ/tvBOE2/ZjJiEJocfhTRlCZ4TnD22qRjH/K96AdVLcvF/RlHojBrlOwhAVTnLim
         TwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        fh=hN+O1604ulQpEmiZLWZ6GnmfBIrdQzxYVvtoSS/bbe0=;
        b=ckVPf2Kp1JDPI7m6FS7WNhbh78tPxuIT+WmdyrTlbV1qlIvaXTeeL4aQMCvDndhqkJ
         r/5lZDiz2KYX08ilsFZUQAen/sWp9xTHglznkJdKHEKBAL4ubK+csGMfYdsi7jyE5Iq+
         5j69E3+MVM6Ee9qxZvZvB2ZoeQ4/X+8hj4bESsr4zNMXnVYcxiRuf1wlnugkNixN36ow
         Oiq3mLDmjq4q5Z5/9XViw9TGLkXBC/cMdnbLL1oeKLMvkUv2xvND9qJbEQuuyAHEuUYc
         f/FwsR7Ee3DbMhSCrkNgC17uywqMMGT82ONr7Odr9h503GO9VFlXH4BRBMlEiuP43F2K
         IVrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851238; x=1793456038; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        b=Ezdj4S4xEB8h7gxc03c2uOcj/ii601I7+Cd4LQAP+csNZtwqaMJrX7yHnV/QRvc3eh
         cy5B9dqUS+Oz/fwYJJhrVqldoR3wqQnjxlmUmztY2taoA9FuiP+qznCrX4ahYkiZVZJu
         +CK4AGKWWOPfbp1ZMEtLRjpXJCu/Oz2kFxxBB2dsvUX6X0yHqRvjodQCXe61EgiHfvYY
         hMbpHMr9o/zG1nWClTKTYPQD2wyuXpHLbF10wB2AhOCIIO7GJyBE+Z/eYGPJ7wju5eYo
         fMZQIwZIRn2RVGmTi2WIrciOEUSxYeriB/lDGzOvior6snXECURFiS0d8YdclVa7uPK8
         4vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851238; x=1793456038;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b97bMXvzGRIjznY7MGqSzwOhOEqCJ6AU/b6pGdoAGpE=;
        b=WdDy302+KWJQNUpYGNFqXLv/KyVWvK+Rk8OdjR0Ds8Srpsf3Mw9d8TUShMxiDDDLj5
         m0CVlNMJJOEtF14fxGujfKByBefmxtb8Ech9sAdwyTe84yJxYCBk+FX2u+p/GgtGRwl3
         g9msG+pvAxflRpBkFXIL7DIhT2rI50+TOHfct/JAN0pJF5yFklB102raqUmhx2NG34fF
         rEqWyZABi3q1QzW9zW3gxuRglrkvL1DGwSFveu8yn+bzKEvRTkB7aU2TcbnPgOQoYhzK
         zC4jqfHLGduvfi2PmTee85E+6Q/IFb+lKWtW/S1915S6E9InO9rQmVPCFdFMcgIUhlZi
         Kxcg==
X-Gm-Message-State: AFq9FYKBzwF8thUc7pjq1gHgXCVyrzKXRvXQ+9mhn079pQ2M+iyQt7XP
	xJrQPFhDcfG8t0rlcZGS67CXORng9CbTiFDRYDC3VZdMN03mjbn+gtwI3ybDzwpaOSfwEHHxv9U
	vU0QSrIchNVLeaW8dbRqaB6UakLGZGdY=
X-Gm-Gg: AYBFou3GoPIQzAXLyQJTrFNtWMUF+d/2R6CgnQqZtOniWicfUGyowiVPQ5it15g83Fw
	cnlXuaAZd8Udd5HvqmUzgvaxBXPpOYsRjGnDfgSns22GG/ZzDQs5qxxfwYPKDeeC5Sxsi2aG3jv
	9YSvD4EuI1+juRIbClcEYXapSSx2mV1GuhDdH7Kfkk8KihRIrBlfF/n6H50r1fUHTz7ELCKuJl8
	R8Z4jJBu1r7N20GGVPCIS+5XDft6t8rFpUli1GTvbH4U5xW/lzjBjvmNMtuMjyIybdkJphrbEaC
	7oecMHV0/05Oc1ycAJ9lmD/spu3/IW9qUVvNL3WdDi1WajXwla9PX3fpDRs7n3PQZzzR3H940Lf
	MbGpe++klLVtMo3JnVALmfrpAe/7Mj27wnVyLig==
X-Received: by 2002:a05:6512:a83:b0:5bf:ae8e:ef5f with SMTP id
 2adb3069b0e04-5bfb7170240mr682770e87.5.1792851238053; Sat, 24 Oct 2026
 07:13:58 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Andrea Santin <asantin36@gmail.com>
Date: Sat, 24 Oct 2026 16:13:46 +0200
X-Gm-Features: AclHuK8rSSexd6wbySxEH-6RWmgS6VGKifIVY5kw2Vlwh1mO1AHs7PtfFqEvVSg
Message-ID: <CAG3xgg_10jdDiT3iSSQmm+hHDWmgdaSe8=DW=ddC6cE7rE_MNw@mail.gmail.com>
Subject: ACPI / HID: Lenovo Yoga 7 14AHP9 wakes immediately from s2idle via
 GPIO 12 (WACF2200)
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: ACPI / HID: Lenovo Yoga 7 14AHP9 wakes immediately from
s2idle via GPIO 12 (WACF2200)

Hello,

I would like to report an unexpected wakeup from suspend-to-idle on a
Lenovo Yoga 7 2-in-1 14AHP9 (machine type 83DK).

Hardware:
- Model: LENOVO 83DK / LNVNB161216
- CPU: AMD Ryzen 5 8640HS
- BIOS: Lenovo P9CN33WW, version 1.33, dated 2026-03-27
- Distribution: Arch Linux
- Kernel: 7.2.11-arch1-1
- Suspend mode: s2idle

Problem:
When closing the lid, the system enters s2idle but wakes up almost
immediately. This causes the lid-close suspend behavior to fail
intermittently.

With the default wakeup configuration, the kernel log contains:
- "PM: suspend entry (s2idle)"
- "Setting wake for GPIO 12 to enable"
- "PM: Triggering wakeup from IRQ 7"
- "ACPI: PM: Wakeup unrelated to ACPI SCI"
- Repeated "GPIO 12 is active" messages

IRQ 7 is handled by pinctrl_amd.

ACPI investigation:
The DSDT declares the device \\_SB.I2CC.TPNL with HID "WACF2200".
Linux binds it to the i2c_hid_acpi driver. Its ACPI _CRS declares a
GPIO interrupt on pin 0x000C (GPIO 12), Level, ActiveLow,
SharedAndWake. The device power/wakeup attribute is enabled by
default.

Workaround and test results:
Disabling wakeup for this device with:

  echo disabled | sudo tee /sys/bus/i2c/devices/i2c-WACF2200:00/power/wakeup

prevents the immediate wakeup in my tests, while the touchscreen
continues to work during normal operation. With this setting, the
laptop remains suspended until I reopen the lid. In the captured log,
timekeeping remained suspended for 43.838 seconds; the subsequent
wakeup was associated with IRQ 9, an ACPI EC GPE, and a notification
for LID0.

I repeated the test several times with the same result. I also created
a udev rule to apply the workaround at boot.

Could you advise whether this should be addressed with a
model-specific wakeup quirk for the Lenovo 83DK, or whether the
ACPI/GPIO wakeup handling should be fixed more generally? I have not
established the precise underlying cause, so I would appreciate
guidance on the appropriate subsystem and possible fix.

I can provide the relevant kernel logs and ACPI table excerpts if needed.

To solve the problem, I used AI during the troubleshooting phase,
since I don't have the necessary skills to do it myself.

Best regards,
Andrea
