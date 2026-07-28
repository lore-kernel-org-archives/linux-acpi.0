Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF333D503;
	Tue, 28 Jul 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254936; cv=none; b=NvXHI+mvnxvFbMzk0LqPbILbKIGJoAJriT1m2maxPqQ6N//I3UUiO90pKGG+sog/dh10trpJ+dK/Mjt2WsLvaNKkbY34jEOYHwkBQz6r8DKrKgT6g1Dmd3i0qzK6ZrxbfduE1aIkAh1IvfxXVaR7Nq3imKoO85VtchRnmM+vUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254936; c=relaxed/simple;
	bh=3rMLE9Ks3xKZGLvHLJOwbbSeZusmYtdNo4J2X7Ae99w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=RLoSMPOkWWn6sg2+L64ypw4JFu0fO1uINnlw9HFIRGlOsOJpFCZ2e+PHh+A1AfleynIvxkQbgt1W8nFiP/6To2GH3KgsiBYUfsXIZobjY/ad93+7OEafAtZNa1Y0nyW5fS7rXpk5Bg1HvEONyIhyhD5rH70E5qWL+wUtcIomrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaDZ3BwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaDZ3BwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4231F000E9;
	Tue, 28 Jul 2026 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254934;
	bh=3rMLE9Ks3xKZGLvHLJOwbbSeZusmYtdNo4J2X7Ae99w=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=KaDZ3BwAW4LRjXuA5Y3LYSj25FKyyakNgjXE1BAnM1eZVhB4I05LaBGhXR6arGk+h
	 K1vSLiXLiAXeVrxHRnfYm0l6VJuTzASPxcMfX5nXsQb2KPVvDd6VwiQtUCs1jqhG++
	 bh3mZGmIZAEb6nsHl5mqTHwfwEF3QaQD0pTisuX4/NpfpyIwX9WmdAVLVzL73tIsgI
	 513t7+SwQjbkxYr+m/UK2cTxlxnf0m5gawHAwEp1n3d7CDdXZGET+wQPRc/ThRgbdy
	 S9TuvF8/GYxogNzx0tpvS9VeNgN6623Ar9DrWl9Cs7l7+hzKXVaojhw2Bk+X3zjcch
	 qSqNR3g7ecsLw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 18:08:50 +0200
Message-Id: <DKAC20YQ9T1Z.3NEEFHM908430@kernel.org>
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, "Hanjun Guo" <guohanjun@huawei.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
 <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown"
 <lenb@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <brgl@kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Sudeep Holla" <sudeep.holla@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] ACPI/APMT: use platform_device_set_fwnode()
References: <20260728-acpi-arm64-pdev-set-fwnode-v1-0-b5aff9b2235a@oss.qualcomm.com> <20260728-acpi-arm64-pdev-set-fwnode-v1-1-b5aff9b2235a@oss.qualcomm.com> <20260728-energetic-mayfly-of-chivalry-4e89d8@sudeepholla>
In-Reply-To: <20260728-energetic-mayfly-of-chivalry-4e89d8@sudeepholla>

On Tue Jul 28, 2026 at 5:56 PM CEST, Sudeep Holla wrote:
> I don't see platform_device_set_fwnode() in the upstream tree, is it in
> -next ? I didn't see -next tag as well.

It should be contained in linux-next through driver-core-next.
