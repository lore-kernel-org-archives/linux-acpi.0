Received: from sonic321-23.consmr.mail.ne1.yahoo.com (sonic321-23.consmr.mail.ne1.yahoo.com [66.163.185.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BF25A359
	for <linux-acpi@vger.kernel.org>; Fri, 22 May 2026 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486232; cv=none; b=JBIevX0FRxRKSHJUPzKfWzCRx6Xwz8H9gY75E44wpiidocapJuBk7UbNBxPIdNXEl068uSB/XPtFgEWmUMUcHOMpl4tAI4par4PiSOYPiap++aH1/IQQPzRRlOljw0ZNM4/u+Q0zEYgHyaflyJk3T9xZf8QJ9b4epY56KSte3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486232; c=relaxed/simple;
	bh=hAGe+EGfqWoeC+ngkFQrfpqRUbUOysALFG5vB1+E9J4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=reTW56Y1GabrtZ49t3rvFEVlL0PgPtai/FjCQ3JGGhgbYJ5CvxtbBy1eV7C3Jj1qBvijNI/YdAHDcjgJfjVabDM3E72wRDd0lxu0NefPMbA/GyQHGI1cg5O6vR0kPbsAQPZdDC80yI3CfOZ8OngXKnUL644EuBC4c19WRkNETRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sJn7NvpZ; arc=none smtp.client-ip=66.163.185.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sJn7NvpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779486230; bh=hAGe+EGfqWoeC+ngkFQrfpqRUbUOysALFG5vB1+E9J4=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=sJn7NvpZ5mMM4v6LaXkhLWMEUSykZJz4ri4Ob3ogapsQ41ZSF32cTEW+x/KCOYMTzyu1QppMAmtUldmkRMHbE9AfNLFf4/78jNBm4yc/iGYfnXIzNxzLG64T4HDwQR7DZUcKkTGv0vCeXaCnGJ9JynOo/AWEPoEJIM8spp/4/bBbkjPdj1v1FbtNj3lDX+7V/zBxDODS7SUVwe5siu7gRmNFdHWalrHbUepAz45KXScdwf6HSREm5Agc5jXSLnIbaT9mWivmERyTZUZ2OQGFkzKanFGkhbXSXCS2JmW86ioySn6uZwySc4ThX8/ZCVrrB9mv4IQAeu+gIj+tK7fBDA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779486230; bh=5FQhxOlRSXd0q68ihS/f21cuaZD1rrfhSr1+uiwT2fS=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=cVs2+LUeT8MEJC+Ce47yFvtFOQQcjCWCacgK7eGAOgOflY5uDe7OpXFgVylyH8sPhvIOOOM5A7eAccO+0IPYLGgWmRS3gTt6MlLiYKYgL0XAdhVZQvqH24+WG1WnBjt8TwLM6UqokaIZaAzjsOmVi/jwUKDHgXLj9d8QQ5wpdMnRXQ7sOFmO3I83oECoEGgd4PxvJivndC3cpClYUK1R3JB774TQc2ioYuR+cggnrmW2ZOFZZqNNvLWHYKrX6Gk+TSPLmaJuCqaXll/NFjyUld5Wmb8CyY2Qs2DbfTghoRe8KO5+J0XivTt9GgxPHif+1Urzih6Z9fBJGS25ytfrtQ==
X-YMail-OSG: EyGk_KwVM1kBxHzg9hSKT_GEs6ic8Q3u6bQsNPxzICsxj68rAnAunfWe88kS1y.
 ZhCiOAq7R_9KP.XQPR9s5MUo.n8sP1sJeUin2WCkwGF0FDcn0n26a8yn5hOu28qmFlXAy7rbwTb2
 mKRa5biyBvOm2JRMQ3ZAyp_0qtowGyCb5gIFdQyD7lBMIoYEcQPAFSMTwlGSB_iv7YmO8Az9ScZi
 094u4U7U696BoB.roto.JFseYZisjkw8yOUOHr0SYkNNjFKqpnI_lmE4.B1UJ4wk2sWaEyL9lH8g
 JYQTYWcfsvqM4fBB1Y6NyLVdlcFxvtQb_IGJyBg1K6.E_7YS9XqH9ocykZ9yEsW5qU4K2ePQQHpW
 dbIfcpvNmqz.pUJN5zKw385WPfoImZ2VVzoy48WjXZcYboId3gejYHgWMVuMjrBkLGJRA8W9C6NU
 n2dfmgCqYT3CY5TqwN35KJRkdxL2JOmQR46k3rLHfn_IEIBn3aWwPba_kuCFUs7UWjrxvJ7x9cXJ
 C84J8Z_Me0Y5qc6usfjwmm4.ShGqb3MF56W0drb.YVUTdGQbOzwcZueFhDFFS8rA5ndLpszb735p
 Y0wMaIOHgVl2HtlrQFafKBn0yniDZxqRRfN6cdjLq3jHA25jBAdhxiqwXCWT_lJvtCA4XtFdl_ml
 LpuhixDecPS98Iiu3ICzs9LoUSXtEOEZbjTQyyWtkixXdkKR2fd0xN9pvLXAA0pgor2Httbz3Iy2
 ZRTWpqalMDcUpaJW6aCNoAA3jBq51rdTErpnm1Afoq9V3rPFtbKd4qKPRoIF.iRKgWB82n75tzYb
 cZ7PV8FawtH6QmT1ylHv1ZpZW3pb35f5L.s2.GGGAu3EG60lFQzaTwAQ2Bj_3GnnjcSkU3gD4uBt
 sgg8Zq2HzjYCgnf4Ad.96CoGytm1PWTg3_j3rvgRcFk0N9f83TDjmfLbx7N8.v2mToRiD3Ur1BRK
 kFNXXH.VyDLUCSBJ6TTbtTGDG7tSm4OvT1jXtUreRaim3e54c5H.PYfMAbDtvEB84Pfre7Isv5iR
 GLl1tggMjtk6ydoSn0VUHZoagu60umt5dChzJVWA_QUNj3IAU8IC8bHXDeMFXVo.EiAXCo7wwsxW
 G9.ITH8Bl1.W2dKwhMsP_DSYqs0.ypHNsTt0WAD_AGCtyb_g13hAQDe7h5w7gSvdyLspIY5e_zqp
 JdJnjOb1o9OQLs__D_M8F.q2KISh0Y.HXTjmsCOcp6jveq7MAkSxEm72_xo_ReDNaW4EXGHku4Qy
 4Nf6jK8v4B4Z9Y8LKPOs5ZRpnDlEXyuhi7XoXi2cEp7DfDAfFrztCD06WWEdZXtX4QSlw6mOW_n.
 GtVBuCTiH2GrykglZU2X23hvnJhZ.iiUZK0y0iNHxV5_IivKdJ0v89cG066TaBXvuufMSqoDsJgb
 EU6YZT5YCY6Teb_lI3WBB8VHNXqV61gmwym92ibZET6qMa8VU5SmxLGNXB6ic17q2c8MxyFj20W8
 WSRTanPfz3BLSAo9c2Iv9VlZhz9n1Ggv.UTLd5RQ7WAWJpZP8qzFuqbxYcYvQT6tFqwI31Ym0xTF
 AWD6aLgVL35G5e9CWPApDWOrauT3OoGmduQrjTacnnecysS1iTumC8gC2WkWHyRoqo.diEHb3ioB
 6sjYi9sjS5sFXxchG5NuSYEUhwRBidkqPpKPFd4LgxrJuu53i_HoHC__r4hIXSS1X7jRRgicwG.x
 PkzlI9N8TX8.NUXWzjHy2ra0Wixf2FhsFMHeQwUcaKn824_SWKd3_WTE0eVMXMAgJfZEJTJq7tEO
 3q6INIBRnTxPcKzESzRByTJmTPMnvfntXZ6yErWz_0tv8JGSiNtuHR0DKbGfbakLKkzUJY6lepv8
 0eM3IeXAfn24boaUFD_dHhdvVFVsdC1z6KQ0DhVRlwuoED3LXoDkwFQyEyD.mKXbladdQBKsAdWv
 14fTswcj4T9zNb.RNTWkRTNU3cF.tzetG1iN_73MvBoo-
X-Sonic-MF: <sakunix@yahoo.com>
X-Sonic-ID: 17f39222-0a5d-497f-96be-47d04bf9f19f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic321.consmr.mail.ne1.yahoo.com with HTTP; Fri, 22 May 2026 21:43:49 +0000
Date: Fri, 22 May 2026 21:01:13 +0000 (UTC)
From: Manuel <sakunix@yahoo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>
Message-ID: <1725337370.4746281.1779483673193@mail.yahoo.com>
In-Reply-To: <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
References: <20260511204646.4863-1-sakunix.ref@yahoo.com> <20260511204646.4863-1-sakunix@yahoo.com> <CAJZ5v0ikd24Vj3H=2XAGwwHtBudDXJumL4H-whu1GgU-KjMnmQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Add quirk for Dell PMC memory region
 overlap
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 YMailNovation


>I'm not a big fan of this approach TBH. Adding quirks specifically to
>avoid printing spurious messages is a bit of a stretch IMV.

>Have you considered downgrading the log level of the messages in
>question to "debug" instead?

Hello Rafael,

Thank you for your feedback.

You're right, adding a quirk just to hide a spurious warning is not the best approach. I agree with your suggestion.

Instead, I will resubmit the patch changing the log level of the message from dev_warn() to dev_dbg(). That way, the message will still be available for developers when dynamic debugging is enabled, but regular users won't see it in their dmesg.

I'll prepare a v3 patch following this simpler, cleaner approach.

Thanks again for the guidance.

Best regards,



