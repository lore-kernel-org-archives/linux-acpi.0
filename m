Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC343C055
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830981; cv=pass; b=V7/SgJTm/thytGfu7MfGIy/zyB5elnMW6yj5T8Zoi52a3xbiZfpUOGjyPyxf58gWnDNeqhyy6JwbsvbPMbNUy2ZM29F8KnHhceT0Ab2lgaFVrCain7ft/VK08kabzkjxg96LC2fjRH4YN0joJdRMoG3fsezpT59V2SbRLQUpisA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830981; c=relaxed/simple;
	bh=R2RLlWKV31uw1vmm0eE8g4HAQBST/y2tQNtzmoB595w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDIxP2O9WTSuKRC6lvhBA6HBUUUPTNwFjDo6S5y5sBknZtPFy4c2GIHdKWpS5pW3Gf655Tr80BjUZW9wZs6U9ZuAk1UTHBdXF54EprFGMtCExdfHl+UGVEBbRU6Y6wH/h3qd4JI5ahQBVOrS9HX8BfqiT+31aP3r05h/KVLXhK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eguBgHH2; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eguBgHH2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb6d00883so1756840e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 07:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782830978; cv=none;
        d=google.com; s=arc-20260327;
        b=aNDGTjr+AqerbMqW4seNE3yqPzpaQ4FQI4y+KF7tXniI64anJa07eP1AHocoWKQ1Na
         P7TYADU/wtK76TaGJnLfdxeiq2HRn1LvFgaYpL+rsehW0dwgAalJp5cu8w96dVSHEUKT
         6Hwt89YGRp9hmnaVpYNIuMpME7Yve4LoLCfSXnR/qg3dMsqXL7ML2A0P8f3+ojbmEauY
         EdeBru15Bm4b6kIvzWUN0hx79RY37rSlu1V6RVTeF+SJsiZ51pkLGNkNAXI09j6qRVwK
         h392FszrBFBHIg7mB6Q6MpdWAvTYfjq7lOS5RbhxiY9EzVreUY+caPlLdzuY5lWc6nyR
         OTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        fh=2GNmo26rVcVp3ZmyeTOnnaRnIhQ04GSZRyHCvatabck=;
        b=BU2iRnM9t6jtRquv2edUn4gS8NCL+KpFGmzz9aYwo0X/86MTZfdsPLMEJNsvwczpgn
         /QGTGkJY2H6Fzih/eWqOkk8WRjEU1l0NfDE0DDzl6CEZFlhging3f0PemhvWTH+aCQ04
         u84kS9ye9fik9v9NqILl7rrUIwJO20mg9R8Fvx9nIBKJcnjLR08jcNkfSkA5CUmYOGCf
         l6g4kbzofwFeKRCrSFWJWUNt2ruybncuV0ktSQBoej7XifkIrWcSSa9HDz2HH+TUlQKe
         g7K7rZdk3ag3Slj8IAU8vdMsIwNs8RDoR5ssOWpChYlfoFzdtU/eAyKEs3urP6HmYt5c
         BuCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782830978; x=1783435778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=eguBgHH2CoPRAyRaOi3uiaGSli4ODNgt+uvPY+h/SIbi3UUzw5fgIYyM6JQzztjeNV
         3JlZ/ToxMazHgtcSpYy6Wanx8ZqhDUqqumustyQxJN+22k7vxLd4LMYm7+P0yLfn8pQ9
         JmK4CXxkJxFZX5JST3Z2ucXmDLXruN8OwppFZNOl6Ue/Rze31PgrmjMVcdVChqaVzkn3
         9z6twiYp4Zo1H82GIHWlqKbcTI38vd2yEWEiZYcXIzue3/HMx3mwR50ZIJUVf2D/Y4gU
         v2SGLfGE48Xhlw6IlpE/3my5ZFDfLd1udwdgHT/iCfuo1uBXsQroYQOJpyClQUxBsTNu
         CwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830978; x=1783435778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAHFXtMiFS3SQCPXfcc6nAkzBIK1JQ7gQg2BRXU7Bfc=;
        b=dNTp2TpzrfJSJjqTmD5t+/GWA5QREDWZ9ggsOPHM2N4QHHmW6zZDa8VtSy/qugWOrC
         3VIwrkF6q91tPcWFRa6bpxcwgCCfyfqRjFvSLcmD9MK8UYOdQJ2yROKGBEugSqKCad+F
         Q3+7+5yQMFSqnEY69sH6Pz36f00nuuRKlQThaYVMhVsU6EGYk/3Tks7JL92GkxWwAnId
         PGHxKHlhcCfdi/5ZPvc6nSc9W1r93NZWYfDopFjs9a8xKlw7wZZTTA7er3uDHiuLIFY7
         xVHroN4SDvqx6UfX1q7rfyrU7Bvc1+Disa5TVDZebiCBGZwuMjJdaP1jghbL6rSLblo0
         o/JQ==
