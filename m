Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498965452B0;
	Tue,  8 Sep 2026 13:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872997; cv=none; b=guY3M4wuGWP8e8WP4CuHRD/Kt4gZVSD3Rcl0AmMfISfAT/2JDHA34OE9EqPcZnCWeKHcSTxx95c7e00ucOkAWBdGk1Zz/yeCX7K9BmI5h7eAcEPoL9xeua3YoYiynhZLI3Z0h5+/7kiLW0Yyg65iXtseo+AwW4pLwn56U3+7sfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872997; c=relaxed/simple;
	bh=eUDMcPSoF0QyiP6nRBMpLO4WB79ZsvZTYEGyBpkZOvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Z91KT7MLfJoMLqBS0IscQfZeSafkChsw9TO+Kb2aye9EPnyYUV5xBNp6lTWsjiu18kR2Y1YwHM7LDuOfFckkVHRQ7NZUR4tUAUAuXZqiyu/9M2cjV9DeLIA/KDXTz7bIqoNoN6BoAyJ7EKR1FneV2jgaIqhUxFBb6j8M9yU55Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtIiol68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtIiol68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216B61F00A3A;
	Tue,  8 Sep 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788872995;
	bh=eUDMcPSoF0QyiP6nRBMpLO4WB79ZsvZTYEGyBpkZOvA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=NtIiol68EIaaNlvtORap8SHuv6KdlniFk5y6+IKt988ZFugmJV5yGj1AvVhbhgRn2
	 faluOrWzmZNcJV4+GssQCxjU+deRGN4yScn0dmN17R9O3gMYbbP5KHtVIbMpGtXa0A
	 jTF9f2YNBXhEVOxLWq1KwpYA69WLq7/qWTiMNFznff8prOXRLND2iFJcSPe9PAnNdZ
	 rp8Ok6W0dfYrS/p2okeMqmO1iyubPYF235y590mLmq5U4jzuNZKW2hK43wViSifA82
	 Ssn3oEkcPzqgJxWJG7wTbxu7bLq5jzLlSdgrGpV05BYTrBO1DFKZz6MhbJrB1wiWAT
	 kNpzrY6vW3xuA==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 15:09:49 +0200
Message-Id: <DL9YJUGAROR8.29QE1H5OO6KKB@kernel.org>
Cc: <Frank.Li@oss.nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Dafna Hirschfeld" <dafna@fastmail.com>, "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>, "Heiko Stuebner"
 <heiko@sntech.de>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 "Vladimir Zapolskiy" <vladimir.zapolskiy@linaro.org>, "Loic Poulain"
 <loic.poulain@oss.qualcomm.com>, <driver-core@lists.linux.dev>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
 <imx@lists.linux.dev>, "Guoniu Zhou" <guoniu.zhou@nxp.com>, "Frank Li"
 <Frank.Li@nxp.com>, "Guoniu Zhou" <guoniu.zhou@oss.nxp.com>, "Laurent
 Pinchart" <laurent.pinchart+renesas@ideasonboard.com>
To: "Sakari Ailus" <sakari.ailus@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/4] device property: Introduce
 fwnode_graph_for_each_endpoint_scoped()
References: <20260625-fw_scoped-v3-0-ffd0868e498d@nxp.com>
 <20260625-fw_scoped-v3-1-ffd0868e498d@nxp.com>
 <amhL1BkIG0uTPceL@kekkonen.localdomain>
In-Reply-To: <amhL1BkIG0uTPceL@kekkonen.localdomain>

On Tue Jul 28, 2026 at 8:27 AM CEST, Sakari Ailus wrote:
> Hi Rafael, Danilo,
>
> Can we merge this via the media tree (assuming you're fine with the
> change)?

Acked-by: Danilo Krummrich <dakr@kernel.org>

> On Thu, Jun 25, 2026 at 10:17:21AM -0400, Frank.Li@oss.nxp.com wrote:
>> From: Frank Li <Frank.Li@nxp.com>
>>=20
>> Similar to recently propose for_each_child_of_node_scoped() this new
>> version of the loop macro instantiates a new local struct fwnode_handle =
*
>> that uses the __free(fwnode_handle) auto cleanup handling so that if a
>> reference to a node is held on early exit from the loop the reference wi=
ll
>> be released. If the loop runs to completion, the child pointer will be N=
ULL
>> and no action will be taken.
>>=20
>> The reason this is useful is that it removes the need for
>> fwnode_handle_put() on early loop exits. If there is a need to retain th=
e
>> reference, then return_ptr(child) or no_free_ptr(child) may be used to
>> safely disable the auto cleanup.
>>=20
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com=
>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
