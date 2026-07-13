Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CF3DD851;
	Mon, 13 Jul 2026 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933704; cv=none; b=JmuOOzZftz4gdVHDLlXYE2bnS2GEYHXBGHENGUj3t9eivK+50WTqTeICoLbFCqoQyuiTCmztrvvKwEkMei4bHoJkHSJwUcjQb3cNGO652E2tsq6NVJInCEmAImmh3gaBbpKDxiW7o99UyPYw/wGuLuY/DDuTmhPpVP5XPvS4c8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933704; c=relaxed/simple;
	bh=vIMzUuxHxFqL8tOXSXuVtk8D0W+fd0ZANh/QBRHFHHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8T97SYmW5+zVlVSbYm7XTDkYPMq4TKntK7qrh47Y2eUL58e+JeNp6/ptN64UYUmDOVCWFMAtOYhk5kauRZHZFW6HIfl9p6IcQA7HO1acpTymPbb3NUbraHQPGzFBUtxyhMBsLs5QXqUapp/DacdVtTKJupwPiA9mdVFGyrLm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=v/8ZV28m; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="v/8ZV28m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vIMzUuxHxFqL8tOXSXuVtk8D0W+fd0ZANh/QBRHFHHI=; b=v/8ZV28mhk4Znb0EaOx+s2TQ1P
	7uFqyX3EdHVxCGK1z1oFiZjknx/V4nVGCDWxKAtqnqU2gIceJQ69YmnZP8NKErapRfQTeRP++IgVk
	7P+o6z+lYns7OYc2/fHcj7zeq7SGVsfBCqQ3A0twGLNbNMtcoV+Rux9t+Z94lOSB/DkXFSdH9yBIz
	L7t7mJcwNPx065+Vf5TWTWSiq7kvMs3C0nqF1kxB5mAjqDq+OhcgSkirWSF6eBR52gmRMDWw60zit
	82Oz2yrTj0K8QgCJBhNsvBWNywoCcjEJ4af9Borx51vVn69SafKApITNI0IP5cs1jD9Lmqqxcm49j
	TzXFyhTw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wjCe4-001OGg-2n;
	Mon, 13 Jul 2026 09:08:13 +0000
Date: Mon, 13 Jul 2026 02:08:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, dyoung@redhat.com, tony.luck@intel.com, 
	xueshuai@linux.alibaba.com, vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <alSqd2U9zhqYz1Wn@gmail.com>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
 <aYvi4Y_HNqk_u1-v@fedora>
 <ak0JSScR3EYgLEf9@gmail.com>
 <alDRawveM-auCHwB@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alDRawveM-auCHwB@MiWiFi-R3L-srv>
X-Debian-User: leitao

On Fri, Jul 10, 2026 at 07:03:07PM +0800, Baoquan He wrote:

> Anyway, I am glad to see it's been taken out of vmcoreinfo.c,
> which is going in the right way from kdump side. For its migrating
> into driver folder, leave it to the relevant reviewer to review and
> decide.

On that patch, If you could confirm that moving it away from vmcoreinfo
is the preferred approach, that would help establish consensus around
the right direction.

Thanks,
--breno

