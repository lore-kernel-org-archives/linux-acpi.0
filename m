Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979671;
	b=nR93BHPxHpFf0tIYcJFvMNM4P7VwxN4PAe2svQ60TeZA1sD/UDFzgagwbneF9wgBDRYh
	 T4mb8uh7eCS9aZ7krfbpY0mz7oakZk3eOC4qD6EbwnF1l6FeDj3IBDZMJQ4YMn7bfTO6q
	 RMphzzj1+NxrmAs8+TVJMEp6XAhoI/OpsWzHddnsljtsknDA8ZXtteWpFGuLuoBPzERJu
	 8PTi5/TTag1hysZ2Fr0LCdC35J7+kD5fPE94CRy9HwsZhNwDv21XlWLDnrEYLc7oujwAc
	 8c6TUVrfvf+2KXTUXLjKCnE4wWuoCQn2E289o+7KMG2xndVirzrpp88QAZwFv5msoVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979671;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:MIME-Version:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Report:X-Spam-Score:
	 X-Spam-Bar:X-Rspamd-Score:X-Rspamd-Action:X-Rspamd-Bar;
	bh=1islqEQJDji8kxtI3Tuvgz2Eh1HB0S+C660DdFRf7Mk=;
	b=keApHNzXU19yTLLfDX+26+9nGa0a75K3NQGnngWWR8Oxj7AuhrNEOVRrgcfWyW+06ik7
	 97jUGmNmEUr8C0StAYzDLIFh+569e44c3k092TzpGH8NMEleb6K4Njt4hDaHFCI//wtYd
	 bebY5A5h6XsZWxyRCLXvn/R2Q12/ojWAtB2Q3U95rwmzOxUX6FznbFKAqSU42ih2xizT+
	 WR5ST7wxicpey/ZjaX4hK2RFeflBF8DFPgKFL1i/ittDu/IXzFednBMg8+VVLfVxu+9XC
	 s6hlVHEa2J8UkMZGQ2jwcuSZZ+1+ZQGpiPXlgB6qPBWT5WnOMys5Enyg1wB+UCot8kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=gEjFMKfK;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C3606A329;
	Fri,  6 Nov 2026 15:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 777C3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=gEjFMKfK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=1islqEQJDji8kxtI3Tuvgz2Eh1HB0S+C660DdFRf7Mk=; t=1793979669; x=2109339669; 
	b=gEjFMKfKbb8oCL72vdgdqYiDmAauBdTE3cn6xIkeE4Nq7ndMjHDGHSQXSoRFEBdwkudWrNkvUOW
	XhCS1esKBbQLuV9Fa1720bcKNN2+BK5HACm/9SxqPuqubEXCBUnp/6sfnT02Ub8sExEYnRymnKrpA
	t+Av2MHyoJtsgT21edTJswaJGiQR/jbKH+yhYi5wLiYsplr+jzrIadD7H5LSoBj6E8ZR8/NGv1HFY
	yQBMfqkYoVfP4A+JG3oXyONE4wyv6OliuX86r/URfIen1xbbm/cDtg8hyANBCNSgfzGyOmYeqbkku
	BgloCMx/p5waEjaNPIJXapf5RKIpDbRK2PnQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xPM3u-004Y3B-CS; Fri, 06 Nov 2026 16:41:06 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xPM3t-00000000YC5-1tzq;
	Fri, 06 Nov 2026 16:41:06 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <uajain@igalia.com>)
	id 1xPM3t-0000000Fg9G-1Maw;
	Fri, 06 Nov 2026 16:41:05 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 06 Nov 2026 15:41:05 +0000
From: Umang Jain <uajain@igalia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] acpi: battery: Query BCT method for steamdeck
In-Reply-To: <20261014204558.466130-1-uajain@igalia.com>
References: <20261014204558.466130-1-uajain@igalia.com>
Message-ID: <9925f10b2bd1437293422a05269c1823@igalia.com>
X-Sender: uajain@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.007
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -2.9
X-Rspamd-Action: no action
X-Rspamd-Bar: --

Hello,

Gentle ping for review?

On 2026-10-14 20:45, Umang Jain wrote:
> Short series to query Battery charge time ("_BCT") from ACPI tables
> for steamdeck devices.
> 
> Patch 1/2 introduces the steamdeck device battery quirk.
> Patch 2/2 handles the case where steamdeck devices can report "Charging"
> even when low power PSU is connected which is discharging the device.
> 
> Changes in v3:
> - Only query BCT method for the steamdeck quirk
> - Drop charge_time member from battery object
> - check for returned value from acpi_evaluate_integer for max
>   ACPI_UINT32_MAX bounds as per the spec
> 
> Changes in v2:
> - comment improvements
> - split off BCT method handling into separate patch
> - https://lore.kernel.org/all/20260923082932.1049270-1-uajain@igalia.com/
> 
> v1:
> https://lore.kernel.org/all/20260918135628.2322188-1-uajain@igalia.com/
> 
> 
> Umang Jain (2):
>   acpi: battery: Introduce Valve steamdeck devices quirk
>   acpi: battery: Read Battery charge time for Steamdeck devices
> 
>  drivers/acpi/battery.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
