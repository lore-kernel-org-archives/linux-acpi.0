Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481DC3B1031;
	Mon, 10 Aug 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362047; cv=none; b=rzLQ1JTONqNginsPIkUB+70l7fRYugATjfab+wY3s2QDsqMZjRHYOJh7C2PlheIvgn3+CRTLf7vblyIcs244n2gtjnAB9a+lykdqmB4Mr2tp5yOfyrsUDhYORyT7/y1WX7h5gh2ZEVYMEqSkIy2t4I6wvHytds58I+QQi0La9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362047; c=relaxed/simple;
	bh=Xme5xnRJI/BKYb1tWnUrSQ9rMjRwg4dVhewAifjYDrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nW+doUIoC9XGaTbI/hCGgnowCVPh7Zk/07NH7lpA3qy6DbKk5S04wZlsYHPHw3VIAfyj73u4o/7HlFGPX5/ksv6u0cN9Jc3uMe6Kk7rtGNuxqrEpvHN5UReidLisbjpPr9VXt0t+hPa3ifpS83qIbHvuqzJanA2fJzDZx7G2g1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZMbAu+t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZMbAu+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC11F000E9;
	Mon, 10 Aug 2026 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362045;
	bh=/Oz2ryiLdMNKOEyRJ8NvWLpImznqZBhJbfhU+pNHQas=;
	h=From:To:Cc:Subject:Date;
	b=dZMbAu+t3Ns5fwKgeP7w6iT8UvIJaCrp6GoiBCFnvBbYnEcAPFl9gj62Sd4fjKdfH
	 RSPcLIRGCNDRt0NzKi/PXY13FXTvWMqruYCIVHP6A8Ak4ygbeaixf1lCIf8d98QdQO
	 tr7Htau/KWyQsZ0mngaLaLrwELP7ba0zityCDlDTWojq7TV4yRAsZLPY0PX6Clmjb6
	 h5amCts7bNA88GYEI4we8fYDKRxWFgLbsyrc3lFYc2s6qj7xEpsagU23AviP29oWwu
	 l41pV4IIe7hPuzLo2BIJHEza2/0azK2TZgm3KECtf2Yck7CNHVQ/0HgUT5Jrq/OWze
	 xObVwNMVJ5uww==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v1 0/3] ACPI: bus: Rework acquiring the primary physical for a given
 ACPI one
Date: Mon, 10 Aug 2026 13:28:44 +0200
Message-ID: <4764923.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is somewhat late, but since there will be follow-up changes tree-wide,
it would be good to get it into the mainline sooner than later.

It is based on the observation that the majority of
acpi_get_first_physical_node() callers want to hold a reference on the returned
device and the function is potentially racy because it doesn't get such a
reference itself.  There were also some comments from Sashiko pointing
out to this as a "preexisting issue".

The first patch adds a acpi_get_first_physical_node() replacement called
acpi_bus_get_primary_device() and returning a reference-counted device (the
former is retained for the time being, but made use the same code as the
latter).

The next two patches change the core ACPI code to use the new function
instead of the old one.

Later on, patches will be sent to switch all of the callers of
acpi_get_first_physical_node() over to using acpi_bus_get_primary_device()
and finally to drop the former.

Thanks!



