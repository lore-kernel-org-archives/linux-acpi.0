Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468B313547;
	Wed, 22 Jul 2026 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725410; cv=none; b=LuZHgxuNWf2r4PI7cKWDwzKiJNOFa3Sv7z8rkqu9oNA+sbcDUoWbz+OsZiC7zzHLJJoV6NgYvw4O3s5fW1+3rBi4Utly4UfUHpdraK9S/dDZVwEVHAiI5hlR58RuoW8ju/OzOcqAj/Utsb2sQx4K79vmraJW7ZFDGnHckNQXpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725410; c=relaxed/simple;
	bh=L0U+Sgxsb1knrJMt8CFcjxzdTksFyILXm1X9VTkvol0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l69gYpXUQkorpmmi1V0uC7N+Fksi8qEz9jJ067DIeayZLO6N+jthKLSitUPN5vxoWNBHapsvjEX6Vd8nblOJrvl4BA6jp3LGkf8YYpxIwU3GefkUHy6rkmdSScoIaFAfCan5Exshki8XOspBDCNJP7I+zDf4TFD5T2bWdSEpGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1H/NcBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1H/NcBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB281F000E9;
	Wed, 22 Jul 2026 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784725404;
	bh=E23gUT0OB5m17CIhAx1OfFX3s/0BBfZUO3XE+ke+s/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1H/NcBqxACKDNu8i7xMAm8kepb0J9gpDkJzN3iBDddMn05BNUFfBbl8yhr31KpNG
	 mTu1x11r7CP4rQLAHFPHavFSs4tc5th3Ekzyi/RmyFl8angPWp/dzs80HK3uM2PONZ
	 wIWnrTDBxzQ/Pc6gbtcmNhUscMcIv3ypG23YbYf5ef/NDNhHcdLWczLX7mNmNNBdAk
	 w8YDcnCiICGiFzHYc7gAaLtqyuzGQrTS5ShCKrpR5Z+zpVJFCxGT5UYvNMEewO9Fn1
	 qU1M+X4WA1V8JqFYd7r9Vuj9aN1CD7CGnZ78QLCLc+T3YI/YUWu28yzuWr9GrThWyx
	 wRCAs00cuhtEg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Saverio Miroddi <saverio.pub2@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Saverio Miroddi <saverio.pub2@gmail.com>
Subject:
 [PATCH v1] ACPI: bus: Avoid confusing complaints regarding missing _OSC
 features
Date: Wed, 22 Jul 2026 15:03:21 +0200
Message-ID: <5143711.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <20260721192914.1166891-1-saverio.pub2@gmail.com>
References: <20260721192914.1166891-1-saverio.pub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday, July 21, 2026 9:29:14 PM CEST Saverio Miroddi wrote:
> The ACPI specification defines OSC_CAPABILITIES_MASK_ERROR to mean that
> firmware cleared capability bits requested by the operating system. Some
> firmware sets this status during the control request while returning every
> requested capability unchanged. On the affected system, the requested and
> returned masks were both 0x006a7eff.
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

The existing test variable can be used for this just fine, no need to add more
of them.

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
>  		 */
> -		acpi_handle_err(handle, "_OSC: errors while processing control request\n");
> -		acpi_handle_err(handle, "_OSC: some features may be missing\n");
> +		if (errors != OSC_CAPABILITIES_MASK_ERROR || capabilities_masked) {
> +			acpi_handle_err(handle, "_OSC: errors while processing control request\n");
> +			acpi_handle_err(handle, "_OSC: some features may be missing\n");
> +		}
>  		acpi_osc_error_check(handle, &guid, rev, &cap, retbuf);

And here the debug output is not quite useful if the error is essentially
ignored.

>  	}

So below is my version of this fix, please check it if works for you.

Thanks!

---
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: bus: Avoid confusing complaints regarding missing _OSC features

The platform firmware on some platforms sets OSC_CAPABILITIES_MASK_ERROR
in _OSC error bits even though it actually acknowledges all of the
requested features which after commit e5322888e6bf ("ACPI: bus: Rework
the handling of \_SB._OSC platform features") causes the kernel to
complain unnecessarily.

Avoid the confusing complaints by explicitly checking for that case
in acpi_osc_handshake().

Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -395,10 +395,18 @@ static int acpi_osc_handshake(acpi_handl
 	 * Clear the feature bits in capbuf[] that have not been acknowledged.
 	 * After that, capbuf[] contains the resultant feature mask.
 	 */
-	for (i = OSC_QUERY_DWORD + 1; i < bufsize; i++)
+	for (i = OSC_QUERY_DWORD + 1, test = 0; i < bufsize; i++) {
+		test |= capbuf[i] & ~retbuf[i];
 		capbuf[i] &= retbuf[i];
+	}
 
-	if (retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK) {
+	/*
+	 * Some platforms set OSC_CAPABILITIES_MASK_ERROR even though they
+	 * acknowledge all of the requested features, so avoid complaining in
+	 * those cases unless any other error bits are also set.
+	 */
+	if ((retbuf[OSC_QUERY_DWORD] & OSC_ERROR_MASK) &&
+	    (test || retbuf[OSC_QUERY_DWORD] != OSC_CAPABILITIES_MASK_ERROR)) {
 		/*
 		 * Complain about the unexpected errors and print diagnostic
 		 * information related to them.




