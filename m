Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC13D75A9
	for <linux-acpi@vger.kernel.org>; Tue, 11 Aug 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474570; cv=pass; b=nWsB6fr8Ad1hjKtDkgeqwRZWMDZ6DhQShmRcgzyTys858LHvnvK79XWxn1aDYZhmCY+Fm3bvastLyaG7+1ez1hcBXvUGV1WLNSB5i2eEILaZDj8rToz5AVMuVSIQVWtY2Cqsd2LV+lnzXZp94uxokawXDu8qxdZMW1BXGRZ36Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474570; c=relaxed/simple;
	bh=kDkAGR6PljlS8rVujTg0pq2FkCdeeBPJIt+uengQl0U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NqlFpXAjhPYaR3qBZ65dP4lTuAl9dCL1oSxu1MkWgqtnkcZ9CegzQFmMHvtB7WX9I49l6IqDBG+YTZT9/IrTWGpg8MnPKVu85yKqKfD8uBV0Bxj+60CBswqyGZYOYNtYeNiyqSBnsOri2AwkUCdxwCcPZHleDJNZ44onWi1Rtlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llOzXnS/; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llOzXnS/"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2a818fc4so1887321cf.2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Aug 2026 11:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786474567; cv=none;
        d=google.com; s=arc-20260327;
        b=LppyZsksYuLRCEbKeIE4UEDxL72aqfQoE5iinlnCL7uorchqo4jnqwPO54MWNYrMUm
         ZwzrW5im1po66rfxhpKkIP5NfvKAnQJbDVQ1BDoxGr71pbk7N7RYc9lA4Zdev7PlsSBi
         OrVTXy5xzFXKmmVTtYMOhTlA3dC9CYZ12zn8gUB8oEsLw07x7nOpc10g+SNaJ9iqHvZb
         4PXs6AdI68G4Zbbjx7HM1MU7pVCrb16pryrjzDc9BJaEJmtO1oL0hi57/yIY2NwLefu8
         fxCkaAaZnkAcUgO2oXZCozesklLny85ess8i+5yMm4PY/R6TO0826vaidyBzXbsWz7wR
         02vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kDkAGR6PljlS8rVujTg0pq2FkCdeeBPJIt+uengQl0U=;
        fh=Q1SPCYIfAl2zr1Gg0ryZxtFR+iCcWWDljVURULCeQHM=;
        b=GKkk0nQglqT70gbJ43G2V2t9h0gTry1qj9PGnuaD7iLWWVks9uqrXv5ediiS1RsFi0
         K7tYFm2W3KYYW8WxoX6BF/hNLq0fqrN9tr2sBPZggBj/VWVYcWso4Nv/PKczH94CADoh
         ybxQvuW8DrShOJ9ofAsZEqgXb4m1qzdmyFSUlDFWurU/cjLAHhr9XfHeOoqFGM+IetnQ
         6EzkI+ZFx6s/k2AiVp4bVJvIiudKBYgbBzcXsxGxnURiVWEMUAFLSTlle9F7sZdbk7Cx
         tXe9U2lwh9r+uLP5vTNVsiqj2deiAWh/w+JQnH5Nad1qSEzFOD7ezCLuNG494V3RE7aZ
         3IQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786474567; x=1787079367; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDkAGR6PljlS8rVujTg0pq2FkCdeeBPJIt+uengQl0U=;
        b=llOzXnS/JgO+llMXgEANBxiAXchkZ5MhQv1pMwFglTEv+ZQt2/ljaTNDMRvQwj7N89
         8Z7Ap/u6Dolg2Jh8vY/hAZjBGTZLXRFbr3IQep1OOd2TxxmDJbtsC5NVQs6n9ZtncKUL
         9Hr/jtMHjdTfpdKZozERIMkypBAQe5HQxELYA7tdwvVmMAZ1QMlGVyTOnMerRODMx0Er
         VgQLpSFuEIJfoRgmN9dw+pZ+aSlVxGUit9w9lMGGNccrILI6Y+4BVtGGHAN7+nZLPTb3
         OE4SxqHTT4dOzV3bkuxIWIroJjjnNoF3acjaCGUa6M8iQ9Rtl7cJKyYeSHUsmF3InwE4
         7xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786474567; x=1787079367;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kDkAGR6PljlS8rVujTg0pq2FkCdeeBPJIt+uengQl0U=;
        b=ZK9bm0hpwOP5x+x1FnBKKIEAOsyhh7QrGuXSPtMADDRh4UiZ111WAFNbrrBizwg8Ik
         5bTbAOQjwsnsYdmrE9ODgeJ/hGR4ZghdaYTiasKL2AEkaPCrKRCOl3uRvcLrlAkECK12
         2gGN7BJdEWAl552kPeuR/A/xMasJsxleDakrGj6pbmvxUq+8PURTrNIlp7xQW3JAixuY
         YneWEi0lVAFmHe5GyQy89teFicve81v9y2TFrXwMzfUqYycKm8IDUSenrhIPE7V6Hqv2
         vkkZbQwrOKD8YPIndIQT4ZNqf9cpnSVVPvYZoo0+STZ0BjsQy8hefL/f91Sk4ZEeQS67
         B9yQ==
