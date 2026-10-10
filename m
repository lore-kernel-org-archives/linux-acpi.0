Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A2358363;
	Sat, 10 Oct 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651456; cv=none; b=QR5p+fd1M5dyti7bqh4M2ZP+xwULNFlMl/o2wGO2DxZtAOtb5hTVrpTnBarIox3eUFeSnzWNsQ+dS6RP0jzaEo2W+Y/YfjQ7rUOWQyp2RvwtdxhfVc3h0pinmhQalLg7qgqQbdf2sh9xiSr0QBtkpQlM/T65Sj2wh/XPBZfqtO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651456; c=relaxed/simple;
	bh=xhTYnGblJA77kFkvCzBxWJNz9tLDWTaedthDQ/dHmdM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jM/Go/txVbGpj470JkIoZ71vfgtQXWuYxlalSWbNmpJBOmivBNJfRZhUxaJDXD5F00/7WlK94JXmjlsIPcxO6PQj8Pit4zI0TMTi1uqbEI0cppoM5QkPSxi5EZHekxscQlnbKdtBvnWWbuIk8TY9j1lezPna+TRhMj8YONQCDjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P1KiAUDE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P1KiAUDE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=uyvlqAyPwFNwTNzIPT341jkn+EeFo16897kGjTZjlmE=; b=P1KiAUDEJloVQYbw0BwMrHXMXK
	b4kA0S8nZojWf9quHP2FQ47Xwa4QVG4MwCOxGWl0PwAaXJJ+4VjUD1IPCpcxarKkgMcHHHxXMxTYC
	yj8uF/JOq+eutY81DdEk3c70SJUtfWPsi87M10E3yZw1RFZq7fzuFHv6IJo/aHwo3dupDu2haQKH5
	caeS8FjI5Ws0Yraf9Z1e6zsaGU2YOcOEdg8I5UMwa1qBXtDzuuFMiBpTTjmcKgBa5H+3EpJsjCIRw
	JCJwWyIno+Dt4xFREkpYsVEBGGnyQ6vq09iyGFbgKEpRBOHirfkhXAABcK/7IZXiZEgtK7+X+Md1w
	9qqXS29w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xFaNv-00FaCk-VR; Sat, 10 Oct 2026 18:57:23 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xFaNv-004HGp-0S;
	Sat, 10 Oct 2026 18:57:23 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <uajain@igalia.com>)
	id 1xFaNv-00000008bp9-05sn;
	Sat, 10 Oct 2026 18:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 10 Oct 2026 18:57:23 +0200
From: Umang Jain <uajain@igalia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] acpi: battery: Query BCT method and steamdeck
In-Reply-To: <20260923082932.1049270-1-uajain@igalia.com>
References: <20260923082932.1049270-1-uajain@igalia.com>
Message-ID: <cbcc76769b0e1bb6272399176b1cf41a@igalia.com>
X-Sender: uajain@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.005
X-Spam-Score: -48
X-Spam-Bar: ----

Hello,

Gentle ping for some review?

Thanks,
Umang

On 2026-09-23 10:29, Umang Jain wrote:
> Short series to query Battery charge time ("_BCT") from ACPI tables
> (1/2).
> 
> Patch 2/2 handles the case where steamdeck devices can report "Charging"
> even when low power PSU is connected which is discharging the device.
> 
> Changes in v2:
> - comment improvements
> - split off BCT method handling into separate patch
> 
> v1:
> https://lore.kernel.org/all/20260918135628.2322188-1-uajain@igalia.com/
> 
> Umang Jain (2):
>   acpi: battery: Query Battery charge time ("_BCT") method
>   acpi: battery: Handle Valve steamdeck devices quirk
> 
>  drivers/acpi/battery.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
