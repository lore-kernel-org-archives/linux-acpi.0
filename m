Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BF1F09A5
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943719; cv=none; b=P/RLCNWzxVLsKEmiZuOKEGd2z1NkJ6SoJ3Ydd09Gcls2+xxYOUmp/o1OctKhSnSrO/4AHAadshk09KkDFNXxz/kAcBf/YuZOLKMjH/Chtmk3g0ls2ruUb+9fp3UQedB7ToFlC3Gz8RKIRywW+lD8kqZx5+svn+y9NwcJ64By48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943719; c=relaxed/simple;
	bh=bfENr2Ga1hRaN0a0ouKuR0lDxkpzobWYOnT0p2/YsIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhMlXFX5mors8B1Cp5jDxT7NnU7TWpX/Jj/mrLRZO+YGznaDl1rTPsXGPxaHdOnhy6Qh5XfBnmRg2sY+qBEfG5deWFsng9CT7wtfAG9jRZ08lJk/Knah1m349NGOtd7ZdYOoGFhNBagB9SPWyHyzryW5wnfEuk5aqVSf/Vev2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGzR7lBx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=foP/aPAE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGzR7lBx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foP/aPAE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6hrvb2391977
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 07:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1LskRipLbvIkLFYDOw44HC9Gz57IWPaNBdNoRbXgq44=; b=MGzR7lBx1mzi7Ss9
	yuDUm9ra9bdvpSxHeBBynCFY6poaNaYv8U0I71JGO94QOGCwXODFPQzdsJ12B71d
	nCd2AUXEy0qBH6zz9epBApG1hobev+3XzPDA6FBRz/piz9wlQMHkDlFvFxVh/w4b
	Ahg0JgZeZ293hdKTeRNVBDnF19uPw9L5dtXqSovsBzi111NzRU17ad9Oc/hSf5g6
	OVZxst64/Nyb2QUVbXN48XS1a4j8Aj+rQj28K+7BsGX4Gl3A+jLA9xOno+bvwCBL
	Ix51xCpU3JzPKjpCp/q5DH2EUxty4zKGg5Qlu93eAS7LXo/6/kcEeVPpOc3+jdec
	jEN5yA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7ue7kdjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 07:55:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4031b86dso176729611cf.0
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774943716; x=1775548516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LskRipLbvIkLFYDOw44HC9Gz57IWPaNBdNoRbXgq44=;
        b=foP/aPAEU08fvqJ38UwRxnsgQwUmrVGwCteXtVPgGglqUDKEko2hiKzrPK5aoxgJsb
         5LhEF6kt/DL9PeBwp+uYsFFx/AzeYGNUW4uq77xo2A2zXh6IlNfKbej+4YbXxd7ys0Ca
         AxOdWZKprFRhsCgTdE08iiMJJphi5OhrQEkcOieHkM3ZZzAQBhR8cbY+0OaFtZoTA4f4
         Rw4ATQoPaEcK5TGNaqUv4f44pvB876cp/feS5eLO//ZMkrD9YPyl1zQ/xFXxK7CeneNj
         bZzulv/aJ9HlOmMTABR+hIFbf/F5hypNHgMFhf2oniS9OusUNspuRwHnroXQR+D3sv1j
         npQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943716; x=1775548516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LskRipLbvIkLFYDOw44HC9Gz57IWPaNBdNoRbXgq44=;
        b=DV17U5S3Pe0Bds/CLIG9lC/sFveNLUYh6zmUj/htCq9JSU8S907LF/uGBdOP/F71j0
         e/gnmN6aQyBIW0q5UwFREmQKbf3L5hTPEdGeg+1L8T93S1ZHxznbSs7FDo1EASVIr+K4
         r60SiW0dSRrPk2LGOiDcZJZ5sLnZnD5E/JEhcZ+tJVnG6cNZX/A9njraOuHNOkay8Gir
         NBNDouZDi9qUSink+dyKK4XamGla974oQqGZ504XgywqPxO0qVS3olt/ppbSAjLtISVu
         bA42+wSoKf+l0kJGOKs9u5qs3YWv5waZUS1C1sjjoZRf556Whl3Q6ekT37mlTOJMJ7HD
         DwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbDpVFoqcDFDdXbtV6bBGPN4qnbWODnqkZ1Jz96+L45yM1pjQbBN7kzPH6s5azuzwZ3tC4f1KKdpsV@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQIBAaGdY8nEcXgC/r6GlvqdNWMUfJG1cg8I5Cmh4FGvmL42f
	RKxc1k/dTylF1997LjMX5GISylCixlTBQjynthgGv0Chl3dIKU+tXKYwcGVQZkxU7IQE/1aZPYD
	M4pSJH/G4Ewvd2viXbAvAj+vbacob9tg8MyNbtJloCpifwyn9zag7MLAP8z0NESeI