X-Gm-Message-State: AOJu0Yy+E5a0KK/uFbpl/kGbgCaH2RqN4WHbPd1CGxo61No8J3IwOZ2m
	/PfM+fA7RwwDPOdkccR9HqVyBTBQlPd0zQ43CoII3VNEgmAXsP7smmsTO3jvHrLUwOirVWHDyJ8
	2LqoYEHPtRX84PDu2bk4RhXZkBLQho5pan9PvKVYim+G1
X-Gm-Gg: AR+sD13tDGvRaX9MVkIzw320/dO06UGyE6dFcGRh2Hs9OD6M+8NgZh3xqL7ALbM/sSW
	Sc2JM00QAQZlH8xuzLxng6hHqBWBzM+xMjjoLuC39y/7ElNbRP/nAxeRhUm6If7AatqMcyIBzjJ
	jutjU4esTSruO9H8az0WQi0GnhFodosospjbiCkFXS+oga2aWS6XNtGX0nY0XCdm64ogsCbehkk
	21GNxm7NNj7Sx31bFxovY0kR4ezapJcDSF6SqYx7b/MIJ0IA/2EF3glAdT/PDbImlSkyrecr2BI
	tkvGiw1qf3EwtFeW4+NEFtSX6Dd0D188BW4tI3P7YFqA
X-Received: by 2002:a05:622a:1925:b0:51c:b900:5136 with SMTP id
 d75a77b69052e-52d582b67ccmr54544831cf.0.1786474567325; Tue, 11 Aug 2026
 11:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martiya Aryan Mehr <martiya.ar@gmail.com>
Date: Tue, 11 Aug 2026 22:25:55 +0330
X-Gm-Features: AUfX_my3JfzfWKCI-3oHSwtkbEE1DX5LhM29P9JEldJQRCVs8XnCfwza9AZ5ZG4
Message-ID: <CAM-sYPpgNU+tmfHKWg0KHfVF8f-K8oaNvfYwj-vaUGsEvf1tjg@mail.gmail.com>
Subject: [BUG] Redmi Book Pro 16 2024 platform_profile write fails on Linux 7.1.7
To: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am testing Linux kernel support on a Xiaomi Redmi Book Pro 16 2024 laptop.

I found a problem with platform_profile handling on the Arch Linux 7.1.7 kernel.

Hardware:

Laptop: Xiaomi Redmi Book Pro 16 2024
Model: TM2309
CPU: Intel Core Ultra 7 155H (Meteor Lake)
BIOS: RMAMT6B0P0B0B
BIOS date: 06/10/2025


Kernel comparison:

Problematic kernel:

Linux 7.1.7-arch1-1

Reference kernel:

Linux 6.18.43-1-lts

On Linux 6.18.43 LTS the platform_profile sysfs interface is not
exposed, so the issue cannot be reproduced there.

Installed packages:

linux 7.1.7.arch1-1
linux-lts 6.18.43-1
power-profiles-daemon 0.30-1


Problem description:

On Linux 7.1.7 the platform_profile interface exists and exposes the
following profiles:

$ cat /sys/firmware/acpi/platform_profile_choices

low-power balanced balanced-performance performance


Current profile:

$ cat /sys/firmware/acpi/platform_profile

balanced


Reading the current profile works correctly, but writing some profiles fails.


Working example:

$ echo low-power | sudo tee /sys/firmware/acpi/platform_profile

Result:

low-power


Verification:

$ cat /sys/firmware/acpi/platform_profile

low-power


However, the following profiles fail:

$ echo performance | sudo tee /sys/firmware/acpi/platform_profile

Result:

performance
tee: /sys/firmware/acpi/platform_profile: Operation not supported


Same behavior with:

$ echo balanced-performance | sudo tee /sys/firmware/acpi/platform_profile

Result:

balanced-performance
tee: /sys/firmware/acpi/platform_profile: Operation not supported


The same issue causes power-profiles-daemon failure:

$ powerprofilesctl set performance

Failed to communicate with power-profiles-daemon:

Failed to activate platform driver 'platform_profile':
Failed to write to acpi_platform_profile:
Error writing '/sys/firmware/acpi/platform_profile':
Operation not supported (15)


Expected behavior:

All profiles listed in:

/sys/firmware/acpi/platform_profile_choices

should be writable successfully, especially:

balanced-performance
performance


Actual behavior:

Writable:

- low-power
- balanced

Not writable:

- balanced-performance
- performance


Module information:

Linux 7.1.7:

$ modinfo redmi_wmi

filename:
/lib/modules/7.1.7-arch1-1/kernel/drivers/platform/x86/redmi-wmi.ko.zst

srcversion:
E64350B38255B1100E64863


Linux 6.18.43 LTS:

filename:
/lib/modules/6.18.43-1-lts/kernel/drivers/platform/x86/redmi-wmi.ko.zst

srcversion:
369C9F3502463ADD78FDC0F


Dmesg information:

The laptop is detected correctly:

DMI:
XIAOMI Redmi Book Pro 16 2024/TM2309

WMI device:

input:
Redmibook WMI keys


No specific redmi_wmi error appears in dmesg.


Additional observation:

On Linux 7.1.7:

$ powerprofilesctl

performance:
CpuDriver: intel_pstate

balanced:
CpuDriver: intel_pstate
PlatformDriver: placeholder


The platform profile backend is detected but cannot switch to
performance or balanced-performance.


Possible affected components:

- drivers/platform/x86/redmi-wmi
- platform_profile framework
- processor_thermal_soc_slider
- ACPI platform profile handling


I can provide additional logs, ACPI tables, or help with testing
patches if needed.

Thank you.
