Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33D4582C0;
	Tue, 21 Jul 2026 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675702; cv=none; b=DJo4rg5KY+8A36tO7oe7gJnHGZtwkfy9jrHn91z5VkJrSYngpSH8VnbnKT063NkZDJCMAeEGVu+E6fwTvlqkBhUdJkGxqjEWrzX3dhjZVMejZDDBU5TdGbsOrVCyH6cSAi6o41WMGMg9pwntjw9v40Nj1+HznW3OhIVlhHthZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675702; c=relaxed/simple;
	bh=nXCOKU8pnxwckC3Apse6YxnMzSmsAhVxTn0oovNZ3+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXSKZZsp95weqIbRhCWTN8y6AcvSK0uEgWqti9Glj+ga+t1hHJadC82F1pXheYr0PSdR4u9MSJUvUAXHjSIJmJ5evguWKXF788M8pVQUYkKcOR9qpl3g4p/pol0hikYhLFVr3PRAmWR5Vkl6YOj8RkG6RlhHWU39ZsOCmFeuSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVhq0TrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVhq0TrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D16B1F000E9;
	Tue, 21 Jul 2026 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784675697;
	bh=yDlmR4S4ggSSbXuW24SNIKmox9pma1gbJgkNAzZCkVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NVhq0TrNIjhpPQhnHJsE25UDT3EM0rTo6REgf05pXyo1vfeo9rLoTLbiA84ndN6j2
	 YgVgPABsif+JCxNn3+ur5GnLOnf+/yQBusZm0CAiRpG97pLq/DubwYHXbTAtcnLio7
	 +01eYLJgN10W5WF/nJJOQkjM2mhsre2RI0DDKNPwpRjjbswAOE8rj4BLzDgzMtR+qq
	 FTR5NTRMJxdyvf0Ef9se5XfZ/3CKnVtcImRlxAAkQ2oOfqb0pclaUVO/DRLBi3OcIo
	 Y6ErHXHiQWEodOJ003SLRE0z/s0TfTpAUlHILvdcvBAjaeJB+PFkS/JTEkwnf2Jd9I
	 9r1Lu+ChE6q5A==
Date: Wed, 22 Jul 2026 00:14:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Saverio Miroddi <saverio.pub2@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: bus: Avoid misleading _OSC missing-feature errors
Message-ID: <20260722001452.019b3e32@jic23-huawei>
In-Reply-To: <20260721192914.1166891-1-saverio.pub2@gmail.com>
References: <20260721192914.1166891-1-saverio.pub2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 21:29:14 +0200
Saverio Miroddi <saverio.pub2@gmail.com> wrote:

> The ACPI specification defines OSC_CAPABILITIES_MASK_ERROR to mean that
> firmware cleared capability bits requested by the operating system. Some
> firmware sets this status during the control request while returning every
> requested capability unchanged. On the affected system, the requested and
> returned masks were both 0x006a7eff.

Just to check my understanding.  When a system does this there is no error?
Is it happy with the capabilities requested?  So the return value is simply
a firmware bug? (just one we didn't notice before).

> 
> Commit e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC
> platform features") made all control-response errors produce error-level
> messages. Consequently, the inconsistent response above now claims that
> features may be missing even though none were removed.
> 
> Track whether the response actually clears a requested bit and omit the
> error-level messages only if OSC_CAPABILITIES_MASK_ERROR is the sole
> error and no capability was cleared. Keep the dynamic-debug diagnostic and
> leave the negotiated capability mask and all other error cases unchanged.
> 
> Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
> Signed-off-by: Saverio Miroddi <saverio.pub2@gmail.com>
> ---
>  drivers/acpi/bus.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a30a904f6535..c13128cbc2f6 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -335,7 +335,8 @@ static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
>  		.length = bufsize * sizeof(u32),
>  	};
>  	struct acpi_buffer output;
> -	u32 *retbuf, test;
> +	u32 *retbuf, test, errors;
> +	bool capabilities_masked = false;
>  	guid_t guid;
>  	int ret, i;
>  
> @@ -395,16 +396,24 @@ static int acpi_osc_handshake(acpi_handle handle, const char *uuid_str,
>  	 * Clear the feature bits in capbuf[] that have not been acknowledged.
>  	 * After that, capbuf[] contains the resultant feature mask.
>  	 */
> -	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++)
> +	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++) {
> +		if (capbuf[i] & ~retbuf[i])
> +			capabilities_masked = true;
> +
>  		capbuf[i] &= retbuf[i];
> +	}
>  
> -	if (retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK) {
> +	errors = retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK;
> +	if (errors) {
>  		/*
> -		 * Complain about the unexpected errors and print diagnostic
> -		 * information related to them.
> +		 * Some firmware sets OSC_CAPABILITIES_MASK_ERROR without clearing
> +		 * any requested capability.  Only complain if another error is
> +		 * present or a capability was actually masked.

Can you add a clarification here on what we think the firmware is indicating
when it does this.

>  		 */
> -		acpi_handle_err(handle, "_OSC: errors while processing control request\n");
> -		acpi_handle_err(handle, "_OSC: some features may be missing\n");
> +		if (errors != OSC_CAPABILITIES_MASK_ERROR || capabilities_masked) {
> +			acpi_handle_err(handle, "_OSC: errors while processing control request\n");

Related to questions above, but this print is true on any error return even if perhaps
we are sure the next print is not.

> +			acpi_handle_err(handle, "_OSC: some features may be missing\n");
> +		}
>  		acpi_osc_error_check(handle, &guid, rev, &cap, retbuf);
>  	}
>  

