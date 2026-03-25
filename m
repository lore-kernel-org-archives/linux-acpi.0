Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14C3E4C9B
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455904; cv=none; b=BSYtX0r+/PTcGlXNJcpYHQ0VrktRqo7S6I5BVDi3SZEhhQhfbnn0OWby9b8KIyXd1QhgPP69GJ9DMUrM0/JaWsWencwbNjOdoQBwz7dREhgPULpd0GoAaxUiPnwCBHQf7GUpwI1Jjulq3OpyXkAXJxP8chIvfKqLkOgSbFIP82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455904; c=relaxed/simple;
	bh=TvBCl61A8pRGQ3wbNXv1tUUeRTzRACn9JMKDEnQXM4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIZ0m6ZA0QUlvx2fqk6LdZOmCbFxTJ86NQk7EBBQBmUeatcX+0v4uMw7FfNW1wZwgHm3fRq9Nv/v7Z0ZyVD4hBZN+dc+qVRbnsC1YlZf86qJ5QXDc3Wx7Vm9tqTAjAEzrD9K9KlI57FINFGon2FwKCl4i0A14QlrFv2SS6AkSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyszd8Rp; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyszd8Rp"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1271257ae53so679c88.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455903; x=1775060703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8WN/loHYeE0vx80ep9YSWX3QJwZgwmdiEcu1I3Zr1o=;
        b=iyszd8Rp+stDhsmhyA9slyhO8+34lRsFNjmYxHulYKnyA/Bv370aTSvOcvgO7p/EBi
         WcXtg9ekgiPJ7XkIFzz3RCoLz4IV6CvAjsAzZwS41FB4qxUtiC0uN+lbxiJN2ojXxi0t
         hVE9VwMW9ir6akToHR+Bj/YYaWWoIcOuXIXCI26bfC0g7zsQH07uLFmEOUECOxQGzSob
         M2KlNglkUeTMRG+O90D1Q2tYxlfV5iIurmVjEZ7t9rfyZCcJrKojK27IVQd5CJvVtuc2
         q+GDJ/BDCzSP/Sqpr2yForzzUXt3fenyEMUTy9ZCQl2+dofxn0ISuzY7Ipr6C3x2tPg0
         35zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455903; x=1775060703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8WN/loHYeE0vx80ep9YSWX3QJwZgwmdiEcu1I3Zr1o=;
        b=Qujc2Z/D45FRie+yJkDdZl9/sKDD25Puh5UlEogdIv689qNiNGy7ZXMwnJjI4xc1Sh
         inZSMskMzjWOuqbm5bhG7pewGXelikcdES7M+dlajWV6nTbTnsPrnN2E3IVnRPZSFION
         KRLZyccWQ+7Bkd63MJov7zLcBGhl3Tb4BP+6KA8mgfLJrqJAjGY7EMzjyx0xEe6J7lV2
         wvQc+G5DUB99rcO0B5qNaO9kfJAjtFwjXryZGix7QAFUe/n/BYxhpiNt5SWyDoyVDbQe
         yG5j6gHAYEqDeWxqAYMMXEoDL0yolvYdo84/YAOv61BphCP4pyKz164nHNpiwFQXG5EQ
         Xg5w==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZzvtPRmGrGUGdq23rEsqNJKZd5jEgsd1z+rw7OjOL55vRcye49Ui8kzjHS+vegdTk89tEy5q3SAd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7MZ3S+TlND1e3TpBAyrNbNz+FYgZqhSTeVzBQHzRD+caFcol1
	xNTiDZ3jMP9tyneBUxqpeW8Atn0mtmlz9+BMrK/fXeMrPQm4PwxvSITj
