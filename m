Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C14BEE20
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827601; cv=none; b=PfSQ6CfhyBscPYh2OPzjerOFIYeZcEykGBQq85b9c//i8TRIJyXjkc6LO5aCQuEf49GVya0t/6zGmhNUHgpHE6vKVexpnjAYkC1IcOETlH89h7HNxRA0a1yBZEyuJ5JWkWUOyFxOtqyiDKeVcGSf+E3+w8+Bi7ngYpzN7cBv0DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827601; c=relaxed/simple;
	bh=5yEKgPOGicpMxBFlJWtx7YufLwPyGaBoBvclQixlx9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amk6Gzjzispisckxr/kzoAmdxt0JWsfxIDdwX2TvulI2ruZFSH+Dr9u9/8BXfQA0PSSvABza7aalQAIwlwB6i+JhW97XB+BFh3ZK1+/NOWUuZbrVI9VSjdpFujVd0EtOiylGRFpgpzhnZvLScAsUGp7QSzsVMea5IOLRuDeOC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX2Mf2H+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX2Mf2H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C382A1F0089B
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791827600;
	bh=/y391TGDcvyQwXbh4hH2fOqRNprRkLpGxVrH7rsjr/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gX2Mf2H+wdyhnGuKdQPEYnpgiXR6tGyRSYVFAj0MCv9xyMDq4vtC9NvpKqUgg5rDn
	 cmyHy5ciRusumFmB/fifmDygC3dPav7JTjzV4Yho56kHWPOII1qlpLUyJgKL5doDOM
	 cZD017xDd0YwSJjuptuLBXCDr4ztqZJN1ag+HPqIwstltmWGEUN+hXGHdgLqWPKZ7l
	 0SIYH4Li68+kSQjp3SeOCLxni3/L6BvGPclTTkvkw7hJpwOkn2rjmlvq6KQmR71sXp
	 ahoztaFy4i24oc5YkX5Jj0/ulDnmSYGVasGzBr9aDXsZPnU+2u9p5fYZ7J+5pJQYp5
	 BPgrlCSY7DoWA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba3fba0080so1346334e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 10:53:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByHTkKEcpk1hwKtradir43fAAkfvCkLTm5bBFibV83bFfbLA+3kaMg4QrXygNaTfTcwmpeTD7zGMxTX@vger.kernel.org
X-Gm-Message-State: AFq9FYJvC9C+gv8/pLHMC7kZ1euRLXXzD40Y89s4sl1KI+0B2kZie7O8
	PY+3263wPw5YKFu8fCxiPHW+OUW5qj1UER8aRvbbaWXg5bUFbERqqnw//yUOZAcrZCLwlblBa+A
	U8kQ5X6B0HF43jWjddpnPR/vOk4Fjb1o=
X-Received: by 2002:a05:6512:1284:b0:5bc:b728:324 with SMTP id
 2adb3069b0e04-5bcde6be018mr3241540e87.12.1791827598373; Mon, 12 Oct 2026
 10:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179095238036.1979087.7916496223328936920.acpi-device-id-docs-v2@gmail.com>
In-Reply-To: <179095238036.1979087.7916496223328936920.acpi-device-id-docs-v2@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 19:51:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irqbrMDNikcFmTRyakWvcLjDxB5y1vOymwZnp4kM8jqg@mail.gmail.com>
X-Gm-Features: AclHuK9FQpA2UeIcQN6SBcLM8QgiLSCr43agXt6T5sZ9fbUoTPP4BGhwhasdvfs
Message-ID: <CAJZ5v0irqbrMDNikcFmTRyakWvcLjDxB5y1vOymwZnp4kM8jqg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: device-id: document struct acpi_device_id
To: miguelgarciaroman8@gmail.com
Cc: rafael@kernel.org, u.kleine-koenig@baylibre.com, kmehltretter@gmail.com, 
	andriy.shevchenko@linux.intel.com, corbet@lwn.net, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 4:47=E2=80=AFPM Miguel Garcia via B4 Relay
<devnull+miguelgarciaroman8.gmail.com@kernel.org> wrote:
>
> From: Miguel Garcia <miguelgarciaroman8@gmail.com>
>
> struct acpi_device_id lacks kernel-doc, so extracting documentation from
> its header describes ACPI_DEVICE_CLASS() but not the matching table entry=
.
>
> Document the four members, ID and class-code matching, and the table
> terminator. This complements the documentation header-split work
> without changing its include directives.
>
> Link: https://lore.kernel.org/all/aqEWUBf1pewPP_K2@monoceros/
> Assisted-by: LLM
> Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
> ---
> Changes in v2:
> - Use ACPI_DEVICE_CLASS() in the commit message, as requested by Andy.
> - Move the drafting and validation notes below the commit message.
> - Describe the related header-split work without assuming its status.
> - No change to the source diff.
>
> v1: https://lore.kernel.org/r/20260913095111.2543502-1-miguelgarciaroman8=
@gmail.com/
>
> An LLM drafted this comment and changelog after being asked to address
> the missing documentation noted in the header-split discussion. The
> field descriptions were checked against the ACPI matching code. The
> extracted documentation passes kernel-doc and a focused Sphinx HTML
> build with warnings treated as errors; checkpatch reports no warnings.
>
>  include/linux/device-id/acpi.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/device-id/acpi.h b/include/linux/device-id/acp=
i.h
> index 65800cefd..8c3b30ebf 100644
> --- a/include/linux/device-id/acpi.h
> +++ b/include/linux/device-id/acpi.h
> @@ -9,6 +9,16 @@ typedef unsigned long kernel_ulong_t;
>
>  #define ACPI_ID_LEN    16
>
> +/**
> + * struct acpi_device_id - ACPI device matching table entry
> + * @id: NUL-terminated hardware ID (_HID) or compatible ID (_CID) to mat=
ch.

This should be

+ * @id: NUL-terminated ACPI or PNP device ID (as defined by the ACPI
specification) to match.

> + * @driver_data: Data private to the driver.
> + * @cls: PCI-defined class, subclass and programming interface code (_CL=
S).
> + * @cls_msk: Mask selecting the class-code fields to match.
> + *
> + * Use @id for ID matching or ACPI_DEVICE_CLASS() for class-code matchin=
g.

I would say here

"Either @id is used for device ID matching, or @cls along with
@cls_mask is used for class-code matching via ACPI_DEVICE_CLASS()."

> + * Terminate the table with an entry whose @id is empty and @cls is zero=
.

s/is empty/represents an empty string/

> + */
>  struct acpi_device_id {
>         __u8 id[ACPI_ID_LEN];
>         kernel_ulong_t driver_data;
> --
