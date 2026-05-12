Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F53CDBB0;
	Tue, 12 May 2026 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602879; cv=none; b=Ke0rsZmNeS3BeXaoV4naGQFmeSS7arxMm7x0Ye6ndP0pbYy//hrzOYr2e/zTFV6GtpNiyWvwqvTMNH7G6Ys0IfG8PLHLLxk5ODUQWfN2SFu8cBTAEr/tBhwarV/JoW8pNnrJWc+v/eMC9ZxeRTOhBC+SUTKiifoQpCM6wwRDjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602879; c=relaxed/simple;
	bh=F87aZ4FWhR9nuj1HGK7ePAu/A77/HItYGZiWknzkpTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iOScqF1sqw2iQi0Qh2LUdLd7dqmjuL6GLOBfpAz9TAZifVkMvdaP6F/EbxugHnzIWLz1WSBXB8esr7VZONdGQUc5fZB2zPWM7KOTFgDSuO1foFIN/uf/r8212L2eGn/jgdIQEOq/h+ljGFEAgruhwUlDs9Xb5EZn16wR0iHbLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTpYIOY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTpYIOY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ECAC2BCF5;
	Tue, 12 May 2026 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602878;
	bh=F87aZ4FWhR9nuj1HGK7ePAu/A77/HItYGZiWknzkpTE=;
	h=From:To:Cc:Subject:Date:From;
	b=QTpYIOY7GE9C5f9g176TSxXvHfSxd4X1g/zChAYzaedBd1wpczfUqTNtVHLr53YA7
	 hb7CA5nP3zBTlPNccvaLSH8f/6sBA40RIm5XHAHyVxbj9mg8UT7DJFXdwyiXeNHNHS
	 Y0EMPPAHQJkYUzsDO0k7a3j2hQlL/NSnORlHTgoMWuZVkAia/LJH7P1rdg1NYvzVd2
	 SRnSIIbHA/FLIoMvxe6qKoBwApd+HtbAFZhjTv/iL1y7V0Cs9WUyMtgtwn8IdEqkQ8
	 iQ+jn9uu1bKTN3ar2R88nEHX/BYqXtkBUHC6GH4zns3QR49TVtfGkm3MyKFoD+0LcU
	 YTEo194xQTI9Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v1 0/2] drivers: char: Check ACPI_COMPANION() against NULL at probe
 time
Date: Tue, 12 May 2026 18:19:29 +0200
Message-ID: <6283162.lOV4Wx5bFT@rafael.j.wysocki>
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

This series fixes up two char drivers recently converted to platform drivers
to make them check the devices ACPI companion objects at probe time.

Thanks!



