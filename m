Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795374549;
	b=a0LrkOSU0L3Z/GHOM/+EnMOTWOuvk64XepJrwruBGTa17x4+scp8E5LqbdC8e8mQKJWK
	 OLoRCk6xR6mQtstkncIJp4h71djFQu4HlzCxe+pZ0LqbjmRy1OPnF0Jiu+146XLdIHpDb
	 1je9HRA0k0/pS3zEBtmxR3BE3A0pmocbJu4P6k+DnvPWK7x5UKcP2TZVX8T7R/Uq1VpeY
	 ACvkhrQRLHoqyqMmKXTbuqur7616LsY0f+oaBSvGv+651FaVI5bZz5UJRlu/Q82xRtNpe
	 KcOsTnV3scJNwL95Il2/QnbF+lbocAdShgYrYL/5iYlpU+siZAn57BgibOY3ExEOR/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
	b=CwFM8kk6BuTeNKpJ65GBKvgvBpcth9Z6M8BWO5loTWOUHXiIybQIve1ZrMd2uRUSIJ7q
	 ZzjuxH0hyfjGGHcFBAt7oks5u0y4/esGAvzJ3JU7Y8r3pVIHLwoWdjQ9P64lfyhkwUWCV
	 Ic7+RyHN2O7fKLqvkSOaE5rZUhcuhX3bjl3QQkeNw1T+0I/CcmDQ5pDEB7z4MKKT834IE
	 x/T0E4DGyL9i4laNG41TU32aoTCDQr01nJlL61CExxttqQ2mqdo9Luo0t1U7IWnPb6DR4
	 YqmlnlgwsOTCvyx3RJeAoubQtKYwCE/nXnaIuqgZ4dPWC5w5g+5ex4/xtEuCMDkBJMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JladkRuN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E1606A33A
	for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2026 19:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9E1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JladkRuN
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c5062bcb857so41338066b.3
        for <linux-acpi@vger.kernel.org>; Sun, 22 Nov 2026 11:09:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795374547; cv=none;
        d=google.com; s=arc-20260327;
        b=be+EpJ4AzPr+4z7Y+DsjUYe3/i2RCbH6kOcdguHXAsBScMaCbANWve8pnkUnRvuG0G
         co5x1t8mgMVXWcbM1m/ubp1JJy6iOjfrKUfxHVGpRxqjmudFTeSmxU5URguZafWurVjt
         osvGHzAZTpdJpFh5kUF9UfI8W917HihQKbdJ+8pGsrmY5dcfWpRB/qAVZqr+4/llubug
         118x77mZOEGF8Cvm8PMWIWsQtACTIu0QzMLdtZPSW8GBadyGn9wVlpw1xSKbH/9MhCll
         gLU2UYbDSYIPQL9XaGiN/PZGbUqByWGv9bG7nidmhTsmC2BefQrOqbVg3wr+RXb0sEqf
         Y8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
        fh=4XkGb3y+J9iEv1ReC4tz0PeM/H5mc3NjCDT0OsdxQDY=;
        b=C+rdH5nktQvRvdPJFjtLG18to/xa7RW3snQ6s7GSlxj+xEI47kLBtuljqyjmVtSlg/
         7u6k0LSa8dot9nwqeNeKdJYnGLD1ad8TkDGagQLRlcUAQw3hcAn/JebJYjF2sDBcv6NV
         wyjPEhlhx/Wv8dfC2MeUO/UggD+7voQbrmJ3TJtUHPvgLI5liKAYfQQ451oC5nUL/XmR
         40Ny03BqfLpEgRlykxRwTCeyp5yH5n5UnucrVuh/ZAWtwiRTqbr1myVFz8RS7GlwggwF
         nyrtGXNw5C/DeFwWcFY/Ha/8OKezxz1l7rmwUy5xHrfkrjYzjI+fWaS8SS7f7k/Q1wud
         iIMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795374547; x=1795979347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
        b=JladkRuNsh+AsdjnSi5kOQPxOAclkjeLFj5cfGt32BJLnXiis2Bjzd4Kd6JjQPCSk0
         y18f3PNeQn2wCzr3pglGbE5Y3lu+IPBf0NVFJM5gRZcgFrRoIH5hW8MRLjRr8+2mVehl
         akP7SDd5bG8x9ol2TyxiJC2yhtqNY9lQ/tZ45/XAdFy6V5osNwblPRtE+KQo9xpcD2GP
         oQ2ObcltTX4noAUGKf6ztlZqTNvX7sGK51NVqdcnmOkIb6HIeksK/t15DOZTeNZMLdiB
         FXEth/0uWswzjOExfuS36+/z3e/cSB1L1Nbt9qnAKC0Z27iQVB7kASCIYbIKCZHAZwU4
         zE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374547; x=1795979347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
        b=Y1jHCTvTs9FXgexmGwmaETFsqQX5HoWNLqPwIGH2kkNQMRcXCf09iHT0tkxOwY2F2t
         IhZ6xUev1SgHgpJYJ0Dv7pQCPjmRSShv1LdbJIzmxGm90jegJpE3wPSGqhi9RSaRqEtQ
         1o4B89/GklGC5NfsjIrxh0j4DgaVbZ+pG4h25jMQJSMf/hZD0C9+7xS6tGYBIhm5rNsq
         NyZrGom1OGhTFG1iLnNztbtEFZqttqzBYk/f8zDKxwjdiaLJdzbrj5oOkBQXV6KbF/Nc
         vUMHlEO3mKDorsPsQkHQJLndMTUBZ4K92k4M0MQupLbF9ZeJ3F1fWeZ0Z+nRn+YFYTU0
         SzSQ==
