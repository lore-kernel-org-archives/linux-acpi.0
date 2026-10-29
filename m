Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286940;
	b=Xa7iyFY9gIypiJWjq6Toy9McOafNZGXIetFrkXpxU/SYJ9+8PFEScifUtJvtH9BvjTG4
	 hbkI7pavnONZtFrBvJnMjkDfLJj2e2rvtCRqVKABq1mHgpm7mbB/xVuttH83ldievgaz8
	 5YwJbc1zbdYQotOrrMYAnSIr5EpvBtjUIbwlkv75mSuEblnthXIY28Bl4zZKBr/AeYDfF
	 Gw0QhuHoW5TMdQZZWcDJ2RwO6bKCXwU4MXQSR0TcImN2ir7LBs8YcTDaqzeH0qfGc8A64
	 96XkFKQUK0y5z5WnUOYfDKWS02xDGw8abrAnmZ6eTeZ9otMqGBRef4mB8ykitextj0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286940;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hl9lfwLuHEFaKD2DgLZgrLN/YtArxi+yA6ah0W4bMX4=;
	b=Wdh4NW/2IWp/P/+XDHC5srh0syVztImwnn7hj07vKTa5ch6g082wPTnoAlBqG1Pd4qRO
	 4lhHSH866hGnyTO67HEIaSMev3zggM1smaiJjiYHPTqu94YJ7OldVSE/pTH3f/E7vJnaL
	 1eKR8vg9Vcgt8lhhkEO97eHRRHdWJZHzxLM+0rV0O5Ln4Ddn6c68nXSQ59gq1oCdU5UVi
	 oSr6gtlW68x9Q0zh2vT8/2fQTq9uJoMehmew2FIQouurADTn0EdPrpoR4EBu3UwaWIiUH
	 aaLBGb1vQ7evkZW2xSjRCn2CbaERDZlGO1NbHWFmLtKk2RcCR4fW3jczQvJ3xcEm1lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eb/QGXzT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F0606A31F
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eb/QGXzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EA01F031E0
	for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286935;
	bh=hl9lfwLuHEFaKD2DgLZgrLN/YtArxi+yA6ah0W4bMX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eb/QGXzTOjsYyyO9gEdeK9O+EiB554RYGWgB4GcNUam8VNP7WTYV2oTEpDxQuxt1v
	 yfM3HZfoi5mxiBMzBry+MqIEvQx4nc1SARi/Duw1ptmJ2QRRWx7I7vPxXfL90OUczc
	 38feY+1ez+g57/bb/RgeXmtxDwXe8HERMmQLGgWO+RsEKp4KyWLY4jiSwdJEmP/gt/
	 fql+8a3lu2C+aj67Z1g5AGpF+dtHGn+85cXxwOBI6W8wqCk7jDY5Xq7KVwd+zeizy3
	 Ut118kjtD9IQtzuXb7QbexsX18VerSftE0TpqUctknfdRjkRtlge2pJCFEZOyifJO8
	 bZHOg8LMItYgQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1433276e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2026 08:15:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy7aQmfbYMszYFvbzvMkyJfpajpTUXQN1RNHuR24I3yqpfwq3g4F8a7gELTQIuZjeD4TCa2OJX3OaHf@vger.kernel.org
X-Gm-Message-State: AFq9FYKg7xD3kLpqTTYDhuG2Ydh8BcqUfQiGqeCpz9wKgk+NNlZFWsig
	RTHTYWkeyaNjLCZ/9Cf7eIm0fADEYciGRfMk+1a9yrF8KjHaoaga0j5egPDJy7Epieyiy1IiLUT
	4kNSGo026xqsa7xm/m9o2/MNTy3um2kw=
X-Received: by 2002:a05:6512:230e:b0:5bf:b249:375c with SMTP id
 2adb3069b0e04-5bfcadc4e8emr2545141e87.13.1793286933521; Thu, 29 Oct 2026
 08:15:33 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015204450.1270-1-atharvatiwarilinuxdev@gmail.com> <20261029151051.1124-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261029151051.1124-1-atharvatiwarilinuxdev@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 29 Oct 2026 16:15:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jv9VQhZKbQcWYHEU0sQUPn5sLsRmqHzEtZ4T6GY0t3ZA@mail.gmail.com>
X-Gm-Features: AclHuK_a1SI1w6G7Vs72CVoh28cwrTfqKIrzBtQ66drVFyZJNdoy668BuV1QZfM
Message-ID: <CAJZ5v0jv9VQhZKbQcWYHEU0sQUPn5sLsRmqHzEtZ4T6GY0t3ZA@mail.gmail.com>
Subject: Re: [PATCH RESEND] ACPI: processor: Use Apple-specific methods for P/C-states
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:11=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> Hi can i please get a update on this, i sent this patch almost 15 days
> ago.

You haven't provided a motivation for the change and I know nothing
about Apple platforms, sorry.
