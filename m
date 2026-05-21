Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31C3FCB2C;
	Thu, 21 May 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370872; cv=none; b=Xfrofd2VYLht+lGzMZGbEpv9HYmSsIlcpxr994cvedkE6xpylqxIFsNylxIRDOvIwLjIKFlkqU/canI7dj5oG8W4YTdRmricI7nn1/Y8IDsDTBaSct8dZYQCWTCiarA6WZz0zeWfXwRh82LjVLHTj8kfbebsMZ84fKH5ae6so70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370872; c=relaxed/simple;
	bh=/m5GAPDxBXC57o9MS7lXtAhigox27qOtolnbV6iVLRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJJmEb7DmzBYfFs7YWjfquqHJY1C/z0L3qc+hdZMvfbXtiA16YGWDBEeP3n7XqTJlSQJMKUHLOFyoAKM576E/mJP60XSPcucEgjkqod/0WL2aCZShO2amj79rWxK93yc+E+lgkx8pVJ1XyC5OhfmDj97Yo1kGfvDCxT/0Tf64RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH6eG9Gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH6eG9Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57921F000E9;
	Thu, 21 May 2026 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370871;
	bh=/m5GAPDxBXC57o9MS7lXtAhigox27qOtolnbV6iVLRQ=;
	h=From:To:Cc:Subject:Date;
	b=aH6eG9GdW+aQ5YtcUJSTPYRMk6ZfBqsja4+XYbl0+XcXsHmEsTbzEcAKwjuVl3F28
	 qvpDkJYTiGeSlu6LX8Kpi+KagIalGLFaZQ5DTqt/c3PCfX0J9RQ4PKLDnsfNrJ1OJy
	 o8UXx436ug0ZqW8mCkVKeZGXDmp1GePVj2tnnv9niqM84DQGgvVISuCBprQ2BvmaLr
	 +zY5BVSyhUt4TDPybyHfeHhrvRH6VCYuMLFKjrnx4+hzSBEnlPU2Ge+9ibYWknCCBW
	 NvA5K1dhNu/e9+MVgtfLg/ocbXr2YAeo+bwqZHANsLnEjAyUxVtbGnxaHgWTUDWJ3q
	 4X8cGHgj1MqOQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nick <nick@kousu.ca>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v1 0/3] ACPI: button: Fixes related to GPE handling and probe error
 path
Date: Thu, 21 May 2026 15:31:08 +0200
Message-ID: <5996185.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This series fix three issues related to the ACPI button driver,
one introduced during the 6.15 development cycle, one from the 7.0
cycle, and one that has been there for a long time, but has been
omitted by mistake by a recent commit.

Thanks!