X-Gm-Message-State: AOJu0Yylhg2Zg5RfUjz1GUAMAhnoXaO+YOv/XXCQBaA1gZDCe7lB6NbZ
	AD34PorfQtEvJdgDq3230RZ4BJT+wUjhGArrCNW2fD5EnULoynjSDolpSvPQedG5VwHfkiBuCyM
	UnmP1L975dBoPeW8czstZZqjkngH3BBc=
X-Gm-Gg: AfdE7ckvkKCAFF114kRyvjj9vx6/SFzXTcSaDLfY6uL3IWUUt+39SW2nHpbT2r9oCeF
	SNlh4xFaoKb6fyf2mV8VhbcTEmJMFOJErrrO0TaShIY3pe2JzIJpnRq6kZUatc60jAwvnJFMV+C
	OPiLLWTa27T1h3BA851gKHI4yTvOr8tY/kTVPYWh1BeONWRIM++m8i84crncZK0L6uvxfjABKyu
	Coyu0jN/wfpRwh24xiwjSJGPdWao70NEIElq4i/HzwjfYvBNYxJrZ7hx26fKHkaXKU/LJc7tq1z
	b2gBvN0j4aPTFt3wsZcB/vnP6O6yyfWXCUw45U8bfyoLrtIdwT2Yqf5I+EUvhK+vHe9PEueNaSm
	6wB1l0NZBGe0FxLLKpjMU
X-Received: by 2002:a05:6512:640e:b0:5ae:b6cf:2869 with SMTP id
 2adb3069b0e04-5aebdb9485emr981524e87.23.1782830977995; Tue, 30 Jun 2026
 07:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aj5KJEIsTl6IK0nX@gmail.com>
In-Reply-To: <aj5KJEIsTl6IK0nX@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 30 Jun 2026 22:49:00 +0800
X-Gm-Features: AVVi8CeNolHc0bWFWi94se6V_El3cArCALeJfgf0e7sVp8JXgJSa3XDzBUrtcNM
Message-ID: <CAL+tcoA6=_paEdqWaY7-VHdBeAxEFeMCfTECAEGv3C6ZqFUNSw@mail.gmail.com>
Subject: Re: [ANNOUNCEMENT] LPC 2026: System Monitoring and Observability Microconference
To: Breno Leitao <leitao@debian.org>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com, 
	linux-mm@kvack.org, iipeace5@gmail.com, gavinguo@igalia.com, 
	linux@jordanrome.com, amscanne@meta.com, sj@kernel.org, gpiccoli@igalia.com, 
	Daniel Gomez <da.gomez@kernel.org>, mfo@igalia.com, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 5:56=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> We are pleased to announce the Call for Proposals (CFP) for another
> edition of  System Monitoring and Observability Microconference, this
> time at the 2026 Linux Plumbers Conference (LPC), taking place in
> Prague, Czechia, from Oct 5-7, 2026.
>
>   https://lpc.events/event/20/sessions/262/
>
> This microconference provides a valuable forum for key engineering areas
> such as:
>
>    - Kernel Health and Runtime Monitoring
>    - Hardware Integration and Error Detection
>    - Correlation of Issues (crashes, stalls, bugs)
>    - Virtualization Stack Monitoring
>    - Memory Management Monitoring and Observability
>    - Anomaly Detection Algorithms for System Behavior
>    - Automated Analysis, Remediation and post mortem analyzes
>
> The purpose of each talk is to share challenges and discuss potential
> improvements. Sessions will last 20 to 30 minutes and aim to encourage
> brainstorming and open dialogue about ongoing issues rather than
> delivering immediate solutions.
>
> The conference acts as both a knowledge-sharing platform and a strategic
> venue for guiding the future of kernel technologies to better meet the
> demands of large-scale infrastructure.
>
> We invite you to submit your proposals here:
>         https://lpc.events/event/20/abstracts/
>
> Please select track "Linux System Monitoring and Observability MC"

A kind reminder: at the bottom of the page [1], please click the
'Submit new abstract' button so that you will be able to quickly
submit a new proposal. (Admittedly, it's a bit easy to miss the entry
especially for the newcomers)

If you have any questions/suggestions/problems, please do not hesitate
to contact Breno or me.

Again, proposals are greatly appreciated :)

[1]: https://lpc.events/event/20/abstracts/

Thanks,
Jason
