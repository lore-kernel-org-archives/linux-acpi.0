Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634423DD50E
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605301; cv=none; b=OroHOMwZFda2NaZDNqKKRToqUY/ylxYlC78G6hyNCvFMD5gPA677+e4+RafMto+oWSVoEN+45gMnpxThaHlEmU3/r5vRw5btyvjPJcE1s+iZiv2FvEM5P+Q34uqRdADSEgZ2KRkcAo2invxs1duuPY/lMSktDLFvgECB43/Yav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605301; c=relaxed/simple;
	bh=G/QB1JNOHcc+vsbxLMISXhWfq90+5X/vEx02XOqeVIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlkNAgJB/fRCAZic4aaeyywFOdY5EHXA2ZtLyUDl4nzERliPPcIhjQpkQzGArVoq+Su1AkkHp4/relUikdYKZfxGlN1Bck0GSg3K6e42Mp6MxYH/mtYFblOLSIge2B8n6ttvIY9REQwYH84FmI1g6azx8TDx4/bYFUmLa9LafpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RpVkrPl7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RpVkrPl7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b611274bso991417f8f.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774605297; x=1775210097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KfOjXOUPA7aUNexnAO30qRyN744gIjbadETuO1mA9w=;
        b=RpVkrPl7mNmc5lXbaoQqUC8AJGAdPfi9u0W6ih9UsNNmfxSJidW2wl0LE+VDQYEZaW
         B62lTdwSDBXSNO0iJHP1jo0a13rpKQr0R8m8+v31UumeyRo6E7LpCFAalDVYyWUR+3wQ
         99HrsYS1eMEo2FyCM+I/b1x+EUk/3cocAUHMvNUYix82wYiBXyiN3wbx6arvssIOQpAc
         PFwk4nOIt6jZGJ/VesN0CyCIeVSuIdK7BhzfbFDsjf/2DIeFwqvZr0UGx5eB7HzNmTAG
         sIgRSMgDjsVLJZNYf8WYpauppwMC/IlUBQnOSdSJmZoMH+i4CcmqOiBL+uLkqTgsX0oD
         8lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774605297; x=1775210097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KfOjXOUPA7aUNexnAO30qRyN744gIjbadETuO1mA9w=;
        b=HXeiveK7ryyO3cL2QuRv4Rkhne61Tdi2gj3BkqMRSTyCxijjMPzVEqYidjCjhgWEbo
         LOyOSGtHcgO3QiBpZEl4fX2TBL3gi6Xozp90D783ew7pMZBZzTW1Od2ntlmf2eAmAN9W
         EfMiA/SljlUSEjA1I/2roDpvLNYQAms5lgdyIXbiqw5cUKdIybbMLSEVSqmSU9PUXMdE
         TbJ3aO/wwfXnfYW+oQ/gYrqvFrkYtH2vhfOiAMxZvE4hSY7r3z6LAyMmHHSqA2lAAm0p
         92dOpamWVP8YbO01XkZtlqXFlfnS7MsgOrjzGrYpKHgBVjGA2nHqHb3hOrseRwIecC/E
         CMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJD/BisQUhUdLCqF9XeBS1o1uKLId0c30CDerrHjxdmOdNaT7axVn2QKoTL6eh1i65Utb1kWFyzD6Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LW6lzMYg5g6YcOh/xFuXG6ALGB5su6hpHyB/UK4604Y2LP9C
	sp+kaDOTdb35e7lrNuquSvRLWxz4mjONIBuzVaNfR+L3b/49KCv9XeqCVTJ9KRtxKww6b1gmGBq
	dhE4A
X-Gm-Gg: ATEYQzwFIch44BqyOEwi1DjkmMyXeeIilTIOS2VofRbL9bkQ/tYpeVd71hR6ajoXPbB
	bNBT/UXuEbwHcj2OJSjuyuNBVAME0G2npb6p6MoOX9PonN1q9tFCbdaEkqfvhcPj4ReBeWfxmmn
	YPxKRUuNUY5I+WcLaMbJrjZNX4OKR6hk735Var5yNj9SW+kXmlHH8P/UPygWOXTErKivz6iPG6w
	w143X/FH8awFTClkKXOX6mpAgGP6+Pt8UUo4JjmxK+tO1pVSMxXhg2g6FR10Np7UZc5xLlcJCwH
	bXVe9CJpCTNlst3s0eHE+WhEBczn5Cp/djTHsxB06xskwhTJVHS6M1L0+V+kLNCl9JSjpRWcqDL
	zdMk5+BHTMM/wLw+s3rfOj7IBSxj8LvihTMlmyB448Fp5i39LoAIwVE14wddygJp1GRTn/FJeNz
	MA6OPYRfIhGddpMAZq/O3ZqqTnoQ==
X-Received: by 2002:a5d:64e6:0:b0:43b:8fa4:1937 with SMTP id ffacd0b85a97d-43b9e9d5ea1mr2872332f8f.5.1774605296458;
        Fri, 27 Mar 2026 02:54:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df7e7sm13463368f8f.26.2026.03.27.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:54:56 -0700 (PDT)
Date: Fri, 27 Mar 2026 10:54:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: david.laight.linux@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
Message-ID: <acZT7vZ-4GZdDh3f@pathway.suse.cz>
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326201830.3938-1-david.laight.linux@gmail.com>

On Thu 2026-03-26 20:18:30, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
> to indent traces.
> POSIX requires the empty precision be treated as zero, but the kernel treats
> is as 'no precision specified'.
> Change to ("%*s", level * 4, "") since there is additional whitespace and no
> reason to indent by one space when level is zero.
> 
> --- a/drivers/acpi/acpica/pswalk.c
> +++ b/drivers/acpi/acpica/pswalk.c
> @@ -49,8 +49,7 @@ void acpi_ps_delete_parse_tree(union acpi_parse_object *subtree_root)
>  
>  				/* This debug option will print the entire parse tree */
>  
> -				acpi_os_printf("      %*.s%s %p", (level * 4),
> -					       " ",
> +				acpi_os_printf("      %*s%s %p", (level * 4), "",
>  					       acpi_ps_get_opcode_name(op->
>  								       common.
>  								       aml_opcode),

The change has no visible effect. The precision defines how many
characters are copied from the given string. It does not matter
here because the given string is empty "". The number of added
spaces ' ' is defined by the field width parameter (level * 4).

Anyway, the change makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
