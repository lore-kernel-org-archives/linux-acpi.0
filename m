Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B1353EDF
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jul 2026 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654425; cv=pass; b=kvrziOm19ZDyKaHPBp/pXPTU5+zD4L0cqPM15MJdoGgN+PXvTnPTj31igmc60ccOZq7qK/l6WDBK/ReFyYtJkw91iXndryBPDvs38/tDfw+SSddZ07BajlpKLXC0aQdqaaBGbqjLOGLHjeAhI5QqQkzTLJzr0AOvNhuQ36lx5Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654425; c=relaxed/simple;
	bh=7AF8MvrHg1SOY061DM3pmobhSmgDsEH6yfBsDgTLZWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN811RpTG+v71HcpE0XuMxeFmab9WOCn7FDl7mDto73Dl4irKjsmBgkf8/j25XgGcNDq+vytANpWgwXgP8iShWGJIb6d0mAvYB3UmBxjO7QP44LdPOr6ju3aKaN0x9zA397DVJ5DIKOjgTvZ86IhKgIBk7M6vMKQ5XeQrdPePCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW7YNB7V; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW7YNB7V"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aea0fff535so495715e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jul 2026 20:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783654422; cv=none;
        d=google.com; s=arc-20260327;
        b=b6Gep+UmgF3PTiehjMDOqmGSUD+9O31NSO6T2muKgSwrPvxEPDnsdKDHzPpKqHlw+y
         x155v/LgV730/UdF4asnzXI8TV4AHtpF0EztTO39J673r929hKmPhTDMAMqGNbZI2E3G
         xx/53MIX21Izlv2F6D5MkT1lascHFSG59M7NkdlKYWkOosz2X9IePGeKkMZ040WJyHJO
         bp5dby5Fs+RVm1HHQ1525RGKxi+ulizRI6THwXEbQ0bXdU6fO7mRtCiTLGBoFULnfu4M
         uQJebcRXyyaCkGhyRFFvnRky9TG6mSLasmmobIPv7KDbgDbeOo78U7KAzADI21fb0vHl
         f/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vcKE/1zZV4FR8Gq7PnI9d2/vs9rDhLuQyTr8HFgxCkk=;
        fh=Nt4B9g7yZNAItGCNwsKoZ2PVuV0JD0gQUI05CPo6iSQ=;
        b=Gki1SxoMEcdqarSIMcgP/Qff3RwoPU4SwF9vLZ+p7lcAvpgjwKoAx/peY3DvOP93vW
         UJZyqOAOgdH0Tsva6oSXuNCHJFFL+eiF/PIPIVkpJLZBF/j3AjoO2ZrDJp0SwkjRo4lY
         XXNC/UWWMO6opn0CKtZIuQYf/fTWAK9NpOdhVts/u/kAr+XxU3/pfghc9a7JLYFIrtMp
         pSQlWTB4LJkpIwz3cB/bL++NKD9DIzzUO2L4Z7iUIeacdGT3yf5h28sAxR98cFlS4Otu
         UqpjY6UzHY5t4dgF3YwQy6WdPoE6K5bPam0wDTMBfrPSBqs+RQlot1hhcXAQM4IuGZuU
         HuPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654422; x=1784259222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vcKE/1zZV4FR8Gq7PnI9d2/vs9rDhLuQyTr8HFgxCkk=;
        b=dW7YNB7VPCeDIY+UnhxZrxyfiMb/Hb1T8x/I/imgyJ9aYS1vsM1JRU3mCBZKx/q8fJ
         BYEsHXi2LObewVmuHBMPbF62p2mO3EMxO4yHN8bG94zexEsP1fDKnrGCo6e93nzFSxYQ
         +/v5HJXPPCJ6Saxy1h1Z1U9XTD5G5rNoUYt7FsfksPzF6kUaDYaTqsG0XUCDxC/lFuNC
         EAq7ZPvfekPeoBHdFiNZJ2uc+iOCl4EVWfYdhVn/m62oJXXo0WON0Ch4ba/GIYrqVJQm
         fyXbht7b2ZyeWCACM8dt+/Gcy1ody4QwJpfK2PZvdNhbLzP1HkPzPRElck1uX5N7flBU
         /Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654422; x=1784259222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcKE/1zZV4FR8Gq7PnI9d2/vs9rDhLuQyTr8HFgxCkk=;
        b=Qcp3uuk9Q1of0N9avsXRzeTJ0tokU5TMxGcF89wkctg0ZHEAny+HsAuvjQbp0JMK+T
         Km9Sf2tH9heh7/7ddM99P0FdyDjvgZVVvXron/HaPQSujy5n0PLqyBDHmAm3LCdJF18q
         Q96nxe59U0RGE49yJex4mWDOhMnbCXpRMecyKlFWuhcugL9qF8uZyMsw2fLBw2B+xpPo
         sQF6vyi0pXreYfK95dbuGftRMWuXqdTG4DP1Vpn8AJ3Jp/9a2mBoTaFgk8QbABnTBbHF
         XqSEAFgRDQ1DrvxuqSa1sx373vvhVZ/Y01fu+8x9vrfWOd9ZoUfGjuziWhZt2KJX6lgW
         aDyg==
