Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E13C2795
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767491; cv=none; b=U4wmOmyiMfwvCnX1vlDhLdedf92W3fSi5JddbLQSAEvRQDvmDqAhcGNJjIzh8tdzDwJ64YVv7d7kOSc3n8+YwVG6oQ6eNLLfzQRfoJzCMIwp0yiXiP/1CGt5fjaO2UupO3SH2xuRvRPrBdnHQvirD58w7sDxT29S9KCMaSgGZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767491; c=relaxed/simple;
	bh=cUOFFUEPGUl6/0IoSS/webMA+stfnfYvtBJgxAPcIFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu1L/6C7kk1dUxadAkUGznXeGgMazZ2oCuuJBdoN2A7HCLbPevwFDDatI42bs52CPg+jJHYrj1gv9F+vASHfehtHs32qbgD9+mpZ4OGIgAk2wpw05A/ayi8Cat2tf6PqlkNex0gFbyWJqRKLOAAaQyYUmerq2RjLiMaPI+4hVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9GNDAfM; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9GNDAfM"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bf132969bso5491896eec.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2026 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782767479; x=1783372279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kxSpolFBpZ3ZN9a09p1x35bRlHFyG6e6uPx1x5cjXY=;
        b=Y9GNDAfMegdwMn0qhGuuHCIeyuZaU0VCVccpjzYHrN6u7zpgBvVvHdHCBHWepg6eOU
         aLZ8yXkKXdeqpPKAPUnKFD5r988hMRQ6+BOuY9yeUD23OWdk3jPNYROaWhJaOcb6WYQt
         R8y2ccFN4yBSbk+xJMcePAV2bJQzuG2h19cH5Zki43d+4YQRApQPVqUXx5ng/TIyOlEK
         uscYjK/G4j9YgLfiu+l7khKfVAduxF2FTWJx73nk4Xnwvnp//sfz1WNLWTAv5Jp14Ydw
         xBEWm6/d+FtpQOc8YftqC429DVXZ6R4S2pS1D6X6Ucp/HsmSaUh6Aj8PdRwhd6odT+q+
         5zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782767479; x=1783372279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7kxSpolFBpZ3ZN9a09p1x35bRlHFyG6e6uPx1x5cjXY=;
        b=EixJzJeQDCzjv10RGKqa7X719ZOotDLSl6ekqaYCltG6NwAzGriXfWa9l1RP1qws2z
         4Rla+xwpv8IwxAli8og25392JFw1NZ2Zs1TVkEitFJjzgAbZvFcxAb+z1DAhD0wje/uP
         KwgiDxBYNw4KLXwALqZ3jrVgCq/2+EebH2MZt2Q2Zi0amOlOVluQkUPc9JwtY+D4AJx+
         ST/rdczl0SxFDY/T2jV1G+VYxlRIa27Ckejg2/rtUGyWKyM7j6lKrD2H6Bxiw7C8fcnE
         jkCIYZQydGyHSEK2R8Fmd9t1lJyEHe9prxHagH2XCOx0CpVgd7Myv1CiV7eGzhoYRL0f
         NEFw==
X-Gm-Message-State: AOJu0Yyiu/WSgwVWOrf6kiMcUvtV78raan8lFdijxY4UHJfFp5lLHRzc
	A+4xKMNej/QjqAYRSEXZco3XCKjUSKRQrFD7IBVuAwNEj0PJ7Dp9nWaS
X-Gm-Gg: AfdE7ckca11TwHsf32rQejxnakVME4Gxxqw4UsNCUE+doyMODp/uqdM+wYuOjvsmkfA
	oi5s92bmksw7KOcYWiaODWy2ookMVGQxUSh8f/Zt48Z3NaEFaRKa56rFuNy1jsE+mSu3Undbhkq
	OUs0qD66BUb5oLwaW7BN9Fb8RWLO+oXiQwBa10leFXYNstLiNt+viAwQEud1m2Cq65A02Ell0jD
	j7qksLB93wrxBS26fyD6qkOndwL0ZzHlhW4D3SfCErCF+bqYbqgFQAz5A3TwU4yWMObUtgWJS1g
	uj5jGVatriSE0uEH3Gma4Je3SEsK7YV93b1nbpglPADTNIJnQ4XE4McBv2cND7hSd3GBdlNT6TW
	o/NWKoWUVLJ7ObWVD47al0YO5HOQTl+PKQydFl6VLtB5rToE0U1jZJkWnbfbHIj44cxyloBCFJF
	IrSFCx5MmTDTkmaueOAXLOGqISKg==
X-Received: by 2002:a05:7300:372b:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-30ee109911cmr709652eec.0.1782767479292;
        Mon, 29 Jun 2026 14:11:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm1175147eec.15.2026.06.29.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:11:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jun 2026 14:11:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/6] hwmon: xgene: Stop writing PCC shared memory
 signature
Message-ID: <62b11d8d-353b-47ef-919b-7af6aa7488c5@roeck-us.net>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-2-c1b7268d4fdc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627-acpi_pcc_signature-v1-2-c1b7268d4fdc@kernel.org>

On Sat, Jun 27, 2026 at 05:37:30PM +0100, Sudeep Holla wrote:
> ACPI specification defines the generic PCC shared memory signature as
> the PCC base signature ORed with the subspace ID.
> 
> ACPI 6.6 added clarification that the signature is populated by the
> platform and verified by OSPM.
> 
> The PCC mailbox controller now validates the signature when the channel
> is requested. Stop rewriting the signature before each command and
> leave the platform-populated value intact.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>

Applied.

Thanks,
Guenter