X-Gm-Message-State: APuU4Z8DRiOFHL3VQyJ4avcyEtIR6PmurrlkwanuR6NWlRY1wnf8WMqg
	SvfyL97DRfHSQT7WC87AC56ReUD3YK5uEblfA9iZH/TbMn83nFl7hRQgDzbjo0cbTSIT5d3BD3K
	ZyatjAM7sryacuXDKorEe+ls/FrGMNxA=
X-Gm-Gg: AZFdTZdEcmexqNzywAQ3y/pSvWdTIXH1DUZvGqDxIxQlLTz4DSMqL6Kot/xBNJYvCpp
	dYcASGx/+YALLuZnPW40eLrw1xcjo5E1BTEgOJVJxu1L/BIj13atMNkikypQeiBB8ee+uDHGBtP
	S0os90Ah8PfInDfGaZu8iY3r7yFfuyFxyWzoZQEuQag5GUFfd+hjKMr8mnT6aGKxXhptZ2VDdrY
	ygAGfqBqMi3sa8PwGL4+tNc307Msf32ngKwzysNmSWnQHBoFDpL0OwE8d9uDO4y5I0Wb1e0YXu0
	tFig4FesnkAYq7vB7cQLEXIOqnqq73LBDaBAv2Ez93fe8hRteV7aRn9/WsS47/pY8DJyik29FA3
	zHVAClBhQ0zuavA5jQd8FVLl8DT8g+upAUuVnhZWYRufVdoW86ILzESMZwtbeqyxjrWrpgy4Nlg
	ai8sX6qKH4J21ve6BEvuthrxlLzLkHiSUIB4VQMzTU7riLKUedWkGmsElCH428zCiip4RsSsh7h
	2zmyukojOA2ZcaS7SJfZ/IqxHqWDcehkptUbg9p
X-Received: by 2002:a05:6402:22ed:b0:6ba:b1ea:3994 with SMTP id
 4fb4d7f45d1cf-6bab1ea3a65mr739297a12.3.1795374547296; Sun, 22 Nov 2026
 11:09:07 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKfe=Pq86f11-_GJNRwCN-m_TAMu-Dc6B0RvgqVk28=waXkVow@mail.gmail.com>
