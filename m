Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793473831;
	b=Q4xiAXSHMmFsLeFXt7zHxNUHIeHE7CpVbEyLZm7RQGfz5a5waEihSznS38U58z6IrVX+
	 JvfI+wOToKT+XI1C1PJZhJdppFONdwFn1Qx+vPGsav0ZFbUfpePV2us0icKoqBLTZ8mjm
	 2H+Gtdt9Fs+zdDYXCXTm/hgbd3wG5PKHknyXUC1ectEobHSC388GtKT8N5WfgtfrThNEV
	 UAuzP98mmsh588HFVg8X/Kw3MnwE32/eKaTHgYOGGrumWEqEWK3zjxEXY9+ufI8dDAMl8
	 AamPm0PsKszyr4P31h8cP++d5iijW+oF6CWQ/V2ww0AAqXd7IThXY9tblgwrnmI8Tpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
	b=UbNndoIZTaVo0M5P50AjjmryezJehHJdpGWcy/c/893olrxHPR2LxZJn4wQzOxPrr/7S
	 vKHl9N2zlXtdseVSFIX/XRe4rGL0PSTlg9bx+SAq27F6/xxZGFqVSN7vFZiMDHrun2Pnw
	 OgE6IdSAY+Gc5sT1hMkgtRgwUWLm1fD70Ce9llEia8wjm/012k+lXUDn8n9f+MZBp85+Q
	 l08H4w+qrZSMIt8BAf/20XeeUpWim1B5jZJGaj1Jn/g6qfSacus5Qq1GxCRKKCtDL3Jds
	 5mq/rE8sq2/laMwV/XQVWjfNLzxMAr9z3eUmqWwl+klbYqnyb1T0/LYB6KX/7r6EkUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847B606A31E
	for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 19:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A847B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so3123688eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 31 Oct 2026 12:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1793473825; x=1794078625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
        b=M0iRGKX4ZakyHPXgwlWKQuWrbvUmrEt1k4+8j+Da6Dso/Dh7GSCRhGjVKtDYwfzJrj
         2HEAllh00C24MUCD82TGUaZz4bWnjiMTRhAzuWXvWqNUwh9NIMyFAIxSoJmQ4tgmhnAF
         F245HULIR/4UBpfnm4XNgJVWo0HiMpt1bXAuHbkJDG9vLis8pelTxr1WpUiwasUmrW+0
         9tOkzQntOI0UA8bT96YYn1nh7WxQBJCWb1rCljfbu4Ofk4oPQ7yUkax5ncCroyqti4PR
         O+aX72UPS59IWB8w+y+J4RXBJLyCiSRq72tVighCAw7INgBmnyi41FWHKGgDOpB397rH
         f/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793473825; x=1794078625;
        h=content-transfer-encoding:mime-version:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P15p9Hb5w1tBvsdlJFg638wJNRLHIyW6DyqlyUCSHFc=;
        b=Zfi43noeZsV3jKIwAF5IeUtn/dATrgIGnpqjcPizgc8wxRJ4wraEcI7MgXsoebKGnp
         5iS6nc6sRFx5LRPvPOT49dHMcChOqnuhajnf47e60P6qur1UyJ/a5vVnKlQj/ZinYJUX
         QnbzBycCOMOBoAQLb4rgS3wpo4l4TN66lQjIVKpmTr2lzGlzn7+zU4X06W+95jefXL37
         SrMnAMFsL+591gLqJImtnXwsoVbD49UU/QMS7UYMq8UP67kwUfFWWMNwmmBkqwCAut/A
         CRJ2BR7MJBhsmVGSASXQhK+ciW1BSyGrVt9KLg1idDfKvNz4OKGdX1KYujtMvQbd237+
         Hh2g==
X-Forwarded-Encrypted: i=1; AKwUvBw2z3fguhorvh4XrpN2so8RzTNDE11jfbPMPFrnQSIN/IH/Ju41UddqaRJszeca5oIPqoO8wzJmtpBT@vger.kernel.org
X-Gm-Message-State: AFq9FYIaTRf9JLgecfKbPBmzJAh/+hhYdXfc60tPaJJYvhvfkIadKmMK
	5Ej4XM6wLlLgKC2nMiWA7BikJnSxeI/u7AlZyjKNnE9zqb0H8yC7oEShFKBNdDbSyyI=
