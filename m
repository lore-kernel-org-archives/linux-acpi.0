Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13317382379
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368728; cv=none; b=LRY3xeXCcINyiYBOLprVCIusdVzeId0k/74N9kMItRPfHCUHAqRYytff0h5FjlrpHSFwT1ECvgC9Xkn0wRoAdoYe0dYJbfMxcYKLf5S+UzucEXl+CoefbOMLVOzUdcXVD2+pxQZd6MBAXLEw5cQ4IXGIAMa38rwal7x75UWIdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368728; c=relaxed/simple;
	bh=NGWihRTNsEWvA+3bIr1m6OPw9i12Umx2EgNgoDF+VGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l99M3EOqKdPC4fXhHvlF09zBcNVi2gryaR4borNeeOD5BB1KD7sdy37JyvDF8LqzXrhNod/7hyKcKdNUF9/k+sTvQHJvCJtlliZi/h7OP72NX3LbxUuo7H298P0nkay36kqnzo8eU0BA+A7ogfzMKiblb4rkMg5FwNfsF7h/C8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgyUnGyA; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgyUnGyA"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2522228eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774368726; x=1774973526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzZRZ8nzRuBK7fzKOuILCAb/KGtosM6PHlSFuG6kcjU=;
        b=RgyUnGyAs5fPNJZS/inCLBaSIKOfR8K6pfsN6K+QQGTTYVz3Nj2weX3X50b0a/vvA0
         jJF34vWznSyUgkeKyHjFD51Qt1OWOzhkuyiCZWNizNR9qPVkos+eFlIv3FW+hVKwhm9W
         5Po1PVYKMBBGebR1IFg+AzLnKOA7e3wn8wQYxwVEkE7OInyQrNlzsvY97sfiD9Jb3qxs
         FnPd2dZdnSlvmtWPRnhQoN7Xo31gSXMadmIvhH7xJiVZGfCJUMqtH1Gyl9g9r5cp/2OI
         j/chCZ4TmhrhU2/Lv5SR5LHd2X1DTCclffFckHqMwzHKfnG5lxB67EqRmzWN0Yb5qMbv
         Kavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368726; x=1774973526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzZRZ8nzRuBK7fzKOuILCAb/KGtosM6PHlSFuG6kcjU=;
        b=IhXQ1rbAUd0T5w/kVzYLs9nn0DzdkLGvweEL4typSEkJAol+j7r+D1aefPg0LnSZG9
         oGSAFYsBZrEhcyaF1ZRCjLst5SZSmO12d1ZWcfrC+8Hfjn2nvIaLYiMsN8f9+Ek/P7U0
         jfZmttNOZSIvil/qvdeXp+ZVJMIVTMCZJDT41rjSuTz6sPTPWuR1/ZdUm1+sESmVpIx4
         2lLjXCZ5ulKbZeneIMb7XoRfRguLgkwwroRJk656Ha0cw0O/DC+mh+3+xWnFXeZPd7fA
         +5wEx0jPl5b+suB66u1X09WDoML/noMMqmg0Zj1EGf4Uxsk7zwGqOf4Xd/fmghyWJFHm
         vx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV10N37JtsrCarLAWNtz1hbc6ZuUCctXtjek42HWpBprbJB9HFd0JLRiI++jRCOqa1JOJXZHuynulY+@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ32/9MOg4Ynht/vV497JtPzMZpsjcfGzYrNXwY3f9xxXYCI0f
	IloAaNgjanLpHsIHoH3HIw6UiATTMnihislJBgVDSDUcQiaBCfv7xvtU
X-Gm-Gg: ATEYQzwYfRboeDK58Whfwu73MpM6sWtjiNeQjOs8c45v9WdPHVIKZBjXjX+pHiPn8qO
	a8IuXULVKbqKcvsmYiEsjd1APGaCpCKrKM34PjGsg8+7Qe9eVu/Q7acyfrdVB/ramfBn+qamIan
	G60zl/wxwB1NlOhVaxVy7kkqG/AQlx0BeYM9GTwbvyA/W0YDs9RpD4WLx/lYxy22sgTNs4SEfHL
	qtzLzI8/KBzO8Px8f0g5r5miVCHNCOwFUfmvnSBzLP4Ryih1OTVxMV83QvBWzaYALdY+6yNvZqM
	r5TNuiC8ChBZabQVaIxtc8LxW34pKfOgC2dUGOqKxKpiWvEd7qaeKRsqb5hS5OOV+/TV125DGzw
	Ftuzdrjpiepp2ov2oP/1Q5L+yoUuXKYi/8Jsl2ZQaBXgh90qG5fpMvzOgupj96nV3zR5l7kOyn8
	RfYRlaIclDgIWV8Kt3PAliT2f1kilsmvq08JcjpqCpCD5v6GHpJSgYQko+91dSHe7PSAQaG5vRD
	00=
X-Received: by 2002:a05:7300:a994:b0:2c1:59ea:1103 with SMTP id 5a478bee46e88-2c159ea1872mr567954eec.21.1774368726006;
        Tue, 24 Mar 2026 09:12:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b3253d0sm15686055eec.29.2026.03.24.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:12:05 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:12:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev
Subject: Re: [PATCH 2/4] software node: allow passing reference args to
 PROPERTY_ENTRY_REF
Message-ID: <acK2vN5ZmN4c5fD6@google.com>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
 <20260323-property-gpio-fix-v1-2-9cb46e5fe7df@gmail.com>
 <acKD_vzk_8bX17ZT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acKD_vzk_8bX17ZT@ashevche-desk.local>

On Tue, Mar 24, 2026 at 02:30:54PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2026 at 05:39:38PM -0700, Dmitry Torokhov wrote:
> > When dynamically creating software nodes and properties for subsequent
> > use with software_node_register() current implementation of
> > PROPERTY_ENTRY_REF is not suitable because it creates a temporary
> > instance of struct software_node_ref_args on stack which will later
> > disappear, and software_node_register() only does shallow copy of
> > properties.
> 
> Isn't that the problem and we should take into account how to dup the reference
> inside property core?

Sorry, I actually need to drop the end of that sentence.
software_node_register() expects the caller to maintain the lifetime and
therefore does not do any kind of copying of properties. The majority of
users define static const properties and we do not want to make an extra
copy of them.

Thanks.

-- 
Dmitry
