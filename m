Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804610;
	b=4maFO56QdOB2fQpuzJnql1bVyZ45lrQwajmevb6sO929+aQB47JwXckiD60G/bD6Ak1O
	 jx6HcPBSbBWhCYPYx9a4jnBEM8hunt0uc2tWbjlU9YyEVClWFx2e0DnOTUjHs+1W3xjis
	 0kXe0qc2pitcLCsw8jHnjroLyWL0Dzk15AwuWiJTVP7Dx0T+cGePSLjEUu5Tu8orEJ3Rd
	 ptHi8rnwl/5KA8Pm5MWOrejPiauPI8yrbCeL7AnEp+uBS52WekfzZtf/BvLwesguaRuzC
	 TBIXfveg4c39TaomLRVgDk9GOYmo3lu6GWQl60JOVlxJu5qY7lHjmtxEircG/nWLaEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
	b=A8Z8EeODo9PJjTU8ASyLMOgb0+st4SqjGkHWWaGDAfNoecYcG2qP55myja1SEzfndfb0
	 dcos7P19onrlI+RvnG10SiW5Bz+G/Zf6SlBfJlY1oyeh0H45yJ8vicsuZe/cwZ9oQIOdX
	 OxxOIaCwXyxusAUoyAdxanhPSC3HPQQoTwjiBHXrEuvyWJpFF10RhR2k28jAoKDfUCeiQ
	 r15nqlzA/iLKq/t9FulVFRK7x1fAVf7b4JqZ5wI2I9DxVReUouwyCC5jvrh7Xc9jyjs28
	 giWltWLbyZutX9k1+QYlaHsWwzmy+dm5ixwP1C/e8c8wFyGt8Xd6J+LvWZRqLd9oZeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FQqDBy6J;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AC606A327
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 18:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710AC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FQqDBy6J
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91f0274f88cso109181786d6.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795804609; x=1796409409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
        b=FQqDBy6Js8XrvXmyD8SL/u+yExsfiOIjX+3Qv8PFjqWbEOS/J/sDfstl24lcNicd6M
         PkL4KLFLOjm+xuNYdQwqUcHAIrXcJ//DNqWVnzEugXxJV52uk6eRNVvaVxXJbY5Bl7ou
         7rubMrQs8EdQfsO5xRzjEsGHJQpkeR1g0nRGIcWUrMhQ+w2TgK1gza7wJaMgYVAeHUVG
         ges3+956+qMurZGsh19qeYrM1aQmOnZrNaBhNPYHVU0VuU1IhVr1vVlTiL1tqNFxWPhg
         YdOIvlBcF3YHxrQhupM7z96IFAXcMGRFNkKk+1lOeoAkMMQd+mWGr1YNQMt75thCP0QE
         XNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804609; x=1796409409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9Dw/wen6g6fWY32jCYKXg0uC2F+6Oaru/Dn4CTkyZM=;
        b=qRC7HV+XpA9xzIe24h4iG/K62x3vEKJGfK0H8KJ1yxCt2d0xOM6bdi+BMAB+BC+zfh
         UMwy98gfBqakmBCvIsHWp1hmPZ/So0Wsd6/6whus7xYAER1C8l3XDYxo/5CKfqtMOP6L
         VdlhLAvmP6oYD5quNfF0v5jtmUXkk1bg3utdLot452tkL+XknCuTUiZqGfOcf/Rv4vX2
         SJ8VsZ1sDKTvHyu/lLdsS6rYbXf7bxNuwMESUNNfkY0FwAMcQg/8x1U6JODcYPd+Nbqy
         DiYYQkuip8gSMchgZmhRR1y6lQWo8L8Fq7NYlxMdqa0XLCkfPbhx0wTs+TlIKSkRxvuh
         LjFA==
X-Forwarded-Encrypted: i=1; AL+hErFMB6m+S7KQaLoDzQRaWInP4A0/GU2k/S6tUrkOMRw16ERpCliSIJrQzP94z3CrcND9GqdTiIBtKKBH@vger.kernel.org
X-Gm-Message-State: APuU4Z9+1YEuxTvM/8w5/N1kueh2JvE0PrIK0A9UZiofBSP/U6GOvUBg
	ehOnmGqdDJMigbHElg0RzZijtCjUYcrDnp54HR5pxd/A0PE/5Mr8QAkk5pEDrD6XNMI=
X-Gm-Gg: AZFdTZcHOGwxKzRdSZ8eQffYY/907wnnJDvGo9eCuDjONpaYQGYaydoNtlWlJKCleoT
	3KQKKyx3GR6ZNDj9wUPmnKFKKWnbwKp8Qz1wZgoWvtFsnQm7+ji/Zi+HWx6WMx/qaAsf/nwDZ6C
	/vjS8R83wg5SWVs56RVsaxHjZs9Oe5nsYAhH2Sadh52zoOlkjFqXEXBJF/sQpazOgXTrBlQMf77
	+4zyMvxw/ZrSSWKXN4XC0h0xFYXJ4vKoIjR7aYzUs4uyPRjRcMpRB7qLsLy8DsCxj7ikbOGLyaF
	3VoZaa6QP4FNJ4rv18jZNQklVZEvkUexEWJOcdlM41wOqG71X9EJCRBPLaWzS+l2pqyUe+2QTxI
	a05WVxKKfMegd4O0wTCucHHELsn4UP5n0FGq6Z/6uGj9FyhasmIfELIScJousW58o0J24XONpl7
	4e/nAZHcFl14ISOD6zA5xLPNZzgC1sXETS51vZOXsaEt3V4ZIYCc1+SvdtJJK9YTFORN5VeiySn
	Ad4+vLubFe4mpiyr+m0Aodgsc2T/F21Z2C0MMLVhP2jloh6S9rBO1ti6SGnBTE9+JHYmup0eZNj
	VBTJC8U=
X-Received: by 2002:a05:6214:4686:b0:921:1ac1:34e2 with SMTP id 6a1803df08f44-921653a9042mr254285806d6.24.1795804609400;
        Fri, 27 Nov 2026 10:36:49 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b253csm225559716d6.15.2026.11.27.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 10:36:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xX0oS-00000007aS6-1aU4;
	Fri, 27 Nov 2026 14:36:48 -0400
Date: Fri, 27 Nov 2026 14:36:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <20261127183648.GW246011@ziepe.ca>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
 <awnLgFZIhRZENiE4@e129823.arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awnLgFZIhRZENiE4@e129823.arm.com>

On Fri, Nov 27, 2026 at 06:27:12PM +0000, Yeoreum Yun wrote:
> [...]
> > 
> > > +static enum hash_algo cca_guest_attestation_algorithms[] = {
> > > +	HASH_ALGO_SHA512,
> > > +};
> > 
> > static const
> 
> No. it's a scaling issue since the attestion algorithms could be not
> only SHA512 but also SHA256 and SHA384....

Then don't init it here and do it entirely when you query the RSI to
learn the right value

Jason