X-Gm-Gg: AYBFou1VUZTeHSAj4z8eIEOVg8Kg7gIGUnmMySCNR5RK5It923hVSc6sNYKDSzBuQDh
	X2GmCczrBCOu3tPVE1tdQy5h1/9P3QWxe88TKBG/MIhY69LkoEq3GOGki0Y7YDvhGEI3YespS7K
	RHHW5d1aDg7k4Ea2CXG72NaS7rBqsCQNW5dRhk3Kqjtm6xoDgZ6RhK4ZYd1bUdxkx4aRpUIJY0E
	Rn6Sq/xuFp3FYY/Xt8SZz3eyBxxznQp4sEmlU9NPeAb3Maedkcm02yJEQU5fiWGZxWvRJMmOxsy
	wncCs5tiDI41/epSl+C1439poRTCqwMEplh+3Zy+jgDTbHtwvUt02k/6hcBFaZNqiWgqhSSqqRn
	Z0ATYFUQzmgh1Gi5VOH1FxpOKOfQyMZoKRuL56iPdVuhbzbvuDSfLVhJaxS7thwDP443c/hoK5g
	369SBvCNcg0qClGjE1Vy41pBLSQV2YCSErAfSaOp+jeRWP4CeSs7LV8rA+Nw0YfMaWZ1bSRA22V
	j6efkbDECRTfV3v2bAOg1hnxh7PMSEfDhB3/GCzbBlYmlQeHGTvzvDe0Mlt+oWx4e33Yyt8oev7
	P+mBZvOhv0HHZao1mudjTq5ZiIXhfVQcqH0hdcKZgimDooxglnw=
X-Received: by 2002:a05:701b:4515:20b0:166:5552:780a with SMTP id a92af1059eb24-1ac5b028b11mr7948547c88.8.1793473824427;
        Sat, 31 Oct 2026 12:10:24 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm17384804c88.23.2026.10.31.12.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 12:10:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 12:10:22 -0700
Message-Id: <DMJ9ERWOMF5G.3KVDIP2QE3A7J@nexthop.ai>
Cc: "Richard Cheng" <icheng@nvidia.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Rob Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Charles Keepax" <ckeepax@opensource.cirrus.com>,
 "Richard Fitzgerald" <rf@opensource.cirrus.com>, "David Rhodes"
 <david.rhodes@cirrus.com>, "Linus Walleij" <linusw@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Len Brown" <lenb@kernel.org>, "Davidlohr Bueso"
 <dave@stgolabs.net>, "Jonathan Cameron" <jic23@kernel.org>, "Dave Jiang"
 <dave.jiang@intel.com>, "Alison Schofield" <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, "Dan Williams"
 <djbw@kernel.org>, "Ira Weiny" <iweiny@kernel.org>, "Li Ming"
 <ming.li@zohomail.com>, "Lizhi Hou" <lizhi.hou@amd.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Allan Nielsen"
 <allan.nielsen@microchip.com>, "Horatiu Vultur"
 <horatiu.vultur@microchip.com>, "Daniel Machon"
 <daniel.machon@microchip.com>, "Steen Hegelund"
 <steen.hegelund@microchip.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v13 00/10] lan966x pci device: Add support for SFPs, PCI
 part
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Herve Codina" <herve.codina@bootlin.com>
In-Reply-To: <20261012142826.159178-1-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Herve,

On Mon, Oct 12, 2026 at 04:28:14PM +0200, Herve Codina wrote:
> Patches 8 and 9 fix fw_devlink issues specific to PCI and the
> device-tree nodes created during enumeration.

We hit exactly this on x86 switch platforms with
CONFIG_PCI_DYNAMIC_OF_NODES. A driver applies a device-tree overlay
onto each Xilinx FPGA PCI endpoint and populates I2C controllers
(xiic), watchdogs and GPIO blocks. Their interrupts go through small
chained irqchips that are themselves fed by the FPGA's MSI vectors.

Without this series, fw_devlink drops every supplier link under the
synthesized PCI root bridge node ("Not linking ... might never become
dev"), so the irqchips end up with no consumers. Unbinding one of them
frees IRQ descriptors that the I2C controllers and the watchdog still
hold. We get a remove_proc_entry "removing non-empty directory 'irq/N'"
WARNING per IRQ, and the I2C controllers are dead until reboot.

With the series applied on v7.3, the device links are created (up to
32 consumers per irqchip), and unbinding an irqchip now unbinds its
consumers first. I tested on two platforms, with 2 and 3 FPGAs (4 and
7 irqchips). Repeated unload/reload of the irqchip driver was clean
every time, and everything probed again afterwards.

Tested-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Thanks,
Abdurrahman
