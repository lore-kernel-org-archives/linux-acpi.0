Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F01B4F0A
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680975; cv=none; b=ussWkstdRJ1CdH/qWdVip4bFfnwZaqUyqVGq1LMbN1ZByNfxEmnEf5p4LKaiExGC49E/RNBLerDWFyP/18iUysqsuISn99lQxky1Fd4jvsuTLsfVFVP80Bk6RHhO/JcGJEJegpxDLnToUA9237ddtxdcAQwFwXwpRNQL3unDEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680975; c=relaxed/simple;
	bh=1WNdcs5Gpsf8AQQ3hwCDXZNxCECNgyLrcTeCWS3HtQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po4A6/gsbtOojjeCecVCSR03WBiJRxcvYBQT/c6QGOpnuLSFkYFZVCZFe5HAYSMcXCiq4RkTrOO5ipWa9+xNdtc/+BN6fBi3qsLoZtoi/6I4WhUqfIEF0rmkrz/us3ZwjHtbC3WzxZ6zsM/q7Sk6ngbUFZZae2+Q1NIiaqyACJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CEi7w00V; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CEi7w00V"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 610E0BD904
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 14:22:50 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 04B91BD8F2
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 14:22:49 +0300 (EEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 937981FFAD8
	for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2026 14:22:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1790680968;
	bh=qN0ReYj7ZTDg8LS4DEPMhXSlo/3LSlmilhpS+l0dExw=;
	h=Received:From:Subject:To;
	b=CEi7w00Vz54JTxhtQtOil4Dds4a3IGmJoEeYfd+WhQpebARjq+pClZdef71IqLQr+
	 i5wTCdcVy5GAdOzPZC9zT1bxnDxkTl+HcHhNO90ZXaAN6gztzxowWeT1+C9r/MsMaY
	 sFdpBzwVjTo3mgskQthaKrI9JW2+AOp22AfcLTLvW3vC7TbatLx64Y3ioLsIQUZcoJ
	 o4Ng8lgPrgNfpbMo65bpu3NYxCJkfCY66L0SAx1bmDzQB1bkSym9Zf/2yDeG0BtH+9
	 9+KUJjpQx3O66keBN3yl/MX3vF38pMLem2eqeq0QUjsUi9VrOXCW7yblnvCdCB/T7t
	 k19zaUa1gTncw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 74.125.227.167) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj2-f39.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a47d6146d1so897189a91.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 29 Sep 2026 04:22:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwiJt2IDKgSJPo8dWSd5JCDe5HVRtHW3NOfHv/2W9HWJ4A2Ixu8mICQgZ7oeoJWQCmR49lLzzapgROk@vger.kernel.org
X-Gm-Message-State: AFq9FYIBKJWOPNqAuvcqmf4ov5hOyaZ34FLyXaa9DnEKQZtY4vRl1XcF
	C6f+vOhkS5IN8fD67qVzCXXWNAzPiJfUu9/EBf5Q1B/2BjugUXXQyABDjxJeNo86rAe7HMaFZVT
	QFpRAX4MJ9I5IYsthI1yr92a823hRp2o=
X-Received: by 2002:a17:90b:540e:b0:3a4:ac5c:1919 with SMTP id
 98e67ed59e1d1-3a4ac5c19afmr363754a91.49.1790680964966; Tue, 29 Sep 2026
 04:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260623145225.143218-1-johannes.goede@oss.qualcomm.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 29 Sep 2026 13:22:33 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwG5u6fVGqCGN6wn8816Bs1MSW4h7soAX7+k=3T8UvHLjw@mail.gmail.com>
X-Gm-Features: AclHuK-N_kkArlfU-4FCYmt0YX-fm7tZEIh1YZorpgFANORXNez-PUS0peDFSU0
Message-ID: 
 <CAGwozwG5u6fVGqCGN6wn8816Bs1MSW4h7soAX7+k=3T8UvHLjw@mail.gmail.com>
