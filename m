Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509325771;
	Thu, 25 Jun 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419551; cv=none; b=jhcJkCP8nwxlQ8Krb3uvXz4aWn4jHC1xpbpUPz6g5gux0IPDalZ2piPEU4vFsSyH8nTnH4lhTMBE6K2DR2v18xdzQv3BtdtOkriLqwA3cUGz8BmgtsOlHsaqmuqNGFnj63KIzDKqDzdan8sLynt9DPwNWDSTh7wUWuyAUrQUFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419551; c=relaxed/simple;
	bh=spthGLekVSyOci9QE7O7+prPf0BIF3DkEfThVp/BY9Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e5UArX7FjpT4DrVD0Nh/6ZpBECloaudeGff5v6U/jdk3WQhYSj66RdnouwHIo6xNMMbs3A6ZZKa9R9A1xtV2TUp0MxK8ItR9IIjnoF/c0q8PSc0NK8icBY4b7cC3SxpLFKA0e1V6uGn8Xi/wXSfF8akgFj5a08wVWA1Z9LQ6rxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBfCGY+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBfCGY+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6531F000E9;
	Thu, 25 Jun 2026 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782419550;
	bh=ANr0CGYD/qbVbHjHBh/VGOXxEdxm178HUoue3X1UOaE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QBfCGY+uHwyY8Q080ZSPRjTv44K665c9f9er912Bi6gflo0G9b4POa3u3MXdWgUco
	 mKWM9Y+ORjylHnS9Y7yBcC/2AdovvOxzUjvIakMdsnFO/9AxmNHlct16dA0Wp0Tuej
	 oqCSUZmso5Q8wmWvv7i3009P+VAS74HywwXGxb5CVgVyNBuLIaK/AwCYjqlq+fJv7c
	 dGvJHOmQz9rjHAl4dwwtUfhx0Rem8OZve8rsyC/TZqWNgwkuc3cMViar/n8b9odUdo
	 F6uBGuV8JzxpBGlVW32jY61Gh3kXHhNoB3q1gZGWsCML+aHPeL6fB5enmCTPdZ5QiK
	 XpoqhKGt9ziqg==
Date: Thu, 25 Jun 2026 14:32:28 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, linux-acpi@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] riscv: acpi: Enable ARCH_HAS_ACPI_TABLE_UPGRADE
In-Reply-To: <20260616-riscv-acpi-table-upgrade-v1-0-45902d2dedf9@iscas.ac.cn>
Message-ID: <e3fdacef-5277-a0fb-f8c6-da2221d55eab@kernel.org>
References: <20260616-riscv-acpi-table-upgrade-v1-0-45902d2dedf9@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jun 2026, Vivian Wang wrote:

> I did end up using this for something, so this is probably also useful
> for others.

Thanks, queued for v7.3.  Would assume that pretty much anyone 
working on RISC-V systems running ACPI right now would want this...


- Paul
