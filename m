Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C363F7E98
	for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332963; cv=none; b=Dl1TSS125JxYWr6FnGMXckP7uYsMv4ol3+6ekvDBvdH+mVfdmhNiv4+C3kn3vak8ZQoKiixWnTOV0xZXYt4+JHA5Ovh10kOpwd6KPBSy+xfdNNho+72hdvDv8u44jpJST5vWi+0gMm8mWKho2s9w2fRUyTz+rORZrgUYdG9OBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332963; c=relaxed/simple;
	bh=9Mg/PzeYwdsiMQmSjWFJiVOq8wvv32+lQLFjLWnE6lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKzgqATI2yEJ3T82ryEAvDSB9otZCAmrw7w0lGGgPebywxmM1gD/dnpkBUFheGjr3KwUp9zq1qu/opFSbTGFWGApomRVg6Z0Hsp+X1/nRujz3JorTLx0EZUC8wCns/bcDGiCn87gN9kb8HbqlUxfz1vnXGdQWzOD6vzmraIzvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqE1bzIU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqE1bzIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB2BC2BCAF
	for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2026 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773332962;
	bh=9Mg/PzeYwdsiMQmSjWFJiVOq8wvv32+lQLFjLWnE6lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VqE1bzIU/fTi8W4KVwhV60Y/K/46dSICnbhAVMu8LrCeZAiYguawTiLoWkVk+ZrOO
	 Zc0VSv1SOzAQgEUu/ejkzTrbL7DO7MXPSTGcCg3J1uE0jzVG7y3+SmU7EU4ztrIkaA
	 1DwdvgPKCfuLcK5d/zA3C5O3DdCK0fRt2+mdjXZ18KsmmZ7b8wUQmRogr9o6rW2xXj
	 S0Me7NamFQ0ZFUpOQuIvDurCC6TxKLeOc14CNZ2ZR0IDeR4nNQ4F+7H70+D968Al4b
	 a/Xb9xfAn6blHOacpbvjlYJ6aFQUCVD7OodRYakVUp+VFC3/TkEOTAvwz9tAgZC5Ld
	 q49Hyt996Ihtg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67bb5e4cf7eso670750eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2026 09:29:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuEj4qkElXDBTneoO/NM0ezv7fUPOCjd6qJrtUYVE5RwDn2NrGA+nJXP71cCNCIpCrpezc26bpOw/v@vger.kernel.org
X-Gm-Message-State: AOJu0YwQGX+cBpP2EFHVk9NZsXCmslJFyZVxjJISHtWCFjKJAt6RcBXv
	X1hsg9tDWXEj0tyeCQEaAGmtkfj9b8jYBTxrDyCa3WUYWiLK2wwNHe+6XyZLf9+F0No4DxTJsJl
	iGN7t0BitOCZUemKoV0TavClRM6IA4F8=
X-Received: by 2002:a05:6820:2222:b0:67b:c4cf:9cc4 with SMTP id
 006d021491bc7-67bdaa384f0mr1385eaf.48.1773332961992; Thu, 12 Mar 2026
 09:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2841136.mvXUDI8C0e@rafael.j.wysocki> <1968431.tdWV9SEqCh@rafael.j.wysocki>
 <eaa78acf-7baf-4c46-9f7b-70ccd62a188b@app.fastmail.com>
In-Reply-To: <eaa78acf-7baf-4c46-9f7b-70ccd62a188b@app.fastmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Mar 2026 17:29:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g7GPe0k7+JWKSnUaEVqEyAUBdT_gDWtfhTWO_39PN+GA@mail.gmail.com>
X-Gm-Features: AaiRm538w35-z1ORpZ1v8EROKhuZqGvHBkun9y8dPlRqb-yJXGFj0tIrHrfcASY
Message-ID: <CAJZ5v0g7GPe0k7+JWKSnUaEVqEyAUBdT_gDWtfhTWO_39PN+GA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] platform/x86: system76: Convert ACPI driver to a
 platform one
To: Jeremy Soller <jeremy@system76.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
	System76 Product Development <productdev@system76.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 12, 2026 at 5:09=E2=80=AFPM Jeremy Soller <jeremy@system76.com>=
 wrote:
>
> Hello Rafael,
>
> This change looks good to me, is there anything else you need from me as =
the module author?

No, I don't think so.

Thank you!
