Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48B3F4DC3;
	Thu, 30 Jul 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421476; cv=none; b=uh49/wrfsqqJ+sf32ehhBOYw52d+3ji5sJhQS010wey0NxJfnIiXR7M7ZKPXSw9lfExAhECwgxBC/94UIbAb2d+mnydiQscROnGHQyqnfIYup3kDKYknKPH3beMDmiHBWAROuuSsEOl3h8q42QDJTGc9Xr6xNiqY8IHp3WGiClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421476; c=relaxed/simple;
	bh=T89hF+z84grUJCnFMT4dqI1PZeywUXhsnAhWS0T67nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzBpPbB5/PKGtpjb7ELJsOBo86mGhMX5TUx/AALR9pXPgKXKv0UUibTVd3VgRQHxej+H/qAN+4iT9xHaD1GJh/lS3t6itOUhfqeBhoqa5tp71lRSaEsRCgLMwRSPN+nDK3lKBxGUYcJw6XY21nbDRn1hExkFoPbeJLKIwoUwoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgcPy7+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgcPy7+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6323B1F00A3A;
	Thu, 30 Jul 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785421474;
	bh=xPLOrsIKjPGZYxntDA4pNZkyYOgHBu6b32RJk0Udz3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgcPy7+2h5HOrl9R17slR9G/hLDf+4tJWYISS4xOCpgGC22oOWixSvUbc4t+ExFBr
	 rDQZ958gPnZIyrzb4jBBFHquZhaDegV/jrURCKoSQLa+6MCtnPz79oKxRn5mcMOwS9
	 9VKcdd2BBEEHipUs4iukA1ewedEn1E6k0wevxfHXTg+w4sg2NFkYh5Fc0E+KZvzat9
	 CxzCa+3305drF22A4psojHNLDaYmaiQEzZl+brMbCO6y8/hNi/jM8p6/8uohgJFfy2
	 AxXz3ECrJDbVFMMAu3atV1XZ6aUOvTyo4P9AEryCL1EXSDTWyQCZ+yByzzFVQBeyot
	 V3erW0K4MRxLA==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	andriy.shevchenko@linux.intel.com,
	djrscally@gmail.com,
	heikki.krogerus@linux.intel.com,
	sakari.ailus@linux.intel.com,
	brgl@kernel.org,
	rdunlap@infradead.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH] fwnode: add missing kernel-doc for struct fwnode_operations members
Date: Thu, 30 Jul 2026 16:24:30 +0200
Message-ID: <20260730142430.588584-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727202748.2232253-1-dakr@kernel.org>
References: <20260727202748.2232253-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 22:27:40 +0200, Danilo Krummrich wrote:
> [PATCH] fwnode: add missing kernel-doc for struct fwnode_operations members

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] fwnode: add missing kernel-doc for struct fwnode_operations members
      commit: 227717928656

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
