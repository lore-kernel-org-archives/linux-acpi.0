Received: from comms.kousu.ca (comms.kousu.ca [46.23.90.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059D82866;
	Fri, 22 May 2026 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.90.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414534; cv=none; b=Si8uma38cnjxshg73lhw+PPAjb1H9S2iqY2qP6DK5H0MUzWBCIDhFVQhgJ01CZHA+aNjOSKVo0mtwNoCp6iIdCPLl8xCQ2N4T+Euo1HaanS1RWSVbBdt4iJYcNtBRjcrpJfLYOOvZx5lXM7OHOf8v223SXuk1lHuqJrLYAFSeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414534; c=relaxed/simple;
	bh=fhFOzi0A+cs/AvaFoowR9qijtdk+yxeHIkC/cNLKMno=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gATV1is/LvtwNdaVvz0zFcHrPn9oOe5KJoLqcbJuBvBTM8oykrFPkC8thNqI7naQc9+uhdMoEpjyLLQ3YeNvRc4sYlk/hQvcLypGSIqvZCFrpCJtApD3sxM18zhj6iyRyu+XmG6x7VzySTFcJ7YkjPdJwCh2qDs8Rr22CN2USW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca; spf=pass smtp.mailfrom=kousu.ca; dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=c+A6vVdL; dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b=J2j0hw2+; arc=none smtp.client-ip=46.23.90.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kousu.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kousu.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="c+A6vVdL";
	dkim=pass (2048-bit key) header.d=kousu.ca header.i=@kousu.ca header.b="J2j0hw2+"
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=ed25519; bh=fhFOzi0A
	+cs/AvaFoowR9qijtdk+yxeHIkC/cNLKMno=; h=references:in-reply-to:cc:to:
	subject:from:date; d=kousu.ca; b=c+A6vVdLT9/IQtHKvkd1OPZ9APekNjXM/4iK7
	9/DkLTQtl5EpvXtafiYETdfraZDeO7yFVcSFNXjjyUlmYRnCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=rsa; bh=fhFOzi0A+cs/AvaF
	oowR9qijtdk+yxeHIkC/cNLKMno=; h=references:in-reply-to:cc:to:subject:
	from:date; d=kousu.ca; b=J2j0hw2+pfM29caP2Gbb07vOd5e7Hbi56C7gNmJAohAX0
	PYDxn0zCEeTBHIXbtllXXQoQqVmAgNyASXqJ2gMVoF+F0CsI/Rdf2K8GQUlfTXOthbdM3Q
	FserSjyAlab9VmqBUw4zkseFi72xz5wC6V0ff44RGUjG0XIqQmFVNzwK+Rc0+Lx0m+OaP+
	RFOUKU/i0947MJWOLVAYQdiN/RbWwaMwxM19Ex2nxme379uW4QQpsnppSuwomoN4LF6sBX
	pUn1vPIRHHfsPoB33cK/22pW+Kj3Kk+GQEIO0hhYT7utwz4IcU7mB/v3GplhsqQZmDhahI
	oH/khNr7prhWQ27bQ==
Received: from [IPv6:2606:6d00:17:b526::6b4] (<unknown> [2606:6d00:17:b526::6b4])
	by comms.kousu.ca (OpenSMTPD) with ESMTPSA id c964c175 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 May 2026 03:48:43 +0200 (CEST)
Date: Thu, 21 May 2026 21:48:35 -0400
From: Nick <nick@kousu.ca>
Subject: Re: [PATCH v1 2/3] ACPI: button: Enable wakeup GPEs for ACPI buttons
 at probe time
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Mario Limonciello
	<superm1@kernel.org>
Message-Id: <Z01FFT.NPPC3AQH2RI22@kousu.ca>
In-Reply-To: <2265993.irdbgypaU6@rafael.j.wysocki>
References: <5996185.DvuYhMxLoT@rafael.j.wysocki>
	<2265993.irdbgypaU6@rafael.j.wysocki>
X-Mailer: org.gnome.Geary/46.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed

Hello Rafael,


On Thu, May 21 2026 at 03:38:50 PM +02:00:00, Rafael J. Wysocki 
<rafael@kernel.org> wrote:
> 
> Link: 
> https://lore.kernel.org/linux-acpi/E2OXET.4X5GTP37VTNC3@kousu.ca/ [1]
> Fixes: 57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for 
> buttons")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: 7.0+ <stable@vger.kernel.org> # 7.0+
> ---
> 
> @Nick, I have reproduced the change of behavior introduced by commit
> 57c31e6d620f132dc on one of my systems, but not the function keys
> regression because they are handled differently here.  This patch
> should restore the missing functionality on your machine, but I would
> appreciate some testing feedback.

I have applied this patch series on top of today's mainline 
(8bc67e4db64aa727). It worked! My brightness keys and mute and 
lidswitch are back. That's great. Thank you! Learning how to bisect was 
a steep curve for me but everything after that has been a really easy 
experience. Thank you for knowing this subsystem deeply.

- Nick






