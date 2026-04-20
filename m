Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4C3A380B;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691283; cv=none; b=VonF7YG5CVOrjo/TL4qdc+W/qsrgYU338YwFvT8fLSxZgppOsx9ZMLzBtDnjq1Qlyt/eY+Kl2iOuI3jS5Y7WZdTgKxBMx2YA7r08rLS4kM6r71DByYiz3ymmjCOKYW73xOg20sl9zsIrL6+HI384uKxFmwBxMzjQ3R0LUGuFLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691283; c=relaxed/simple;
	bh=41VcOyArA7xsWl1GqSDSToqyXwVMNgmiVNHeMPkBMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL5X4atsLkkiapy9WSx9Mwjiwl6D3yw4xTtNdnhnZXD6uEcFhMIo7zQtexGC60DoStnM04ZcOg+01agYHySaAj1+BOismoY8eB1cQUmDLcUKGWX7/itzx33q0EkOpip61AFXZkJTDidDsdziYFoU6CiysSbQWiPf4co6v+HlOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq8rVKFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq8rVKFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5655FC2BCB6;
	Mon, 20 Apr 2026 13:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691282;
	bh=41VcOyArA7xsWl1GqSDSToqyXwVMNgmiVNHeMPkBMjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vq8rVKFKDBuK1lXXtvRN5lhV2M7Sb1cQoHqFfCDfURn98MMVEpQvj07pI5hSX32Pe
	 04eSgT7nWHhaadsDaD44jQ/rdYcl9trDCqOqOqPP3ZrNzv3NKPVmMMYeqBAnPZl/Qg
	 ayago+GZg9VHDphRdnMfwbJrKieAxJluqlbVkygNQnHLoIet8Ym8s6Qz7XvXgKUab0
	 0+zGL5nmCKMza7vBbep+OayBJFpJnD1rIpQx0QJKHnkXPqCJ7eogyqapgRqZRjsddb
	 Dv6zeSE6tFPhjDGCg+6sD31VucCdURV3c/v/j7qvays48Trh79TTi+ebTky9rW6J4K
	 Ed6VZssWiquqw==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5.10] ACPI: property: Constify stubs for CONFIG_ACPI=n case
Date: Mon, 20 Apr 2026 09:21:03 -0400
Message-ID: <20260420-stable-reply-acpi-property-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418230704.4178547-1-nathan@kernel.org>
References: <20260418230704.4178547-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Apr 18, 2026, Nathan Chancellor wrote:
> Backport of 5c1a72a0fbe1 ("ACPI: property: Constify stubs for
> CONFIG_ACPI=n case") to 5.10.y.

Queued for 5.10, thanks.

--
Thanks,
Sasha