X-Forwarded-Encrypted: i=1; AHgh+RpVVEGVhJNBL9LgDz1Y5ujyu4czfsSBDIpNDQ/rL9nkj2SdaRKuY0Uivy3a0Ud8ATPpt2f1M8uDo9iX@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFf5Hm+vaMI+S7BLfug9NRWqr/KKPyIXjRR20eYwxkjIh6/67
	gR8H2qrMH0JF1NZDIEQwcOwFDcx6sIcdfbDBMKqp4fCs9SFuETSpgRIMfBz9QVcL2osL9iGW/W3
	YHC8K63lm3cKoC3dnXWEsNIBw8CZ9rAU=
X-Gm-Gg: AfdE7ckctGPTgi73MfQ9IQ/ZWUraS42tylmab0hzSmTXF5cgXvFdABYeY/9rzvd3kfD
	IZm98ob8UX+A/vf3QILiZ5ZpNoMWMtf7Eu961IzdZ2QFVrLi9RxstRKcr896GjRwqn7wenj1jfw
	oXXAn/e8VO8EAbX9Xd3bBFepQm4y+3z4Cjcx6GAOupSijBNmqWGZQWTCluqmFyTXBov6/GfPDmv
	YMt6XDdusQEZRMC8t7fFQv80AkinLC63PUI8Z9aM/HOswd/ZAQXdTJmeNAKKR+1Q63RVw==
X-Received: by 2002:a05:6512:3ba9:b0:5b0:1a3a:6680 with SMTP id
 2adb3069b0e04-5b01a3a68b7mr899560e87.30.1783654422023; Thu, 09 Jul 2026
 20:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709021504.465792-1-vishnuocv@gmail.com> <178360436568.12613.9417666621877155453.b4-ty@b4>
In-Reply-To: <178360436568.12613.9417666621877155453.b4-ty@b4>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Fri, 10 Jul 2026 12:33:04 +0900
X-Gm-Features: AVVi8CcSE-_ebN-X9wxVOTscT2uv2ixCpRputYr5Fbze1Zb57IGn9QootVXXpXk
Message-ID: <CABxCQKtC5KnTRHdz7KwABRBJKVeRNXv8w__uYh9Qh1dDeoTOCw@mail.gmail.com>
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, derekjohn.clark@gmail.com, 
	hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
	mark.pearson@lenovo.com, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	vsankar@lenovo.com, Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:39=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 09 Jul 2026 11:15:04 +0900, Vishnu Sankar wrote:
>
> > Newer ThinkPad systems expose a USB-C Security (Restricted Mode) featur=
e.
> > When active, USB-C data connections are disabled while power delivery i=
s
> > preserved. This is useful for kiosk and physically-secured deployments.
> >
> > Hardware interface:
> >
> > The HKEY device exposes a read-only ACPI method USCS():
> >
> > [...]
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
>
Thank you for accepting this.
Understood.
> FYI [if applicable to your patch], as per Linus' policy change, also
> fixes are mostly routed through for-next unless the fix is for a
> commit introduced in the most recent cycle or is clearly a regression
> fix.
>
Got it.
> The list of commits applied:
> [1/1] platform/x86: thinkpad_acpi: Add USB-C Security (USCS) support
>       commit: 740f324f8f036607d59c05ab2b2fc22231c9641d
>
> --
>  i.
>


--=20

Regards,

      Vishnu Sankar
