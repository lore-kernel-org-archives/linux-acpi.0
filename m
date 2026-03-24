Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6183A0E81
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369044; cv=none; b=NHfFVxk5MbOJ/lAUP4ccNDb1yO8mtvYl75UnUIw8GROglSJemQuvzDRyHpe71LKGBhGFYTEiaUk7Inv2j5/Fp6jZol6ToUA2grOpyXnS1rGTI+u8sR1cSA5czlNXcIlLMbnBcKEAZivnJEb57tYSn6NJax7q+he+8pkKvhh3hAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369044; c=relaxed/simple;
	bh=sRax9/w4iq++WdyC81daMYS46o9HtAGnGATYpcTvhOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrADMzdRxgNvI3W/gvyVOk192wWF3bYXzayVR1pdc504LhCAWVlBDHQ8IW3wSQjNpehqiH4ooLSmK44voAjO3urC7EhBYuV9JUIK+JOgTjcZI2I3AllyxEZSCR0lAstZtYkftC9XVvX9DqPRv2ilimKkJupx7CeVrzspe4zlu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oms1RKjo; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oms1RKjo"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12a71ade78cso1876939c88.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774369042; x=1774973842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsYMF3uBNfq2eE0m/55s8BW6rwAAzjLFvcLVF8SzoTo=;
        b=oms1RKjosbbEyzo4Rg1bLBnfqqJhzC22StQgkTkPQIzdvDUwlXR9lG5XEAeCNFNFZf
         fJnkJ1HZQAapRtEQiq9f+8j2efjpx9WkJjf/oPsYULjaF3ARWdBBAYyHIIUb+wWlxZc1
         odXu4YVNrsGz64sdI4DXP6q2vH4tPomkRNT7Qpv8QGkVEoeoWRaYmmRfDHHE2yDDYYh0
         To0TxxV4dKGf9x5HiWdBNwBGTJZ57uzCiZOoCg70d8V/raTXoqXgRduPGA6jV03gTdPk
         tez3d5u4kykKaif8ADj7yuT4PNo4nYwJDUZWu8jlXyGd44tNvoj7XsHkiranDBH2hmRS
         Ua+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369042; x=1774973842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsYMF3uBNfq2eE0m/55s8BW6rwAAzjLFvcLVF8SzoTo=;
        b=qXxpLcC1woZamXD+qIeOoLnrJu5dXRGtLYIulYgRr9jSMD9B2dP/VdIm4h6OGz6+/e
         Nrn5cXkaykAetQ+3O/wVef+oasA2fQBlR7zTvowOaUSiCa6LVJCeo4k2kZ5Szb7weBCw
         02R3aJogk7kW5lDUwJB79KRRgZimHCg5L9O4Qm6k979ReTcAMOAYNJtJQGpMFZvOy0mL
         3zj00lHtTfT644Fhw965x4dsl6T6iIoZw+ZFkgCHbwHaPPfst4hWeITLchaQ5Rxc+0X8
         DN6FjL6xDK5YhKI8HgacH2D5ZkAUlyaMFSJaS9vrzu9Nqgo33DZwyK8ITTmGwgyw305O
         pwkA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPvgrjyqwj0UPXqp+OOPZXOS53Ie+UJFae2fiHfYspih8si5Qd9cefNymJW99Fr/zMK8/SbN8AZZV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7h3HaeJ1O3Wfu3tSoe+aFMg15Tw9jHB2Ji2PEOCLpGTPTwouW
	UMLW8dfJzzCh3F/hy3+cf9dOTyJDlNg2upaBjGdYk5PVhLdaJcNGr/pZ
X-Gm-Gg: ATEYQzzjuvj+IPtVpEJ1BfG3S/vZjSsr9KzUtE1kbhTqcUsVArsmY7G3XbdvLATxMgc
	K9Vchise9ABrrvkInyRVePoVFvcq4PrYs9U3A13TuqLhXYHBmW8WAfJZQkGFcnDV23gMfmtJkOH
	EdveB1roEhZcTuPKKFKIWJIhvFWEfnb6SUGyLHYQpCHCMsXuxAsuYaInHzSa9vK5mM5EihyzXUq
	iijqADHvkfbvfGEei1ctO5FzSZqmN7IeuT7LpG+SMTrDS1ubbxGCkGm1Y8K4d/GljW3va/B4lHI
	k3SmmoVKwduLTYftjovHQxfBFMGUzXGgbuibgl3+fthx2pbK83twK/pJ0Fye91N8GUzyjvcT/oB
	8yCVd0dfir0GAnItLVQIbEkQyrNytlo+V+C6jEKj+uKKb9R7cpJtnjvlVlHMeY+TwmGAEieA3yO
	wCtTT4NXlq/ammYmvYPqvDxflJ9Oswukx+DuAl4y9gvPHMhO9rkgKRyledVAw2KDmx
X-Received: by 2002:a05:7022:45a4:b0:128:d4db:447b with SMTP id a92af1059eb24-12a96efc733mr50667c88.38.1774369041982;
        Tue, 24 Mar 2026 09:17:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733e794esm11620232c88.6.2026.03.24.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:17:21 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:17:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev
Subject: Re: [PATCH 3/4] software node: verify that property data is not on
 stack
Message-ID: <acK34X9vBmvgHhLU@google.com>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
 <20260323-property-gpio-fix-v1-3-9cb46e5fe7df@gmail.com>
 <acKEm4EiZBqJ67nM@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acKEm4EiZBqJ67nM@ashevche-desk.local>

On Tue, Mar 24, 2026 at 02:33:31PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2026 at 05:39:39PM -0700, Dmitry Torokhov wrote:
> > When registering a software node, ensure that the property data is not
> > located on the stack, as it is expected to persist for the lifetime of
> > the node.
> 
> ...
> 
> > +#include <linux/sched/task_stack.h>
> 
> Looking at this name the use of it here doesn't sound right...

Because ... ? object_is_on_stack() is defined there.

> 
> ...
> 
> > +	for (prop = node->properties; prop && prop->name; prop++) {
> > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > +			pr_err("%s: property data can't be on stack\n", __func__);
> > +			return -EINVAL;
> > +		}
> > +	}
> 
> And again same question, why we can't simply dup them as we do for (string)
> arrays?

Because majority of users of software_node_register() deal with static
const properties so duping them is waste of memory.

Thanks.

-- 
Dmitry
