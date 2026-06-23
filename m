Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6433638B7BA;
	Tue, 23 Jun 2026 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242908; cv=none; b=RizDj+LARJZiYh1E+KeGKUqCbOthMywTJ1WbsnifoAP7mDE/sMjTytPdgj8aqgzXV6GNFbDuVXzH2L1Vjza6o1gUyt8ir3lK6xMID7ZIeuQjFOWnqpuCwwTLt4i1j5zTvLCWP4GnCLoNP6naUu+5h2skEy7T1CUgNVb9Kbv4MAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242908; c=relaxed/simple;
	bh=GyEukk6oKYO3DuIrIawJKK4bxtLC+Xas7aOtX14p15g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFBUno00bpEZx2xYwpMme0T7tJfMMld097XnWcdSj0Hq+X3llFzj9HZ913UKD/meWQcPUoPtVbLdyIm+XU1+OuMYxNlUi3UHSaLkpsmCPGu/zU1GYu3YvAgNqL89cyjvKMsrl/SHjzKuBKYdDCWmMXS5Tt4nuW+2Tew7YoyzgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWWz3y6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWWz3y6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40CD1F000E9;
	Tue, 23 Jun 2026 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242907;
	bh=Gr2AHZqj32tHHf/exwuWrI0ZcpawiXX11T3mJg3lrx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BWWz3y6ckuN+G6qYMJmy3jQdoRMOcU4aHSVlF95bpu0YQYD/TsvFxCb5fRnBlXonW
	 Gf5qqMnUgbcMGWKtq2gYebDOiSQXJdYlyuNFy+c7SZY4qfDcE5DzGqUzocOYWk54su
	 KKIeoK2neDy3i87UjjpwlCQpl3MS1lX8IDUbTVtHJno9uthLiPK7SxpiV2QHe5RQCe
	 VKInqx5u7jlERnfotVvDP1e64P5UhLM7WtSor20jcz06xVMvMJ1HO8KKEvEz9zwE/y
	 DIF+d3AT0fCrxEcXiI73/bSJu/EG9oNySstvsF0TUvtcp9VGPkLGTLhNDAaCBmpIFV
	 abhj3AlOaXkHg==
Date: Tue, 23 Jun 2026 12:28:26 -0700
From: Kees Cook <kees@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Thomas Renninger <trenn@suse.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	"Chmielewski, Pawel" <pawel.chmielewski@intel.com>
Subject: Re: [PATCH v1] ACPICA: Unbreak tools build after switching over to
 strscpy_pad()
Message-ID: <202606231227.9F3A16E2F@keescook>
References: <12923581.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12923581.O9o76ZdvQC@rafael.j.wysocki>

On Mon, Jun 22, 2026 at 08:23:09PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 97f7d3f9c9ac ("ACPICA: Replace strncpy() with strscpy_pad() in
> acpi_ut_safe_strncpy()") switched over the ACPICA code in the kernel to
> using strscpy_pad() instead of a combination of strncpy() and manual
> NUL-termination of the destination string, but it overlooked the fact
> that tools also use the code in question and strscpy_pad() is not
> defined in those builds.

Eek. Thanks for fixing this! (This looks almost exactly like the shared
BPF header solution: non-kernel build just keeps using strncpy.)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
