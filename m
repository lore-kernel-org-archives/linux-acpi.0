Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F936F433
	for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503269; cv=pass; b=g661RNCs4OH0ZPx5vyM8cUKwZ0TBe+l2+bo84g4+9IPDyh3KW9NmwsRXwLYB21mVe3u91I3q9cA98W1ROoi2d3MN/HGK4Jjs0YPxQiKB/0F2B9m/mR4tQjSO/5fWsyxmjbapCMRMHvGbgtGzRO9zPMZZoPFZ6fTa3aAmkBJ+/CM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503269; c=relaxed/simple;
	bh=0LZsboPcQZuj5YHlQ19UcDi1HWNY6it+e5JhE4e7SJU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ekwxKhg74T2SeV2CElsOanrtePMkgrnQ8ZthTHH1WuZ9t9ma4WgOjmaRRo+kQrzR8o5cWZSO39royymlZBbxOpOWxCG9apxPNWMFD2yy/5luSEn2CFKKuDfwZEKKooIWYW52sRunQOmM5nACO13G1khZ4XiHcz6CgT/mjuYhyeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMVUuP12; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMVUuP12"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ee63e91acfso265832085a.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 May 2026 05:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778503267; cv=none;
        d=google.com; s=arc-20240605;
        b=LCtw4S0QXgjhKIbFb91z7eXchx03HCF404Af9OJ0fV2jQGJOf41YKAi2pHuMGrlIgC
         s8QHLbrqV+8u3sqMQmHTS1oZzjY5r7ejGsK+uUZ6NQkoqLppfwJ06wO2C/HLl+MdZRfe
         zkR5klupEPM+LqKEuVBDEZ30zwuFXV+0O3MDIFjErM4WIUYDU3rchQF26LYVMSvOsKmD
         dsyUTfm9SyZFFaSO9AJOAODxgr6qHZ0EMf7gNetQYF9uj3VjJPEQ9wZ4wtt6LLX/WQuD
         VIBcOmlWTC08d51xdxHN7CaIxzcTDHjsOY2Gcz0FPL0GuHv1o2yDPP7TmO6TW57IWJRw
         8x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YHqfaw88Mx/AfeOG35hJSvcOULRBzA5EkZc33uu/H/k=;
        fh=GmFy5nA39On4RWbrn/GETH8dUHq8oY5XORs93v5i3qg=;
        b=UGFlimnI2QK5KWwE1zAd2ll1S62OhVSYBFRIVYstDvm81Bau60dNq0ert6C6A2g0CE
         eFVPjn9sPqjKUPRN6TedFhxhb+bKcDx0LINjqwpUUslM1REcGx9YwZMXTb2YoLtSfPie
         7+kJ4QRLQ2Nf8gCWd3b5Y589dmbPK2G3VGLwtwflckpjhaccVqUOb+QaPAdbxxJw4ZRt
         JouaPIm4yZfQbTFKpD70tJ2zmS8Qhf+v2XfnnviIsD/hhdXDe1tSzJMJS6YEjcu6nbMU
         f+4+szwfWwWUbW4jV6GyJr/SX9MTQdzwxwM9SxWdY3lTT46zqPfHI+cwFd8bfIhfpCUJ
         HxkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778503267; x=1779108067; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YHqfaw88Mx/AfeOG35hJSvcOULRBzA5EkZc33uu/H/k=;
        b=HMVUuP12nFlkzDSuayLcXT5GwaI+uplHyYg8x8C07yZuCDLZXUQXKbs1VFHCFVfYYS
         nyn2fMkq3Dwy6fqGv6gKWIIH7lLEQKHEqO5hb9+4RpT2OJz+3zQp6VZKCuwCLWJrdhY/
         3kcZaoQj76k3cDPRooxX2DM7TLMekGEQfTQLlJsXIPZ9ppD+Ujj6nx645matqttoW3pq
         LBnQU8XSf52HJomg9ZZ65GYtlk0t3TFETtfIolk7mor313ioTIoF7jVefOIey1gwNtgw
         4I9IkaSNbNSESmOmJlgI/bRuu1kQMsYLnKlYWb5UpnJCDxCFF/Kj7XU+HEK41LIYtfIF
         KvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503267; x=1779108067;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHqfaw88Mx/AfeOG35hJSvcOULRBzA5EkZc33uu/H/k=;
        b=hKOBLJ9HUWQNgt2zMUKqyi/JSVglMAfG7gBw0lSRL9CumteMy5yusZE0fMpQHazmEU
         /wGgXWdc2dafWDklWa2mqlgJ+OrzJbJGj5bvmim+EyN6HAJUwgG3DOgQSwMhBqA9Q/yf
         t7M1wF2Jgo5Enlp9xspsQr8DcZq6SLEjvSq4DveqxR/Df5eB7tNXLGx8KXiXmztvUzPg
         vRbjMIn12+JqQhiTQqV/Zw+Ou2iJic49m4J42H2R0FuPeJv3Z0/zEkCg99aS9CgisFUM
         +3ugCKSS1ciiZoF+vNVzCrAQ4L5d6t5U/DeTuMve0VpybJriFafjYJeu9vVQ8jgRb8SZ
         Z/8A==
