Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07A330330;
	Fri, 13 Mar 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410929; cv=none; b=BCQIvEHUsm74brFRymo7fvbhpcZMFblRAmpADilNPTWgBjv7OMAlWyuXlG71Q4e13iKbZvar2KUt90mvnhd5LyGQ5JhLRowwmYKzJZ08DLviDBpLJK+eAzYHxlOfz2QLbcnjPovMTQVZ4Tk9UVLYA/IHkNfgfw/NadXwa3KoVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410929; c=relaxed/simple;
	bh=+UDTkCa92h6P4LrbhshmDNCNWpzEklylGdhu16mAZik=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=HTCLOVHKRnlNREQaKSnP2e6BFsdIV2AmEHK0UuPqrDEAF/WpIHdsgficw5sE1xMuR2Dbxh1qhnjxtf/nenm4XpwvuHnlfZ/E3i+uZ/dtREOiE1kxnPMpf2W3Pb0+DHowwwJWjN/p/ZKRmfXSTbyPQtbVqCA4k7Kf8QreMtVMfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR/lkaT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR/lkaT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457E1C19421;
	Fri, 13 Mar 2026 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410929;
	bh=+UDTkCa92h6P4LrbhshmDNCNWpzEklylGdhu16mAZik=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=tR/lkaT70lVFRge3yysI5aTbHFuGF77LV3M/r4/w1JOa4tu5lYa92P640gy+K/nAE
	 ldkFDisETjVX0RnuW1Fm8evtpjtskJvQ7gb1RMjPMoh+qjYaJtfBQ8mvy2/sH7jGu2
	 3jrD/UrBeUJh7EOxL6tAFERLOZMh6sbkxElL4CTlJN9CNfAmFUxVqzgWt1Jlyu2TLm
	 zPlE+EDEk8Wzi9KochG//VQJG0wNppPYlaatdZohhwPO4Gx9dIpAgGLefQHs+7FlQw
	 c8fnry58AKB9ZN35DmiQBd/lnELd7yxKDNElAfUvGsOcRA9JozXodeaAFyP9DjRL3r
	 7AND9ssOy0N/A==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 15:08:46 +0100
Message-Id: <DH1PPGLYFK8V.1PNS6L6267WXR@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/8] ACPI: video: Rework checking for duplicate video
 bus devices
Cc: "Linux ACPI" <linux-acpi@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linux Driver Core
 Development" <driver-core@lists.linux.dev>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
 <3058492.e9J7NaK4W3@rafael.j.wysocki>
In-Reply-To: <3058492.e9J7NaK4W3@rafael.j.wysocki>

On Fri Mar 13, 2026 at 1:56 PM CET, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The current way of checking for duplicate video bus devices in
> acpi_video_bus_probe() is based on walking the ACPI namespace which is
> not necessary after recent driver conversions.  It is also susceptible
> to race conditions (for example, if two video bus devices are probed at
> the same time) and ordering issues.
>
> Instead of doing it the old way, inspect the children of the parent of
> the device being probed, excluding the latter and the children that are
> not auxiliary devices.  For each of the remaining children, check if any
> of the entries in the video_bus_head list is equal to its driver data
> which can only happen if the given child has been processed by
> acpi_video_bus_probe() successfully and so it is a duplicate of the
> one being probed.
>
> Moreover, to prevent acpi_video_bus_probe() from processing two devices
> concurrently, which might defeat the above check, use a new internal
> mutex in it.
>
> Also, print the FW_BUG message only if allow_duplicates is unset which
> allows the entire duplicates check to be skipped in that case (doing
> it just to print the message about the case that is going to be
> ignored anyway is kind of pointless).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