X-Gm-Gg: ATEYQzxh3ggJ+KcTnBRR+lyZf2nUzED29mnnstn8zfnXh63VBsrRxU3F3dNvmA1cKiv
	4f68OUszBgzAKp5nuTPwlZYTsaFn23c4YqlClkksILC5BZbRlT4GI7ulos7io/Vj6VnLFQ7Zmfr
	6l/LWK0ftlJXbPBZuJa1/k2dcUrYgmdwwWpeMHAldL2FC/6IA4sspikPz6YGwVJ6MwS4miycRx5
	9wwiBgyZxexe3lIiI9Pdf51wzlZdVAIYkkn0anTcSOD7xDGj8m5rF7xrigBNj30QCvyqQ9jiz/C
	GJJdfDe6dKB6YH6+hvAoeff/8OKTK7jRFcgKafclMwDmoDi09/nY5ufjdgxw9FqsuCSwDUpSYwX
	Mn1CdXoMm5O+rin5HzwJGC+ELHNrfDeKmmL9UaTFJoSwddiJUwQ==
X-Received: by 2002:a05:622a:5917:b0:50b:460b:650e with SMTP id d75a77b69052e-50ba38e7652mr188112041cf.49.1774943716565;
        Tue, 31 Mar 2026 00:55:16 -0700 (PDT)
X-Received: by 2002:a05:622a:5917:b0:50b:460b:650e with SMTP id d75a77b69052e-50ba38e7652mr188111811cf.49.1774943716067;
        Tue, 31 Mar 2026 00:55:16 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:29fb:516:a90f:8dda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8a546esm12724395e9.5.2026.03.31.00.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:55:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors in devicetree
Date: Tue, 31 Mar 2026 09:55:12 +0200
Message-ID: <177494370819.4807.18152210084249335606.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3NCBTYWx0ZWRfX60WdbLMuRazY
 QKhM+yT7kWoitYBK8lryL2Tix8dPMqMmpaO2PVlDy4o+lkequDniQHQRTjlSVkxKxIFmkb2nGTi
 kaJkz7hHcDU++jyrjh8+u1rAo2hUUwq7S2PDEilPkOGI3uqMIwjotTiRSPQow50NoNqAvo0apvH
 WmHGFeNhrfZ9N8mTi9umPJMV008X5uXCTHWrAWyATqYvqqXkbk9UiQCiKH+7eaRu7LjL7Wy1E6U
 BBlzJIkydGgW8O807D6i6DT/qiDBD/wTmkgVVanLGUl4KRJZJcr0MIXBUmjye4NnTtaiJFJlXnM
 0xLnK6X170swc6Zmd1b7S2hYQspwuJunzcNJV/37rb0V/Lxa+CWwMJSJe3I4ge6dc/LdjEqxjzQ
 ywOP6HC89yiKirFcYef+UF92mSb7NxpuWy6z/dpYP7vxftCj2WBZ5O//OsN920LgbLN5bzwm7xg
 Scd5D65XNpvgQQcVpGw==
X-Proofpoint-GUID: i5vYBOxV_DuHXeSc9CuoQ7vuDGE1IYzu
X-Authority-Analysis: v=2.4 cv=G7sR0tk5 c=1 sm=1 tr=0 ts=69cb7de5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nTh72EtQ-9J6yJQhtbMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: i5vYBOxV_DuHXeSc9CuoQ7vuDGE1IYzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310074


On Thu, 26 Mar 2026 13:36:28 +0530, Manivannan Sadhasivam wrote:
> This series is the continuation of the series [1] that added the initial support
> for the PCIe M.2 connectors. This series extends it by adding support for Key E
> connectors. These connectors are used to connect the Wireless Connectivity
> devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> interfaces are left for future improvements.
> 
> [...]

Applied, thanks!

[1/8] serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      https://git.kernel.org/brgl/c/e7fef85039ccdba67d97b2a09f313aceeb6691c8
[2/8] serdev: Add an API to find the serdev controller associated with the devicetree node
      https://git.kernel.org/brgl/c/a2b4814190af5944b276c5fd708d95ea146106b3
[3/8] serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      https://git.kernel.org/brgl/c/92fa16ecad07dddc5703f7e2ff342441b04c45af
[4/8] dt-bindings: serial: Document the graph port
      https://git.kernel.org/brgl/c/1785c7bc1495e4e22377edffaf0ff8c3c697647d
[5/8] dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      https://git.kernel.org/brgl/c/5970c1dafb8adbeab5f6d9a22a4ad5b1c0067888
[7/8] power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
      https://git.kernel.org/brgl/c/0d38285a12a283e12cd589ad5bb46c6f4a8cc647
[8/8] power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth
      https://git.kernel.org/brgl/c/3f736aecbdc8e4faf2ed82c981812a6bfc76ea98

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
