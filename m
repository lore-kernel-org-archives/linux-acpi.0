Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013987;
	b=rbiJhYMPxQaYYzh6uZcAYz3a4+wMXfHBR4eM9mpDWTFRrRpMpTiOIDK3ydmvHisKnnIE
	 +Zq/n9+5Ep8fPZGlmNUeIEnBeBFuyeZu0ZaYRoDh9LyWiz2jOnxo1QRNvQRkKc7qANylf
	 e7iU9bbrfjsCw3k4lSMxXCvvLmSgrbWtYfyN8mUokvAILD1AezEVyXnPs8tH3Q77k55O+
	 rDdeR80sm9UfQn8BlW9KY5feNsdZTDCMZMeDYiWe+/wANc1VXP0ta6+wosAkdDzJiwhua
	 dmLSUJ+KBXwgr9j6iqodSi4n6VRk6rEd6J0pY7Okl2qtUU4OTH6dCpQGED71GudESCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013987;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=oTYGQvk36iQGPAlAArLgeHGW+UcTBSjIc8OCZrUQJSg=;
	b=XAInfvBKbfQg5rax1qC9tGb/yyZGnX/Rt/p3uQiEczfv66ZqqGcAnB/k9n66Pm5dOZcs
	 zNJ9IQRTh7DBovZ55cUNM5foMBH9k129KhlScwmKSyl9PibMgfn1OszYEyWpM57Q/93Dr
	 E1dNk2JfbkDVWlip9fAs4snti8q50PfPlJkZvGZjaQxFbagqnala/aFbEe4KXV90s+3OL
	 SjJG4k2m5UGp/wIfJllSgn2//j42OO0ZgftbJ6exdoluwtjMgGOpXcZUvnxNrD72a+ycY
	 e4MTVoRDL08aKtmGvSqVKjGCmCGTCB/c0u7ArJpCboXIha77h6vGvzwpFq6C454Zp8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b="AlGM3/DT";
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A8606A32A;
	Mon, 26 Oct 2026 11:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073A8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=AlGM3/DT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793013975;
	bh=oTYGQvk36iQGPAlAArLgeHGW+UcTBSjIc8OCZrUQJSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AlGM3/DTQl8HQ0H8jmo94nD6wg0E62hQzjo7Y7FZd6M5x9M7/qsbNjVBAzNB67d3s
	 gHftWMyTipQ3MtfrBQHjDg7Utxv2BmQbqsKhZ6mqFEUNio7CPWNIS3Ip6lbtdrrY5n
	 VJAcUsuasU1ql+b3srox4LINp3YTQotHcyIdP/7Y=
Received: from [127.0.1.1] ([223.66.54.214])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 68D934A9; Mon, 26 Oct 2026 19:26:13 +0800
X-QQ-mid: xmsmtpt1793013973tnyplsmk1
Message-ID: <tencent_93C673CDC6262B2846538214B73AC191A009@qq.com>
X-QQ-XMAILINFO: MrjVnytwTg24VGTozIpzo9+ldJFFUEHqgm3e1KHsSKGw2bSVWLWPbpvlmeVtwq
	 qsnuH0nxVxzhztVonbBixjM1txagmGv/3xyM28HUUr/oLd11majlebeXtt5SehtlUIJCxHy51TgW
	 5rNS3uezDY/ojEibc94Du3LThviGQ4B5d4iJ2yGdVzq1pxVZeC0/z0KcAXX6PO1j9GN43PW8GPZ7
	 z0WETsiN+JtxqJEkSGlrwe92POZRCTsAtugP7DPr1bMtYjylcg7ROZrOnNuQ91Zt9V/nNRcpPHch
	 oYAxbsV/+M8TBd8uTipTkQav4ZaqQBIL71dGH8XY9wxwM9pCOuVNVZpLyu4d/q1cn1IN/BDKsys0
	 4ZMSdHUuy7xC+aOh9o6U4Qr9q1FW2E4K8Murcqax1oKXa31M5t+UPO10Qd6FD47VJ23Dl59Tw2Tv
	 a6Q7Yg8Q751pc8rcYYR/WWG1KwK76TtU5NxPG059q9KJGRL6c/SuRlONIW6wQ4c4H17OroYq0Ti6
	 +YVxLP/yyc6gYqe2sMmsnryPA6uPbi0KFiKXFfYkaI8/Fs1knNNGVRXmf9FptHYq0yoenLUHy0GR
	 3T06uEe3q8NxyETx+7miEUd4DEKVgNoYC0tKsVw9xEOelE694GYKh59AZAdwxAE7ZwrbpSJP/yi6
	 3TdAjNhZi2v6mmGsVnDbeB7WwE+M6AeSX4dqPd4Ew+Ee66zmIbOFWFbebjX2Z2KPN6a3zD/Xf626
	 9WJoVCH5/3TFSzz7HazII4wpk3Zv03KSA+qR27q1S47pzTBQJDIir0puYqsQ0q/8pQVY5Ug0dXYg
	 j2MHr7kN4sk/p1aWx3fLNOYXVZAR0qJRU8CcaMlSnj7PFaDr9y9wdq+YJAZDphjw537ZNrolsapt
	 pwflI07QXCpGS0i/H37wenqbESzErGC2Lk1aI2Q929Apt2qu8Pt7v9//6RVZSekW4NKNL/nI5eNH
	 qYto066gGbPa7/5Ah97/HtoFTsPuKyK1w/UR0CH6zba/FFkDQFLQCbqKeOS26HIdx0fw502CNfsR
	 fyQC5zZ1ZKbMTr9sL4lit7oB1WByjO5cYwjFEar2fTri2UiWqc3zWP99Kk5jeI7bPSEITPFfgx35
	 AdUm8RKaEyfrO7A0IqqH6BOIUDFA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Wu Zhipeng <zepwu@foxmail.com>