Subject: Re: [RFC 00/12] RFC: Devicetree-ACPI hybrid mode
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <179068096743.1049709.12935640974506275146@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 23 Jun 2026 at 16:52, Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Hi All,
>
> Currently as soon as the kernel boots with a populated DT provided then
> the arch/arm64 code sets acpi_disabled=1 and the complete ACPI subsystem
> gets disabled. On WoA Snapdragon laptops where the factory Windows OS
> actually boots using these tables this is not necessarily desirable.
>
> It might still be interesting to at least parse the ACPI tables and make
> the ACPI fwnodes available for device-drivers to use. I call this DT-ACPI
> hybrid mode.
>
> This mainly is an experiment for now and possibly a method for accelerating
> the ongoing effort to run Linux on currently available Snapdragon laptops.
>
> On current laptops Linux cannot boot using ACPI due to some information
> missing from the ACPI tables. People are working on changing this so that
> for future WoA Snapdragon laptops Linux can boot using ACPI only without
> requiring Devicetree.
>
>
> There are a couple of scenarios where DT-ACPI hybrid mode is useful:
>
> a) This leads to a populated /sys/firmware/acpi/tables allowing one to run
> acpidump, which is useful to grab info from the ACPI tables when e.g.
> creating a DT for a new laptop model. As a bonus /sys/firmware/acpi/bgrt
> is also populated allowing the boot-splash to show the vendor logo.
>
> b) It might be useful for device-drivers to be able to access ACPI data
> for the device even when running in DT mode. E.g. Srini Kandagatla first
> got me thinking about this because he wants to use the ACPI MIPI SDCA
> tables for audio codec routing when booting Linux on Windows Qualcomm X2
> (Glymur) laptops.
>
> c) It is also possible to go truely hybrid and use ACPI to instantiate
> some of the kernel device objects representing the hardware. For example
> the last patch in this RFC series switches to using ACPI instantiation for
> the I2C clients for the keyboard and touchpad on the Snapdragon X1E Lenovo
> ThinkPad T14s gen 6.
>
> d) This may help identify shortcomings in the current ACPI tables which
> need to be fixed to allow future laptop generations to use ACPI only.

Hi Hans,
interesting discussion.

It seems that at least for these laptops, windows relies on a PEP
(Windows specific) power driver to setup initial clocks/power rails
then ACPI for peripherals if I understood correctly.

From my understanding this is not unique to ARM? After all, from my
experience s2idle on AMD is also configured using a PEP like driver on
Windows/Linux. A lot of the AMD platforms I tested rely on triggering
a specific mailbox on the SMU to enter s2idle instead of the modern
standby dsms. This is implemented by amd_pmc. Then hw vendors use the
DSMs for additional functionality such as disabling gamepads and
keyboard backlight.

In this RFC, you propose using a DP/ACPI hybrid to have the
configuration that should be performed by a platform driver be
performed by a DT instead. But this hybrid mode is only useful to
bring up these platforms and is not expected to help in the future. So
it is a lot of refactoring for not much gain?

Therefore, have you considered if a small qualcomm driver would be
realistic / possible where all it does is setup the configuration the
same way as its windows counterpart does? Would it be too big,
cumbersome etc, not worth the squeeze, where we should just stick with
DTs for these laptops and ameliorate this deficit on the BIOS side for
future laptops instead, since I understand some Qualcomm folk are
working on making newer laptop variants ACPI only and that is great.

Best,
Antheas


