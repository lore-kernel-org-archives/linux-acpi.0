Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391734;
	b=abIpueI1MHfVXuOWK4DEOrn7Q5QIAx9kG3u13DiYxHFCyFyW3Lmx6sUTJSd+HxgJF+Ca
	 emE3WWFCPit3ulIiLLKHc3J4zzFfjxqy6tbU0O1Odb4/d+lhEFxDXaVdofipfF/RivmFW
	 A8nux9+cSVLcSOHj5uzI2sHRp7t75sN62FfVjTdOHvsY7QYAF5yC/anBtz272xwaF1m6M
	 CVEilx5VNXNVvjDT1TFOgw1XSXSiAluW4EZppsecM2z338pjXNwCCRE5ZsssWC88wzh5D
	 IkjsPPjtmy7AeugNbNvCyKORV2o2F1PnlwOIHj+IR2/kOCxTsYy1yFQLZDf2Pwzd21A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391734;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DoH7ZIsXpJXFetRYLlF20+LdvZo7E3uvFNET+WuFyYk=;
	b=1yQ6MQ3TkDi28Ah1XpMQ6nw7pyI2Vvs+oKMi977mbz4HhgKa/P97fYvO0LjaN3lBeoOl
	 wCRwekN3RJGVXrYFLI2b12pn0DVE/CA4XjCYdLF6sG4Y8wc3xsNKxBthEctbuCCaYWtFy
	 NPJgL85q+NIl4xUsLm8H4WFCbkM/p+b2zfmUScYP+E+z8JFai51qGBKU5MxzWx8JvH9OI
	 aBPviD4SrBxTRQIqFRerfo3ZEq5/w42ne/AzimQyqRAKwKpzvdUlFh08N2CnAlFSonSEy
	 a1QmQWWHQF1PhcUke/FsPA1W30drVnCmJ9kuJsnUOZL6u8BthPEaARVGrbmdbqbJyTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOzjLC8T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF535606A31F
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOzjLC8T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800B81F0093A
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793391733;
	bh=DoH7ZIsXpJXFetRYLlF20+LdvZo7E3uvFNET+WuFyYk=;
	h=From:Date:Subject:To:Cc;
	b=QOzjLC8TV1bzY4rvio0R/7Xxvb2ZWzdLGvSclLElPjzbxbktZtZs4hAMbQdcUP/Qk
	 zFId1uFurAZrI1QEKpHS9QGKWGpQVVXNRSdZBEwISG3vWfRxuR9auw8GbYxWlMb57S
	 +t8b/bxIwGdoHh4fwEJobqiYOTH0c1nKNQwVGGLFyL3QViaokMtF4IDbgr/Hljlm4C
	 Kqrp2YrgPZpMEPXijFPvwgMuVTr/ptkBtOGV0mfRxq29Sk/CjX1KlX7k6VJT5thhJM
	 njSGFkK/EUQogUOx/UiG53oTE/XengyymIEQjm1qs1MmmDgvS3oCenZ4xfhVLJ+K6c
	 kNLnwUVo36OxA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bccecba199so1167583e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 13:22:13 -0700 (PDT)
X-Gm-Message-State: AFq9FYK2gUsuN6OZnjFhIz+qyQ8f+NkHy7o9cN/+HQCq6D8NkZeLl/Rz
	5sAVaVgfvVv4A0Jqtle9CDUQKLdPD3CQ6Pukg+meK5JkNWXdhG0hK/ExI99ivLj91dpufLJe01z
	hULNhr1dMinjUCU/1xq7vMdNCkj41yZE=
X-Received: by 2002:a05:6512:b86:b0:5be:50f5:f789 with SMTP id
 2adb3069b0e04-5bfd95796cdmr1212390e87.45.1793391731946; Fri, 30 Oct 2026
 13:22:11 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 30 Oct 2026 21:21:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jsHWBL0901EUHMAV4ZzfAP54_W2ag8qEo_f896pG6dUg@mail.gmail.com>
X-Gm-Features: AclHuK9iRGyl88l6iIw_7GHDRD-etfBjpr9N8mSUmyQ9RL9WPyfHnvnkLV7yvKM
Message-ID: <CAJZ5v0jsHWBL0901EUHMAV4ZzfAP54_W2ag8qEo_f896pG6dUg@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.4-rc1-2

with top-most commit 3f971ee94fb57377f0a9d5a8d190d1d465ac6b80

 Merge branches 'acpi-driver' and 'acpi-sysfs'

on top of commit 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614

 Merge tag 'driver-core-7.4-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core

to receive ACPI support fixes for 7.4-rc1.

These address assorted issues in ACPI support code and work around
concurrency-related issues in AML on some platforms:

 - Separate handler locking from sysfs lifetime in the ACPI platform
   profile driver to avoid possible deadlocks due to sysfs accesses
   during driver removal (Daniel Lezcano)

 - Introduce additional locking around the evaluation of selected ACPI
   control methods in a few places to work around issues related to
   concurrency in AML on some platforms (Ali Ahmet Memi=C5=9F)

 - Address two issues reported by Sashiko in the ACPI table data sysfs
   interface (Jamie Nguyen)

 - Initialize parser_state.aml_end in acpi_install_method() properly to
   avoid out-of-bounds accesses during control method installation (Ivan
   Hu)

Thanks!


---------------

Ali Ahmet Memi=C5=9F (4):
      ACPI: utils: Add exclusive AML evaluation helpers
      ACPI: battery: Evaluate battery methods exclusively
      thermal: intel: int340x: Evaluate _TMP exclusively
      platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively

Daniel Lezcano (1):
      ACPI: platform_profile: Separate handler locking from sysfs lifetime

Ivan Hu (1):
      ACPICA: Initialize parser_state.aml_end in acpi_install_method()

Jamie Nguyen (2):
      ACPI: sysfs: Map only the requested range in acpi_data_show()
      ACPI: sysfs: Finish sysfs init when creating a table file fails

---------------

 drivers/acpi/acpica/nsxfname.c                     |  1 +
 drivers/acpi/battery.c                             | 12 ++--
 drivers/acpi/platform_profile.c                    | 82 +++++++++++++-----=
----
 drivers/acpi/sysfs.c                               | 20 +++---
 drivers/acpi/utils.c                               | 41 +++++++++++
 drivers/platform/x86/lenovo/ideapad-laptop.c       | 12 ++--
 .../intel/int340x_thermal/int3403_thermal.c        |  3 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  6 +-
 .../int340x_thermal/processor_thermal_device.c     |  2 +-
 include/acpi/acpi_bus.h                            |  7 ++
 10 files changed, 129 insertions(+), 57 deletions(-)
