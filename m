Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5534CF49E;
	Fri, 16 Oct 2026 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792192549; cv=none; b=gFcj3SIPbJkYU5k4JYg0Cnj5ucCj5lPMqmJB/IwxQ1s2QuHythEVAuGgDS+d/udwSjSbqVEDOF/rgNKINNCwPJ4mdhTcDHohFMSCNyM/06EdKh6aBvtHxuQSVU5kb+bVC7UO01fR3hN7yZaRYXChfkWCXz9qt1/MRjfV0Q7xBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792192549; c=relaxed/simple;
	bh=xx+EvyylbKDwCWbHOLoDdPPVf8JgaKxvINlKGe5txag=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FMzwK9VQtoMysst6oTsxJw961H48jpZD7wZKcWQY8h0omz6oyoCTViKPmGspRqH9Dj36UOFAj3wZSmzsooHxFpyEp5xODiAzzv0MUHUZAbNdNjSySuUgz1ZLsNS4ZsAwPqs3zrdOGMb5hl7gKigIkGzIeUJ5s7pq4Oy92OZYU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xTPk+rMq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xTPk+rMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1CE1F000C4;
	Fri, 16 Oct 2026 23:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792192548;
	bh=xD5WC0FNKWe15/BST2na89x04OYUKTeuCrOFyJdym/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=xTPk+rMq1VGaVLDIV+9Bb/FtmSP4yv3Mdt+/QE5S3a+9mf+s4EOAy+xAuC695hRrg
	 gKDXfXH1GzYdo+pQzLtcpItThF005mZK4/t8A1IXm7kBY8Ypmbn6fzKkcxPdtBKyZt
	 qRHgPZH4prVCmKv9sipyUMuIJcGoR0QrnM0eeC54=
Date: Fri, 16 Oct 2026 16:15:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dave Jiang
 <dave.jiang@intel.com>
Subject: Re: [PATCH] lib/firmware_table: validate subtable bounds
Message-Id: <20261016161547.bc418897d11f3f19924065b4@linux-foundation.org>
In-Reply-To: <20261016144154.2818962-1-yaojiale02@163.com>
References: <20261016144154.2818962-1-yaojiale02@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 22:41:54 +0800 Jiale Yao <yaojiale02@163.com> wrote:

> The generic firmware table walker dispatches matching entries after only
> checking that a generic subtable header is present. A record whose
> declared length is shorter than its header or extends past the table can
> therefore reach a handler before its bounds have been established.
> 
> Validate the complete generic header and the declared record range
> before looking up or invoking a handler. This also rejects zero-length
> records and prevents malformed lengths from advancing the cursor outside
> the table.

Thanks.

get_maintainer is quite unreliable with lib/ files.  Please always use
git-blame when determining who should be cc'ed.

Dave, can you please take a look?

> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -172,7 +172,20 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  	    ((unsigned long)table_header + table_size);
>  	subtable_len = acpi_get_subtable_header_length(&entry);
>  
> -	while (((unsigned long)entry.hdr) + subtable_len < table_end) {
> +	while ((unsigned long)entry.hdr < table_end) {
> +		if (table_end - (unsigned long)entry.hdr < subtable_len) {
> +			pr_err("[%4.4s] Invalid subtable header\n", id);
> +			return -EINVAL;
> +		}
> +
> +		entry_len = acpi_get_entry_length(&entry);
> +		if (entry_len < subtable_len ||
> +		    entry_len > table_end - (unsigned long)entry.hdr) {
> +			pr_err("[%4.4s:0x%02lx] Invalid length %lu\n", id,
> +			       acpi_get_entry_type(&entry), entry_len);
> +			return -EINVAL;
> +		}
> +
>  		for (i = 0; i < proc_num; i++) {
>  			if (acpi_get_entry_type(&entry) != proc[i].id)
>  				continue;
> @@ -186,16 +199,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  			break;
>  		}
>  
> -		/*
> -		 * If entry->length is 0, break from this loop to avoid
> -		 * infinite loop.
> -		 */
> -		entry_len = acpi_get_entry_length(&entry);
> -		if (entry_len == 0) {
> -			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
> -			return -EINVAL;
> -		}
> -
>  		entry.hdr = (union acpi_subtable_headers *)
>  		    ((unsigned long)entry.hdr + entry_len);
>  	}
> -- 
> 2.34.1
