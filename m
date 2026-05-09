Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416461A9FA4;
	Sat,  9 May 2026 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351348; cv=none; b=ohsB6mwu7YytjM2RwJnmEKwJmPk4qkVv3InPFypGK54TuWC1JXgR+IHIcgoHdtYSqY4DGrLxBACJP4JT011be1iIurT8LHClGMyYM4kNYi6ETnN7E5v+FMiBeNtGSMroz3rxrSsCsejg7mImloteh0tul5uIuUHckNVQmzmZ1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351348; c=relaxed/simple;
	bh=Vzoz+PNXxXm5/LxxoH+vgwG64mJzfDDdPBGzhbLSb5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BK2fOr1/3ZuNFPRP8J/a4IHXlFwh/Uy9/mbtA7kNIs/GllrclVp59M+tGkMvhkSb3C4Q3i7+Sg+C5nqgi8vQSeQ2eGf9b1MNnqsWmwHylZonEm06eqdtrxm5vwB3Dtu2kZgNW4MVgnOllsHaL7bMvPLGo+xo8RdxeH+bE73z4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBlmQdRQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBlmQdRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44616C2BCC4;
	Sat,  9 May 2026 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778351347;
	bh=Vzoz+PNXxXm5/LxxoH+vgwG64mJzfDDdPBGzhbLSb5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBlmQdRQpreorP/58lch7N9M48ttLqVKHZzi/v2Ixen98ZLyGalQMCxWFDieFyDVr
	 HAvYmIw6dpT7J1yBaBcVhNhBPpRfCsor9cfenSM4VBFtsUJmsRj1iJOIPen49dCuFk
	 HmmzpI/2zWioijPKJvwGseBcFXg2Sf8wWHBTr7q/Q2TepN1DAibfGAU34irGCqKR64
	 vWnLGJGQiV6bWmXX4uFAVgzLpo2ArpJY8Kq1wp5/SgZFMiqi6tV15ddBhXjyXoagFW
	 SRLi5CXFXb4lOkxZasNdPwHfwsAfrwwVOjxFHs5rfeXin5KEqmOMq97ApUhdr0f/ls
	 keyB4dOZaOzLw==
From: Danilo Krummrich <dakr@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	brgl@kernel.org
Subject: Re: [PATCH v2] software node: provide wrappers around kobject_get/put()
Date: Sat,  9 May 2026 20:29:02 +0200
Message-ID: <20260509182902.2185087-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427131825.15793-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260427131825.15793-1-bartosz.golaszewski@oss.qualcomm.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 15:18:25 +0200, Bartosz Golaszewski wrote:
> [PATCH v2] software node: provide wrappers around kobject_get/put()

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] software node: provide wrappers around kobject_get/put()
      commit: c393ef0741d4

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
