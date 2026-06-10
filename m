Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2820ED;
	Wed, 10 Jun 2026 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049853; cv=none; b=Ho7E8YMtusvxFtybNuTTB7AO+4+5J4shHx2RU43sywCnOafrXbvmAy0fMXpMcHKfD9FfWSUQ5L/i55FYYxgueNKTMqhrmW5GriFYr8ReSlWoZ+4w3J9WTs+EzpqO+UwQy0MLqbvWvVdfTPwZK+suNhWnbSGwsIntxtNmN6l6mAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049853; c=relaxed/simple;
	bh=Wwz5X/3mDm7kG1Oo0CAaz6uE1PYYKebyNGyUUin0zDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIhD4VePDPJtQ6zwxc1IDMs3OjvwXo5aKw0JoGLjk4/yubW0YkncyJeoX941zJre5qsO2dtiMBxhjNUQfwER0f1DFp1BVN+m/+JulOXjpkZnJ8BqY6yPGQIMHNfJOc1LT1YRbbTUprFP70jQbZEpgidiIPAq20JX24YIZDA+JMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odZ3HEj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odZ3HEj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC1A1F00893;
	Wed, 10 Jun 2026 00:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781049852;
	bh=JapD7e/lelCSMad1a/uaO5pOjNP+cPPuPuzzcbfAtVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odZ3HEj4OBhrgJ6tAZSUB5MuFxiLBeT4LUgW6l6hUFRZQPz+y0ag031J2SWUFKiyG
	 AVQktp4lnHh4xS8N4fKiDTKyv+qWlK0jhpAeclyKPPnUecmRlum+1w7kMoIpdx82J5
	 VouDyHnf2gSI4sAH9aMnXXfz0YYLy2+fziqGvYk+ynDQ1+CCZK1vQMg1iXsqek34jg
	 4NcnTwzX50D0lpGKCsMzbZQTG9nP0nYOuzsHEx6GjePYpJKgtr0kV2h5vzJXQvWxtn
	 RLIGrozo17sZFt3avHe1nFsOTwl16lGMbVnKmt1mDzHJj09TpsQWTY8A8KyExOMs7g
	 P7Am/kg5+hWcw==
From: Danilo Krummrich <dakr@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: allow passing reference args to PROPERTY_ENTRY_REF()
Date: Wed, 10 Jun 2026 02:04:07 +0200
Message-ID: <20260610000407.1915419-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aiTo4dvKu8pyimHA@google.com>
References: <aiTo4dvKu8pyimHA@google.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 6 Jun 2026 20:51:29 -0700, Dmitry Torokhov wrote:
> [PATCH] software node: allow passing reference args to PROPERTY_ENTRY_REF()

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] software node: allow passing reference args to PROPERTY_ENTRY_REF()
      commit: fe221742e388

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
