Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAB3A543F
	for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907398; cv=none; b=RSlBUh5uwyiTJ4/MXMwqUUWsvLL7M8NOYyMf42XVMTfgV+Fppz7BVDComZTcYihSLcCvieRKVHjQstBeWX1ql1bEhdljhl8R5aORpRtslbk3FE/HjRzV2SFKQ+i/AM0vZTry/gnAMpA5sToEcJh8ncqCluUfJDJhA0KeytwE3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907398; c=relaxed/simple;
	bh=l5INRuRaEyv3DR+fe9MbM7/2rrIKYN4BPu7Os7f6DQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gyl41iN+G/pbfFlaWaDCW0Ll8TvYlqeh0qVYyJB7kGfiUdT1uZ6bVeNMGyIv61lmZgLg/KMQK0UrEdZpPLS39Om8oWazbGvtFpPtgq3XepJtqEDOOW9SjU+xZN4mgRj2X++cP0xaVVQkfhbijVE+NxEv/gWA5BmeVMvBESsc7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A65NcvJb; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A65NcvJb"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c7e5f38b37so276050eec.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 Mar 2026 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774907396; x=1775512196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne+NreH4GL7rcymdn4Vd9RUHDjCDNb3QWyD6st1ksRA=;
        b=A65NcvJbD8Z6QYa0QtzdbXf7/qYRHofeVKpeOp+5aUqVatYn0/i4WFeOFdp7C3Opng
         o3O6za2fpOTkgOcVyiFo0zM8+BSTJjkC7tX+RMaPIwOlVZmDp6aY3+On6Aoi/XRo16ub
         Ql+zazcnlhWbVbbro/RPZ9kTGkLU21X9hewPrnt28He3tEOXbnBL3j2Y1Ayr6MfltFoO
         P8kVWXkZICNHO9cYyjnr+o+EdYRg7SmEVQOwAXD+WpRD2psR1F4cLMoFH3uJPCASVx6X
         mDkBt4jbda/5/y5PcWkOOiunL037e0xFx2uN8uZdOQ12ZbCUc93jF9O63mmlUGrns6GV
         39sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907396; x=1775512196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne+NreH4GL7rcymdn4Vd9RUHDjCDNb3QWyD6st1ksRA=;
        b=XajXpgYGvdXZNo6jvL+l0Bhq8mdRtbFfWkD6Y1q4nXkreZEyGBS3QOPb3xKQ4+gPZP
         vgCo0bF6BKunjXTz7b2s7ONz1xGPMgr9ZPoYMArSRb6z7JCnTOKJjoIGZK+dovasLvE4
         zTArm2blXZgiMOSXIa/BpuiXcS2YXJh4ALiPgx8yt9Fxb9oqvc+6N/RB5NHTGMptg2By
         BAjfea5TERDfY8oFmtiskw8VdELDjK+k0D7dK5Bm30iN0x1fGzlgyffS5tLieGiHXCmt
         3NJqISQhUS339tJ9ly/PDnd2DaxzNTo8+bFn4Q7s9LmGSIR0O6MeuvyRlFYZZrZlQCUe
         HPgw==
X-Forwarded-Encrypted: i=1; AJvYcCXrEoThi0ldEefFyMpfAl9Wgo9UWqyOewGiIdu65QVs4KOp832XGzwNBc1panaaSr4mqtsFZ1VVIJfE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7O7nRE37g1gy7WS26wI84pk9OEsnVtItsFS1gbS2ptfShJTD
	cTjwuiSLBTSxVyaQqVIZ9IGacmpV1UztNfrfqlgbV/87JKKrVde5nhSE
X-Gm-Gg: ATEYQzyzbfFpNw7fOGWEzvoKlwpqY0qmsn3n0dmCIaqacvpRP0FJb6dFOsnicgNoaMb
	y+cdz60nF4m+MqRm9e4kYwUbPQb9oFxazGAou2VyWcFdIY9Tpjzqtp8G4HDliK0kFdJW4hBIUHc
	LUEJBCnCcVr0Idgb86iu3vTcJCV4dB3bP2i7CUlyM/dqf5JrIsYqR+mEpCX+nKfsnJswjhXbGEx
	aUn2Xl9KcGLrYR2haAstm2HHDRP2DiD3Q7dvqS8e+w+6ZJ0UoIOKjf1bfxv4kw5Tz0P9rh/D+r+
	2Hea4rawgJVaCyp3bAPezyIvxw982UjTsOAhdnxrNMOve48HXeiDi9QKPqtd9FsdfiT6fRVh70z
	BOLPfICMfBTKoGCqYrAmm2+msE2Pc6PMpOnG8dELSm9k1YiBDUIUgbOYDYJoLltq7jCqTtkGfG5
	TnRf/FACwJNin3W8joJCosuUFO69sOhDc6RJyoQU3dyaWadXZ4dyr8m/Vf8p0WGZ69
X-Received: by 2002:a05:693c:3106:b0:2c0:d9e6:7eb3 with SMTP id 5a478bee46e88-2c185f383d7mr7769698eec.23.1774907396065;
        Mon, 30 Mar 2026 14:49:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7f4e:2749:b37a:e9d5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c747e410sm8325528eec.25.2026.03.30.14.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:49:55 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:49:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 3/4] software node: verify that property data is not
 on stack
Message-ID: <acrvakIBxO76OAlU@google.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
 <acpRi0BOgT73pqpE@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acpRi0BOgT73pqpE@ashevche-desk.local>

On Mon, Mar 30, 2026 at 01:33:47PM +0300, Andy Shevchenko wrote:
> On Sun, Mar 29, 2026 at 07:27:50PM -0700, Dmitry Torokhov wrote:
> > When registering a software node, ensure that the property data is not
> > located on the stack, as it is expected to persist for the lifetime of
> > the node.
> 
> ...
> 
> > +	for (prop = node->properties; prop && prop->name; prop++) {
> > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> 
> I read more about this... Any code that uses vmalloc() (or potentially may
> switch to it from regular allocator with help of kvalloc() and similar) will
> fail now. While it might be no issue right now, this may become a such. So
> with this check in place you put a requirement that properties can only be
> allocated from a kernel low memory heap and not vm.

Can you tell me more about this? As far as I can see it will actually
have false negatives with CONFIG_VMAP_STACK, but should be OK not
trigger with vmalloced memory... But I am genuinely interested to know
more.

Thanks.

-- 
Dmitry
