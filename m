Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14793221D89;
	Sun, 22 Feb 2026 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771802366; cv=none; b=Iw3jze6gOPWrj7HJE0LMBC/H96YMkJ9l6rK/OBIf4+0S3SSTy5aX12r0GpPvdmabNI3O2O39DNT/BsODTzn1OWkPwwM4jAos7eKwk5JIDZCwlawxup/pF972TDtyJbXDIHgYog4i/V9YeUKOKZCk/8dGyKpMvrAhhlPODg4/fQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771802366; c=relaxed/simple;
	bh=1Jr2UFYlqfUbVcRlaHdvfopn8D6VYXN8wRPR+OoZSDY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=PurRzkbbuBmssOkXItpkC9X2df8xqAS1K3Cgbc/srPhjM5fqaSXFuN8eIV4FOuHdlSnyADPdWcj8TY8oLBTbsELMgxL5xhKHgIw5lf8cOHip31/TMLG++Y5F9SHh1bN25fOgN86LyrHNs2827qrG5u3RmwgLOcKtqGZCNDDJeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moFamt4L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moFamt4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7FCC116D0;
	Sun, 22 Feb 2026 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771802365;
	bh=1Jr2UFYlqfUbVcRlaHdvfopn8D6VYXN8wRPR+OoZSDY=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=moFamt4LVHii95rcJwIond6Bv6oxAYIMUstt1M01IICrGmNdAahQIU6nMdQeEpxRy
	 9qCFrqX1p273BZ4O2039IwLn0osoHQOphZB2bFUqbk0ylUANlNS237t7kP+aWhy+Zk
	 V1fs3xaSGDG8TaNSBsU3yL8B/O0Y50vSERomdHBM2zN5JGLBo411Y0R/toiU8pg1Kj
	 EQT7ZzeBbvuxrOBkIlMzycBzt7hjq2pEL3DUaDS8s7NbVGHZgRMKVa7KaapZj3cA7q
	 180zUDR78dOOna5w4X3GxwIMgMYIsWT9YIIhtqKbPmaVapiXhVfEtC5zCcECwOMfC1
	 z5xjMbhwNC8Cw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 00:19:21 +0100
Message-Id: <DGLVIO9YF9PK.1WM118M9OSS0N@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in
 fwnode_get_next_child_node()
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <stable@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>

On Tue Feb 10, 2026 at 2:58 PM CET, Andy Shevchenko wrote:
> When device_get_child_node_count() got split to the fwnode and device
> respective APIs, the fwnode didn't inherit the ability to traverse over
> the secondary fwnode. Hence any user, that switches from device to fwnode
> API misses this feature. In particular, this was revealed by the commit
> 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> that effectively broke the GPIO enumeration on Intel Galileo boards.
> Fix this by moving the secondary lookup from device to fwnode API.
>
> Note, in general no device_*() API should go into the depth of the fwnode
> implementation.
>
> Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try =
secondary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to driver-core-linus, thanks!