>
> Upstreaming of these patches (to upstream or not to upstream?).
>
> 1. The first couple of patches in this series mainly implement a) + b) from
> above. This seems like something genuinely useful to have; and except for
> missing DT-bindings for hybrid mode this seems mostly ready to go upstream.
>
> 2. I see c) as a way to slowly evolve support for current Snapdragon laptops
> to use more and more info from ACPI and get closer to a point where we only
> need a single DT describing the SoC and any info related to laptop model
> specific bits outside of the SoC can be read from the ACPI tables.
>
> As mentioned above work is being done to have Linux boot on future laptop
> generations using ACPI only, so all this applies to currently available
> Snapdragon laptop generations only.
>
> The question is what to do wrt upstreaming patches necessary for c) though
> (patches 7-12) are we going to allow new Devicetree files for not yet
> supported laptop models to partially rely on ACPI?
>
> The current demo ACPI usage in this RFC series just instantiates I2C-HID
> devices from ACPI. More interesting would be to hookup the embedded
> controller (EC) handling in the ACPI tables instead of having to write
> a special EC driver for each laptop model separately. For the EC parts
> I believe that it might be worthwhile to implement c).
>
> This new DT-ACPI hybrid mode works as follows:
>
> 1. A new global ACPI subsys flag called acpi_dt_hybrid is introduced which
> can be set to 1 combined with acpi_disabled=1. When this is done, then
> despite acpi_disabled being set the ACPI tables will still get parsed and
> /sys/firmware/acpi (tables) and /sys/bus/acpi/devices (fwnodes) will still
> get populated. No devices will be instantiated, no fwnodes will get
> attached to any other (e.g. PCI, USB) devices and no other actions will
> be taken.
>
> 2. Add acpi=hybrid kernel-commandline option to the arch/arm64 code.
> TODO: Add a DT-binding for selecting hybrid mode from Devicetree.
>
> 3. drivers/acpi/glue.c changes to support devices with an of_node as
> primary fwnode having a "acpi-path" string property and when present look
> up the ACPI fwnode for that path, e.g. "\\_SB.GIO0", "\\_SB.I2C1" and
> set that fwnode as secondary node.
>
> 4. pinctrl-msm changes to map special WoA ACPI table virtual GPIO numbers
> for PDC pins back to regular TLMM GPIO numbers.
>
> 5. Tiny drivers/i2c/i2c-core-acpi.c change to make it instantiate ACPI
> described I2C clients under a DT instantiated I2C adapter if that
> adapter has an ACPI secondary fwnode.
>
> With this I can drop the DT description of the ThinkPad T14s gen 6
> keyboard and touchpad and instead have these be instantiated by ACPI,
> as shown in patch 12/12.
>
> Comments, thoughts ?
>
> Regards,
>
> Hans
>
>
> Hans de Goede (12):
>   ACPI: Introduce DT-ACPI hybrid mode
>   arm64: acpi: Cleanup acpi=[on|off|force] handling
>   arm64: acpi: add acpi=hybrid support
>   ACPI: Add helpers for dealing with ACPI fwnode as secondary fwnode
>   ACPI: glue: Implement setting secondary-fwnode for DT-ACPI hybrid mode
>   ACPI: scan: Retry acpi_device_notify() in DT-ACPI hybrid mode
>   ACPI: Make device_match_acpi_handle() also check the secondary fwnode
>   irqchip/gic-v3: Always call acpi_set_irq_model()
>   pinctrl: qcom: Add support for WoA ACPI tables virtual TLMM pin
>     numbers
>   i2c: acpi: Also register ACPI i2c_clients for adapters with a
>     secondary ACPI fwnode
>   i2c: qcom-geni: Fall back to i2c_acpi_find_bus_speed()
>   arm64: dts: qcom: x1e78100-thinkpad-t14s: Move keyb and touchpad to
>     ACPI enumeration
>
>  .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   |  61 +-----
>  arch/arm64/include/asm/acpi.h                 |   1 +
>  arch/arm64/kernel/acpi.c                      |  47 +++--
>  arch/loongarch/include/asm/acpi.h             |   1 +
>  arch/riscv/include/asm/acpi.h                 |   3 +-
>  arch/x86/include/asm/acpi.h                   |   1 +
>  drivers/acpi/acpi_apd.c                       |   3 +
>  drivers/acpi/acpi_memhotplug.c                |   3 +
>  drivers/acpi/acpi_processor.c                 |   3 +
>  drivers/acpi/arm64/init.c                     |   2 +
>  drivers/acpi/bus.c                            |   6 +-
>  drivers/acpi/glue.c                           |  70 ++++++-
>  drivers/acpi/property.c                       |  13 ++
>  drivers/acpi/scan.c                           |  33 +++
>  drivers/acpi/tables.c                         |   4 +-
>  drivers/base/core.c                           |   4 +-
>  drivers/firmware/efi/efi-bgrt.c               |   2 +-
>  drivers/i2c/busses/i2c-qcom-geni.c            |  10 +-
>  drivers/i2c/i2c-core-acpi.c                   |   8 +-
>  drivers/irqchip/irq-gic-v3.c                  |  29 ++-
>  drivers/pinctrl/qcom/Makefile                 |   4 +-
>  drivers/pinctrl/qcom/pinctrl-msm-acpi.c       | 196 ++++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-msm.c            |  47 ++++-
>  drivers/pinctrl/qcom/pinctrl-msm.h            |  35 ++++
>  include/acpi/acpi_bus.h                       |  16 ++
>  include/linux/acpi.h                          |  10 +
>  26 files changed, 502 insertions(+), 110 deletions(-)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-msm-acpi.c
>
> --
> 2.54.0
>

