Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7782F7EE0;
	Fri,  3 Jul 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111054; cv=none; b=B84pk0O95BAKXYyIsCRtU0X338xVf+VKM24saJ9D7U87q8IO6AnNHQ9X9pa+9rW/oMak+6lVMMeMjzCnfcdXamTquigRw9LrPEH1zyOfRYtr8YUqbsHOzItDByNERpgMP76LDe+6Fs4TLODb8+1pPl+kqdvmYHVd/iVQMK1P2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111054; c=relaxed/simple;
	bh=GcriZEc4U0XXe7dXq2fvsZPm3rKmmAhSx/ItBsf5aK4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=RyiYxhNRnGSlr0SLsPayEQIvCQkELhciQtM34aQM9GvvW4HuyP6/aboiWiZZFQCOO30Yg4pc7iYaCG0SmTAFFXDQRPM/xtw/C1O7Oax09O03DRYa20sb2t/F+HQvChYSWr1njPna4dkk1nZWu3L5QyRiJtL+ynRmkw/dQWWUXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6+ceFAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6+ceFAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DBC1F000E9;
	Fri,  3 Jul 2026 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111053;
	bh=i//NHTkbfprJa6ZWAaOnkiICtSIwQ8o4UKQkkx8svt0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=V6+ceFAMTfg20u/FFhrV1wNN5T/acbnPfh+cBr/9QVbQC2/7HwAMK9Lr4opvb8HRJ
	 avvPgWn+SXUqvGHLgx3X5FyQ3MS/vUFReOzi8jL9toVQctdZGRKUrt6PW27ap/dBiq
	 tygpRfwZKH2D7wyKdoe29NE0ah8Yl7CQR+hUoNiBVTHAuk3aEo9q6hS0xhPNvxm/1r
	 qqy57phw77CLJQIXWWWLwdoaRRKQRq5x+GoLVb/r6BbmnP2DUilr6kppwUEnd8RO6C
	 vcZ7c73VBRt2kcQNDkIDL7aUgjGtni6JlHVsKf9KTdky3qEpHxFLZa4rRxBSRZcfTW
	 SqGKIHm6TOejw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 22:37:30 +0200
Message-Id: <DJP8443BNCPE.D67486LKL0E2@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v1 2/2] ACPI: scan: Set power.no_pm for all struct
 acpi_device objects
Cc: "Linux ACPI" <linux-acpi@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Hans de Goede" <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "LKML"
 <linux-kernel@vger.kernel.org>, "Linux Documentation"
 <linux-doc@vger.kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, <driver-core@lists.linux.dev>
To: "Rafael J.  Wysocki" <rafael@kernel.org>
References: <6027395.DvuYhMxLoT@rafael.j.wysocki>
 <2436882.ElGaqSPkdT@rafael.j.wysocki>
In-Reply-To: <2436882.ElGaqSPkdT@rafael.j.wysocki>

On Wed Jul 1, 2026 at 9:17 PM CEST, Rafael J.  Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Now that drivers do not bind to ACPI device objects, there is no reason
> for them to be included directly in power management in any way, so set
> power.no_pm for all of them.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
