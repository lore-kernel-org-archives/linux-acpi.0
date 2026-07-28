Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A3412272;
	Tue, 28 Jul 2026 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228459; cv=none; b=N+InhAizxF3xmW+qNZWbsLxFTLD6HbbCBb7fwKrzc0oK4GznKqaANQETU2BAFnA8/+7HCQ2IABZ0TNL4DHskPgXFrB/RGvAB8pTTHVZsG2Wrd2Wu50a64QOzmPPTWGlo74+rD8Ox5j2lmJdSMPwCeKv2+MrDHKb4Mfypfaxiuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228459; c=relaxed/simple;
	bh=qjEdplqj0S9dpKOCcxVkN/tc35crYOEZADGH0H488oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlVrnMLdxsMm8H9OpLa6Y1Tt0C0yq9t6PhC7EOniEwZWhS3fdzSQSaIMgbHhPeAvohuz/IupF6An+zUd7vSQpRHV/7/yUcuzxVaKeqI2O6SEb6h09I2A7Lpjx2p1n3VGMszFpxr6TetJs0Oivo0y0MKPgFdTWzL8tZdBcdH1HE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctlf9Pr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctlf9Pr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BED91F000E9;
	Tue, 28 Jul 2026 08:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785228457;
	bh=YLNMgxu9KJ3EYns/+gkiFA9V2FZvIehbev2U1fhQ+TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ctlf9Pr67UaygTbT7ORjcpvh82jynvPx6+DM81r6y5hEEIrGbUpWubh5ldj3aqNGs
	 pqIEID0vZu7u0Dy0vj4iIUIvf1n5Sg0GXFeFys9PUmLAvGOG0tQAw7D25wp5uX4DAq
	 oX3yS5cnuTYTiK+oQUYdNtOzEKGv7M69do6YuD2Vr8nV0Hf4l/XkdSmkfx0AnA7j8m
	 HwJJ6Oc5aCIErihTBZsboy89PwrI6RNsOCbD12/bhFvUiJ1GO/nd5Z2Ql6lR8Cg6Wa
	 8J9Hit5Slh1d8B6fTt0z/6HPUwivoUq7AvePlZQwatTxvxwmtyMAy/xlFrhJOGorZa
	 WS100JMbF2bGA==
Date: Tue, 28 Jul 2026 10:47:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
Cc: Umang Chheda <umang.chheda@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ruidong Tian <tianruidong@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, faruque.ansari@oss.qualcomm.com, 
	avaneesh.dwivedi@oss.qualcomm.com
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: ras: Introduce bindings for ARM
 RAS error sources
Message-ID: <20260728-determined-lorikeet-from-tartarus-cf124e@quoll>
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
 <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>
 <f6443353-b3c5-4922-a98a-1292db381ca7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6443353-b3c5-4922-a98a-1292db381ca7@oss.qualcomm.com>

On Mon, Jul 27, 2026 at 01:51:08PM -0700, Trilok Soni wrote:
> On 7/20/2026 1:19 AM, Umang Chheda wrote:
> > new file mode 100644
> > index 000000000000..c2f4e1f8243e
> > --- /dev/null
> > +++ b/include/dt-bindings/arm/arm-ras.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef _DT_BINDINGS_ARM_RAS_H
> > +#define _DT_BINDINGS_ARM_RAS_H
> > +
> > +/* arm,group-format - error record group register window page size */
> > +#define ARM_RAS_GROUP_4K		0	/* 4 KiB,  1 ERRGSR  */
> > +#define ARM_RAS_GROUP_16K		1	/* 16 KiB, 4 ERRGSRs */
> > +#define ARM_RAS_GROUP_64K		2	/* 64 KiB, 14 ERRGSRs */
> 
> Do you want me to have different DT for 4k and 16k and 64k? This is not a right approach. 
> 

Is this page size or register window page size? If the latter, why would
device registers be a binding?

Best regards,
Krzysztof

