Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B83382DC;
	Fri, 13 Mar 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410959; cv=none; b=e/LqH6QDxJjrnjnZilB+iEL7yaC4eaBLQnnD44xwWEvArhwYfPJbp/ApbeqVxn3itw+U2yJ3bPXFQOSWP43jN69RWlD7uS6UsvISXCFrW0fEOEp8ml30nsmBNKRj53QnhIDwuc+o4Q3dhqZjXcAar3NicRAyDkTMhb2TaRqYQps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410959; c=relaxed/simple;
	bh=ybITQb1ZmhztUzQx5acQBOoSZeJC07chNNTswYpgANs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=GlVTbYxH9oh7UwguO5jDfVXR35Fk04ihLF8bPt1oXg2YzhuN+E++eoVhw387SZRmYpaveRmAzuGXaGvxelULCsrjwL5FrhKa6PsJCNtGFm51y4Xq5CDwN9N9ZognnYXtGM+OXcO0ZUWFsrzqI+IIL4dZCzNsfmwoxK7MLPAsIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFG95/eU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFG95/eU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00797C19425;
	Fri, 13 Mar 2026 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410959;
	bh=ybITQb1ZmhztUzQx5acQBOoSZeJC07chNNTswYpgANs=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=rFG95/eUXMLpdcSsdlOXO3sVhYzLxCeeSD5gLy1HYiU5OsDy2FI5k/ydCN7591bIh
	 8tYzq/ATSP5ZDPOxs3iIrWf51GyEjDHw/8D604HPStWZmiOb0VY+y+l6q3MBTmG7w9
	 aXGKnf4n3QwoMLF61hO/TOG+0BtS76Rtj8dE/wQdEUIIgFGHqzF6NONU0FsEq4nI6s
	 fKX9kU1BJTJ4eSjoUN7N2FEYNOaLBvKwLBDuID+4gxC06OqaRWjvsDvPvvOyYElsE/
	 7E3VpiP0IrczFrKrDv/wX+tfnZveskA4lABw+xYjw/Qu7gVgjv8SyjoGfTC91Ppn2u
	 z5KHcpp19poLA==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 15:09:16 +0100
Message-Id: <DH1PPUB54YNE.2BOVI70MKR2G@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/8] driver core: auxiliary bus: Introduce
 dev_is_auxiliary()
Cc: "Linux ACPI" <linux-acpi@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Hans de Goede" <hansg@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <driver-core@lists.linux.dev>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
 <5079467.GXAFRqVoOG@rafael.j.wysocki>
In-Reply-To: <5079467.GXAFRqVoOG@rafael.j.wysocki>

On Fri Mar 13, 2026 at 1:53 PM CET, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Introduce dev_is_auxiliary() in analogy with dev_is_platform() to
> facilitate subsequent changes.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