X-Gm-Gg: ATEYQzwHL9B1PkXlXakFzosorkKATtwSfNQ1q5GqWEypc1fVDso1KcIsR8RRUeoi7iZ
	FM+7vaHqHu6ClqoujWLG0un0rNTPuSWArv5ow4PTikfEq0LfbXKTqMVpL1rqH1NKfre4W4xUXhg
	uiD8An7ClhsXkEjeLogq6gxilZ4BupJEy0s1Ftzyp4nLJk7aZPX+cIvLvuXr62B/ghywvvSkMle
	j4ozAtMSaRFndWo0/Sk90Fs/1H+m2+dEefRJh4/DN9SXaEJ/0Vsnk6PevTVcv9rbc1ed1BzVE3b
	4S2A6WfUrld8KXF7O0OYPk+FemWoTqy6GXDH0/0MBpXliEw+wZCanxMFLLcEjrlmhiZ56uLlT8J
	wKO7jO+L5c2Ig8oCMS+p23zEVYeqawOUYBrchVnTOdP1qpfWIJfv6/vUptUA3Q3upMcHirqjOT3
	eb7dxpiq1S6q44cqDOFEVlL/E4+slzI+4dLMThKc1Fa0kaJ3Oe86gMpkjiIL/i1Uw0
X-Received: by 2002:a05:7022:7a5:b0:119:e55a:9c03 with SMTP id a92af1059eb24-12a96ee755amr2084867c88.31.1774455902462;
        Wed, 25 Mar 2026 09:25:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa6e5b38csm302268c88.2.2026.03.25.09.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:25:01 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:24:57 -0700
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
Message-ID: <acQJiEAtM3LKxDBS@google.com>
References: <20260323-property-gpio-fix-v1-0-9cb46e5fe7df@gmail.com>
 <20260323-property-gpio-fix-v1-3-9cb46e5fe7df@gmail.com>
 <acKEm4EiZBqJ67nM@ashevche-desk.local>
 <acK34X9vBmvgHhLU@google.com>
 <acPMJiZHmxvVYYte@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acPMJiZHmxvVYYte@ashevche-desk.local>

On Wed, Mar 25, 2026 at 01:51:02PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 24, 2026 at 09:17:18AM -0700, Dmitry Torokhov wrote:
> > On Tue, Mar 24, 2026 at 02:33:31PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 23, 2026 at 05:39:39PM -0700, Dmitry Torokhov wrote:
> > > > When registering a software node, ensure that the property data is not
> > > > located on the stack, as it is expected to persist for the lifetime of
> > > > the node.
> 
> ...
> 
> > > > +#include <linux/sched/task_stack.h>
> > > 
> > > Looking at this name the use of it here doesn't sound right...
> > 
> > Because ... ? object_is_on_stack() is defined there.
> 
> Because it's defined there. The key word here I see is 'task' in the name of
> the header, without Ack from sched folks, I am not convinced we can use that at
> any point in the kernel.

It is fine to be used in drivers, and it is used in USB
(drivers/usb/core/hcd.c), SPI (drivers/spi/spi-mem.c) and others.

"task" is not magical, it simply refers to a process or a thread (user
or kernel). This particular macro just checks if the object is within
limits of stack area of currently executing thread.

> 
> ...
> 
> > > > +	for (prop = node->properties; prop && prop->name; prop++) {
> > > > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > > > +			pr_err("%s: property data can't be on stack\n", __func__);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	}
> > > 
> > > And again same question, why we can't simply dup them as we do for (string)
> > > arrays?
> > 
> > Because majority of users of software_node_register() deal with static
> > const properties so duping them is waste of memory.
> 
> So, then why can't we do that for the references? Just then copy and free at
> software unregistration if required.

We do not want to copy and free because that would be waste of memory in
majority of cases where software_node_register() is used.

When dealing with other kinds of properties it is pretty obvious where
the objectr itself lives, but when using PROPERTY_ENTRY_REF() and
PROPERTY_ENTYR_GPIO() it is very easy to miss (I did! and I made them)
that the reference args object is on stack as it is hidden behind a
macro.

So it is just a safeguard warning us ahead of time instead of needing to
figure out why a driver can't find GPIO even through the reference looks
right.

Thanks.

-- 
Dmitry