To: Alex Yeo <alexyeo362@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject:
 [PATCH] platform/x86: panasonic-laptop: Add CF-SV1-2 platform_profile entry
Date: Mon, 26 Oct 2026 19:26:13 +0800
X-OQ-MSGID: <179301397370.9696.11423986312935963476@foxmail.com>
In-Reply-To: <20261025191300.1259541-1-alexyeo362@gmail.com>
References: <20261025191300.1259541-1-alexyeo362@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The CF-SV1-2 exposes the same CEFM/EPLE fan/TDP policy pair as the
CF-SR4, with the same boolean mapping (cool =3D active + locked, quiet =3D
passive + locked, performance =3D active + unlocked), so reuse
quirk_cf_sr4 and add only a DMI entry.  The remaining combination
(passive + unlocked) is reported as CUSTOM by get().

Measured on the unit (BIOS V2.00L24, i5-1145G7, EPP=3Dperformance, turbo
on, no userspace fan governor): the TDP toggle is the power lever (~10 W
locked vs ~26 W unlocked) and the fan toggle is a temperature lever at
essentially equal package power (active+locked 9.96 W / 50 C,
passive+locked 9.95 W / 60 C, active+unlocked 26.32 W / 84 C).

Notes for this model, because they do not generalise: the SEFM curve
bytes behind the boolean differ from CF-SR4 (0x00 cool / 0x05 quiet /
0x02 in S0i3), EPLE/SEPL select an IETM table PL rather than a fixed TDP
cap, _FST[1] is a fan setpoint and not RPM, a nonzero TFN1._FSL override
masks a profile change until released, and the EC boots at CEFM=3D0 /
EPLE=3D1 (active + locked / COOL).

Alex Yeo confirmed the cool/quiet/performance mapping for this model on
2026-10-26.

Link: https://lore.kernel.org/platform-driver-x86/20261025191300.1259541-1-al=
exyeo362@gmail.com/
Link: https://github.com/numuly/cf-sv1-2-platform-profile-evidence
Signed-off-by: Wu Zhipeng <zepwu@foxmail.com>
---
Applies on top of RFC v4 (20261025191300.1259541-1-alexyeo362@gmail.com);
the pre-image is the v4 post-image.

 drivers/platform/x86/panasonic-laptop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/p=
anasonic-laptop.c
index e929d2527fb9e04b0f9fed1abae0ed0684d9698c..69d255a0c3b07241290359bcdc7e0=
caf92c9804c 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -329,6 +329,14 @@ static const struct dmi_system_id pcc_profile_quirks[] =
=3D {
 		},
 		.driver_data =3D &quirk_cf_sr4,
 	},
+	{
+		.ident =3D "Panasonic Corporation CFSV1-2",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Panasonic Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CFSV1-2"),
+		},
+		.driver_data =3D &quirk_cf_sr4,
+	},
 	{
 		.ident =3D "Panasonic Corporation CFQV9-1",
 		.matches =3D {
--=20
2.47.3

