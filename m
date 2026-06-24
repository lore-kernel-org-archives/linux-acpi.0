Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0727A10F;
	Wed, 24 Jun 2026 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323385; cv=none; b=KsqpJGh1qQDzPcqwG8hNwIvk0CrHBKFg1NpJCA3cxZjKguldVu5Q6lJ8srRk7u6By3ca4x4oigCS3k7v/yo+uIQxisKXQlvGipYro59C99NaTLfIUhnDLT68bZuTx7+kasMkNX+9x6uHDNU75/vFDjccmbeA0YtJOfqO2UH2nD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323385; c=relaxed/simple;
	bh=mWK9qoRiuMnydXkGNXUnZbxXrFuTUMb2ioixpkB9cE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=PWJdbEw9rVSEgfAWzYutcoB/OXK225IsEuXYYlmkJt4651kUG3kbu66R1gq9Juigiw295Pq2KZ5Q2cYTBmAafHIDL2BAA0TsKXtOfWeVFn52vmlaBk1KOC2hFQzVv2h18Wf/nHcHvC0InSI+oMOlMEWKvZsASeT7eVHoVhrYOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=f5PL0gaO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="f5PL0gaO"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 88797270DF;
	Wed, 24 Jun 2026 19:49:35 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqx2ApzC8SHj; Wed, 24 Jun 2026 19:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782323374; bh=mWK9qoRiuMnydXkGNXUnZbxXrFuTUMb2ioixpkB9cE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To;
	b=f5PL0gaOChjpRjhENwLZPJjhF0ZQsRmXeEZg990o5uIkSgD2lG1X4q6gmfv9uwqPs
	 9JQvugfUihpS+LQdWd33bHIvuP23wMQ2rKIB5TT019gNmVCJUHzD40NKgUL0xDeGrR
	 zBSKz0A60uYCH/CiPPfRfK+wJf55Cnvpy3TBklB9aDcAN8TCNWPY9t6qFSLDlCp07A
	 pEa4AaliYDZEltxfP0yE6SjeB1Un1V0Nuzm1wpX0Bd6LWLUGtc1Byk7TKcRr3NGrBF
	 EqvpGTtf+2ILqP6pYEFEvzFBD11hZRbsv7L+Op59sDegv1P0fvd7BpyIvz1JZis/Hv
	 4FoYUgYQDRShw==
From: Marco Scardovi <scardracs@disroot.org>
To: w_armin@gmx.de
Cc: andriy.shevchenko@linux.intel.com, bnatikar@amd.com, brgl@kernel.org,
 johannes.goede@oss.qualcomm.com, linusw@kernel.org,
 linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 scardracs@disroot.org, westeri@kernel.org
Subject:
 Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for ASUS ROG Strix G16 G614
 series
Date: Wed, 24 Jun 2026 19:49:21 +0200
Message-ID: <fDMIXYjSRMSLJNqjRmWA7Q@disroot.org>
In-Reply-To: <f51df47c-0523-41ee-9e7d-0aa0177065e7@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi guys,

I'm feeling like a complete idiot right now and have to make a
mea culpa for it.

I didn't notice that [1] wasn't still merged into the 7.1 stable. I took it
for granted as it was on linux-next since april and newer patches made by me
were already merged on stable. It sounded strange that a patch made that
was working 2 months ago to stop working suddenly and now I know why.

I'm truly sorry for all the noise: you can skip on it.

[1] https://lore.kernel.org/linux-gpio/20260429025247.1372984-1-mario.limonciello@amd.com/