In-Reply-To: <CAKfe=Pq86f11-_GJNRwCN-m_TAMu-Dc6B0RvgqVk28=waXkVow@mail.gmail.com>
From: George Kokolakis <george.kokolakis.ece@gmail.com>
Date: Sun, 22 Nov 2026 21:08:56 +0200
X-Gm-Features: Aa3M54pDBYH5_5YP0kBblreRGNzte-1MvevIdDloABJWZtDsbnl1nNqNWjTdzKc
Message-ID: <CAKhuk+kK90gTr1AgG-B+MrxtZ9N8K91B+1v4xcjA5zD_JpPT-Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3] ACPI: PM: Use EFI power off on Lenovo ThinkPad T14
 Gen 5
To: Gabriel Giner <gabriel@clicseo.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Could you try "modprobe -r e1000e" before poweroff on your 21ML? If it
> also stays off there, the quirk probably belongs in e1000e rather than
> in the ACPI poweroff path.

It stays off. 21ML, BIOS N47ET30W 1.19, I219-LM 8086:550b, kernel
7.0.0-43-generic, my EFI module unloaded (plain ACPI S5):

  modprobe -r e1000e && systemctl poweroff
  - boot that followed a "systemctl reboot": powered back on within a minut=
e
  - next boot (cold start after that bounce): stayed off

Same warm-reboot carry-over you saw; it also explains why my EFI
workaround passed some tests and failed others.

Interim workaround here: a systemd-shutdown hook that unbinds 00:1f.6
from e1000e before both reboot and poweroff. reboot -> poweroff now
stays off with plain ACPI S5.

Rafael, please drop this patch. Adding the Intel wired LAN maintainers.

Thanks,
George

=CE=A3=CF=84=CE=B9=CF=82 =CE=A0=CE=B1=CF=81 20 =CE=9D=CE=BF=CE=B5 2026 =CF=
=83=CF=84=CE=B9=CF=82 12:25=E2=80=AF=CE=BC.=CE=BC., =CE=BF/=CE=B7 Gabriel G=
iner
<gabriel@clicseo.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> Hi George,
>
> I see the same power-on after S5 on a ThinkPad T14 Gen 5 (21MM, Core
> Ultra 5 125U, BIOS N47ET30W 1.19, kernel 6.18.63). An EFI power off
> handler, built as a module along the lines of this patch, did not help
> here either.
>
> On my machine it depends on e1000e being bound to the onboard I219
> (00:1f.6, 8086:550b) at poweroff:
>
> - "modprobe -r e1000e && systemctl poweroff" stays off
> - "Ethernet LAN" disabled in BIOS Security > I/O Port Access stays off
> - with e1000e bound it powers back on every time, without a cable and
>   on battery
>
> Ruled out here:
>
> - WoL (systemd .link with WakeOnLan=3Doff, confirmed applied)
> - every power/wakeup flag under /sys/bus/{pci,usb,thunderbolt}
> - every /proc/acpi/wakeup entry (LID, SLPB, AWAC included)
> - Thunderbolt, USB, WLAN, WWAN and Bluetooth disabled in the BIOS
> - xhci_hcd.quirks=3D0x42000
>
> The state survives a warm reboot: after "systemctl reboot", a poweroff
> from the boot loader (systemd-boot) also bounces back on, while after a
> cold start the same boot loader poweroff stays off. Hibernate (S4)
> stays off.
>
> 00:1f.6 has power/control=3Dauto and is runtime-suspended while the
> system is up, so at shutdown it is runtime-resumed and then goes
> through e1000_shutdown(). I have not narrowed it further than that.
>
> Could you try "modprobe -r e1000e" before poweroff on your 21ML? If it
> also stays off there, the quirk probably belongs in e1000e rather than
> in the ACPI poweroff path. I can test patches or collect more data.
>
> Thanks,
> Gabriel
