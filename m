Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56AC35FF6E
	for <linux-acpi@vger.kernel.org>; Mon, 13 Jul 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936102; cv=none; b=jIY49HOwNl7ExLKsd7UBWPOC3eDwF705qzihmNUsAQX1zppm1FUqTL+WnUjnU2ze+vMY8XlcUBuVRjQndcWGo92EkgsR8DEJcbDD3y8430WtNlF/fm/zIZpZCq8J1L58KBBbJL3fVcfScWgYh3IQPQVsGuSp5HlR9IkRMZQTtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936102; c=relaxed/simple;
	bh=XFk4a8jR5MWKiw4N1EsIFCpyXNg5mGbOlYoShr7F0/s=;
	h=Date:Message-Id:In-Reply-To:References:Cc:From:Subject:
	 Mime-Version:Content-Type:To; b=I6AaZfm+uJFILy/+Z5rrDp23nP6ga3nExpY/l4tEcoslgx/8volZtVrKZR4Kt0n4i2lqWBpqDkh6dT+jfdAassMVSedPC+bDumd1oO9V3Om14UoYwzbG0AziUaRpju1KlLn0Ti8oa+ChPZiLEY3W8qq+Uw1UFPDcDKglXk3wr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=trBQ3nGQ; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="trBQ3nGQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1783936088;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=XFk4a8jR5MWKiw4N1EsIFCpyXNg5mGbOlYoShr7F0/s=;
 b=trBQ3nGQ0rg3xEokiiKR7ZBvrf0VD76pUMSRs8csk453t7XgxqPy0NLUeKqbu3b98uNXiN
 wGQcJ5z+RDSZcz6zNe2AyMNG1AApTVRjMlPSASyG8lZkGe12xScsaEkp3PuLCVpK5Yi60r
 HQkXiaXNRC0+WdoAFl2bu60jwtMmiDA7lMEylgYWGgCLNi+mvYCfHvTt8xvzqfEKh5LezD
 iIwLviiFY6fmWaiM5cj+AXO4s3rzO3mCfpavDzKKboy1ZjpPzw5al9PfW27eD0QdPA8XkF
 fUSwDb/D040pcyW23UQFVHgsHkpvK8QQ4cs9YMJp1LpSweaH2Ldm1zdz4z2EnQ==
Date: Mon, 13 Jul 2026 17:48:01 +0800
Message-Id: <3cc77770-5e42-4986-bae0-2f4fe6469d7c@liuxiaozhen.dev>
X-Lms-Return-Path: <lba+26a54b456+2aceaa+vger.kernel.org+oliver@liuxiaozhen.dev>
In-Reply-To: <142193d8-3860-4d9d-acc8-5b6a0569321a@liuxiaozhen.dev>
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Content-Transfer-Encoding: quoted-printable
References: <20260711062249.503264-1-vishnuocv@gmail.com> <142193d8-3860-4d9d-acc8-5b6a0569321a@liuxiaozhen.dev>
Cc: <platform-driver-x86@vger.kernel.org>, <linux-acpi@vger.kernel.org>, 
	<ibm-acpi-devel@lists.sourceforge.net>, <mpearson-lenovo@squebb.ca>, 
	<vsankar@lenovo.com>, <hansg@kernel.org>, 
	<ilpo.jarvinen@linux.intel.com>, <oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix USB-C Security probe failure on unsupported platforms
Received: from [198.18.0.0] ([23.151.104.73]) by smtp.feishu.cn with ESMTPS; Mon, 13 Jul 2026 17:48:04 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
To: "Vishnu Sankar" <vishnuocv@gmail.com>
User-Agent: Mozilla Thunderbird

Hi Vishnu,

I tested the following two commits:

 =C2=A0platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support
 =C2=A0platform/x86: thinkpad_acpi: Fix USB-C Security probe failure on=20
unsupported platforms

The tests were performed with Linux 7.2.0-rc2 on:

Lenovo ThinkPad P15 Gen 1
BIOS N30ET47W 1.30, EC N30HT33W
Lenovo ThinkPad P50s
Machine type 20FLCTO1WW

On the ThinkPad P15 Gen 1, the firmware WMI query still produces an
AE_AML_PACKAGE_LIMIT error while evaluating _SB.WMI1.WQA0:

ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x2) is beyond
end of object (length 0x2)
ACPI Error: Aborting method _SB.WMI1.WQA0 due to previous error

However, with the probe-failure fix applied, thinkpad_acpi continues
initializing successfully. The battery extension, secondary fan control,
rfkill switch and ThinkPad extra buttons were all registered normally.

I also tested the USB-C data path with a Xiaomi Redmi Note 13 5G:

Initial device detection: PASS
Repeated unplug/replug: PASS
S3 deep suspend/resume: PASS
USB-C device detection after resume: PASS

The device was successfully enumerated again after resume. The
thinkpad_acpi module remained loaded and the kernel taint value was 0.

On the ThinkPad P50s, which does not expose the new USB-C Security
interface, thinkpad_acpi also initialized successfully. Existing
thinkpad_acpi functionality, including battery registration, rfkill,
hotkeys and suspend/resume, continued to work normally. This confirms
that an unsupported platform no longer causes the complete
thinkpad_acpi probe to fail.

I did observe existing errors on the P15 Gen 1 from the NVIDIA UCSI and
xHCI paths:

ucsi_ccg 2-0008: probe with driver ucsi_ccg failed with error -110
xhci_hcd 0000:01:00.2: xHC error in resume, USBSTS 0x401, Reinit

The test kernel was built without the NVIDIA display driver. These
messages did not prevent the ACPI UCSI Type-C ports from being created,
and did not prevent the tested USB-C device from working before or
after suspend.

Therefore, for this series:

Tested-by: Oliver Lin oliver@liuxiaozhen.dev

Thanks,
Oliver