X-Gm-Message-State: AOJu0YyqiZyAFCk0jSnf+FAZ8fN72rVfwt/GI2D/0E4BSiOL0UKEJHbJ
	iOUxdZbaNYD9jcEL3uZpCnO3IciCUOONJidwoLHGamf0AafyIuLwp0hmtvNTh0dnGOhNJPGYG9B
	j6ZqN13WeXIFE3BaPn4Us3E3Gt2jydNN1tl7w/4Q=
X-Gm-Gg: Acq92OHRwqU7ghw0zwR7L7iVrIT/O6NLwC05QmeotvoE+GdYS51joaMF92us0OYyDBT
	z982NLaLA71FbLvXmTNNXaVe8ajdnU68wk1M8DzedQCC2EGqHXqLD7UWpBzo0TG+czmisNOhRVi
	bNovTVBq8Tp6H1sCWnUenayx1siJuCPeXFLylH3nSEzfgG1i/lVuAllrw0nETnxUkx1UQLcZ6ny
	oGx81z4icVOiVAi8THTPTQPShNPIMfL840qqhbwTYnbg3EA/lIh0VIMK3KPPsfuvQIvNs8C4O3P
	ZfFdXDiUjKBuwAZ8IY8eW2C/p/4PG4P7PcIIyjo=
X-Received: by 2002:a05:620a:410f:b0:8d7:2745:6455 with SMTP id
 af79cd13be357-904d60f65e4mr3692612985a.33.1778503266464; Mon, 11 May 2026
 05:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ilia Smolchin <alexsanya001@gmail.com>
Date: Mon, 11 May 2026 15:40:54 +0300
X-Gm-Features: AVHnY4J97Ydkknmg8qq53FBTCz0iAFFWGT6kRF5YTmU13DPXGOWGfiFRTaqZUWQ
Message-ID: <CABfPL10PfGh7m=rv9cxHQ7oUV5+x4Av2xaTCJCd8jnaR98=m6w@mail.gmail.com>
Subject: [BUG] ACPI: battery: BAT0/status oscillates Discharging<->"Not
 charging" while ADP0/online=0 on ASUS Vivobook 18 M1807HA
To: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi linux-acpi maintainers,

  Filing a brief summary of bug 221503 in case the bugzilla notification
  gets buried.

  Hardware: ASUS Vivobook 18 M1807HA (AMD Ryzen AI platform),
            BIOS M1807HA.321 (latest, 2026-01-19)
  Software: Ubuntu 26.04, kernel 7.0.0-15-generic

  Symptom: while the laptop runs on battery (ADP0/online=0),
  BAT0/status oscillates between "Discharging" and "Not charging"
  roughly every 10-20 seconds on any read of
  /sys/class/power_supply/BAT0/status. Measured rate: 11 transitions
  per 180 sec. In particular, the impossible state
  BAT0/status="Not charging" while ADP0/online=0 is observed -
  per the power-supply class documentation, "Not charging" is only
  meaningful when an AC adapter is connected.

  Downstream effect: UPower emits PropertiesChanged on every flip;
  gnome-settings-daemon plays power-plug/power-unplug sounds every
  30-120 sec while on battery. But the kernel-side defect is the
  inconsistent BAT0/status field; the userspace audio is a symptom.

  Diagnostics already collected (may save triage time):

    * BIOS update from M1807HA.318 to .321 did not change behaviour
      (11 vs 11 flips per 180 sec). Not fixable via ASUS firmware.

    * Full unload of the ASUS platform stack
      ("modprobe -r asus_armoury asus_nb_wmi mfd_aaeon asus_wmi";
      kernel confirmed "ACPI: battery: hook unregistered:
      ASUS Battery Extension" and "asus_wmi: ASUS WMI generic
      driver unloaded") did NOT change behaviour either - 12 flips
      per 180 sec with the asus stack fully detached.
      The bug is not in asus_wmi's battery extension hook.

    * Correlation between EC GPE (gpe0A, per
      "ACPI: EC: GPE=0xa" at boot) and status flips: across a
      90 sec window we saw 6 status flips and 8 GPE0A events with
      no temporal correlation - the first 3 flips occurred while
      gpe0A was completely idle. The EC does not emit
      Notify(BAT0, 0x80) on changes. The flapping is purely a
      polling artifact of _BST returning inconsistent values on
      each successive call.

    * Windows on the same hardware does not exhibit any symptom.

  Suggested kernel-side fix: a DMI-matched quirk in
  drivers/acpi/battery.c that normalises "Not charging" to
  "Discharging" whenever no AC supply is online. This matches the
  power-supply class spec and physical reality, and is independent
  of polling rate.

  Full report, sample data, 180-sec reproducer script, dmesg
  snippets, /sys/class/power_supply/BAT0/* dump, GPE counters:

    https://bugzilla.kernel.org/show_bug.cgi?id=221503

  Happy to provide acpidump / disassembled DSDT _BST method, run
  test patches, or collect additional traces on request.

  Thanks,
  Ilya
