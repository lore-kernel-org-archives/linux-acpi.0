Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DC35979;
	Sat, 18 Jul 2026 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384297; cv=none; b=l70pR07tLyjIA6ToCvV2X25xO1+aDcv1ekLWs3SEqKMBXg7YD2pq8fx9iW4AxkxzmjefRucN6TbOY98b8m985tTbHJjnlnhGEjFHxOIVfDo8UbHQAORak2sgMIjw57sTqqmUOuNGzmh0+Z6K2j07YEEPOlnYurSJq24j0QCcKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384297; c=relaxed/simple;
	bh=Hg5FxksN2cedaO21JgLcRj8gAehHoWoAhbnVpb2Kk2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=A280Kz7wNt40M1AP5UvNWxoWUvhKVzkKP4LshvxgE1f+Z6hWUsgtF6N3wXj8Lerf4LnEVsoVCGwfzMS0TMzdlf3G8F3+55q4YIsTBs5ao72mmvTYs4bG2TOs0fHfa1MThzUHJLGhQCJ+KWxf0Ws8fSDda8tX10Tsb61GEGyi3N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRBOH28Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRBOH28Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BAF1F000E9;
	Sat, 18 Jul 2026 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784384296;
	bh=Hg5FxksN2cedaO21JgLcRj8gAehHoWoAhbnVpb2Kk2g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=JRBOH28YS+RbtBWAAXn7MBfUpynpY+00r6bYwH9ao1UfQVgcjZ6fKjJynYq2sMxKt
	 dfGUiD6I8D342Nq2FUrU/VYS6f3WM2XVY442YKQ02Sw0D/VIQM2KuCpq8dMqMU1WHO
	 YlFTZKiRnAtwJm89/iHipVdz9dJdJdMd4qZu1KxB7xP+/GD0hHMG9zvdYFK28GOXiq
	 EBzNtZU/Gc4a8SVukysNr2fqs11SeK1cIrcO0F/QdmA8Lc4/mg5Qt+4oQCpLJL5YRH
	 LBijEmaO9uRSazZvxMMEMVusqFeSwhUtcvxjF0TnzojzklrWgU9rRkYNS94i3SgoW+
	 VBJZFygt2XnFg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 16:18:12 +0200
Message-Id: <DK1RFV9AABBD.KP0VPMWKFYWM@kernel.org>
Subject: Re: [PATCH v4 3/3] device property: add test cases for
 fwnode_for_each_child_node()
Cc: "Xu Yang" <xu.yang_2@nxp.com>, <linux-acpi@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Daniel
 Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>,
 <devicetree@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
 <20260611203537.1786399-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260611203537.1786399-4-andriy.shevchenko@linux.intel.com>

(Cc: OF)

On Thu Jun 11, 2026 at 10:31 PM CEST, Andy Shevchenko wrote:
> From: Xu Yang <xu.yang_2@nxp.com>
>
> Add test cases for fwnode_for_each_child_node() API.
>
> Test command:
> $ ./tools/testing/kunit/kunit.py run property-entry
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch broke the build [1], hence I dropped it from the queue (but kept=
 the
first two patches of this series).

of_node_init() can't be used from modules, either it needs EXPORT_SYMBOL_GP=
L()
itself, or of_node_ktype needs to be exported for this kunit test to work.

[1] https://lore.kernel.org/all/202607181651.RnUuV8n6-lkp@intel.com/
