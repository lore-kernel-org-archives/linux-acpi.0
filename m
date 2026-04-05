Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5F2D8DC3
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2026 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775359778; cv=none; b=NvLjc8dQ3DbODX65o5AKvwXIS1vdVzEcjH/L4/lDnf9Vg5WIPNyYUP3/VswHobmM+u7PGUg2OqvNf66J/ySoluOZPlUr7CiDZP+eegNC2Tnd/U/dHmuyaeRbFNhq2Yxs8dCj/x6uCq+NNMGb/ql/lVShMIOZskp9aLrsMmdLCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775359778; c=relaxed/simple;
	bh=X7d+KpQXR94kjEG5ZOzpx7nxRpIeuQhNidtplBVQ2dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV4HALg+PZg/iRfNXpN9i6kLTQK3f2SybvmZdlpg+8D39VAfJmw8ZZ2znjCbWfQwk3FUmPvzU1x8WX9gbQEjQs+i4LBfApe/pMSADEkvEdeBazvbTmFrm0nFolH/3rlLp8UOnFQCATrfP2e593DiVHTw8yuWTVUSuLletXt9D4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af2lJ4Wk; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af2lJ4Wk"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4543637eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 04 Apr 2026 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775359776; x=1775964576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPCZXW9hwwHLBnWUfhgTcLuDcn9cCDpsUAoc22QLIO4=;
        b=Af2lJ4WkWIJ5fNGnpD8M6NHjQOyk5dPj4sUhEi7Pli11ureBOzfGYG6uiwaQgssIYA
         UpWh/ldyRMUnn0/bV+akdCxBIIBDwCiGPWQsunaDwdI9LFYViam6yDXYaUBMqKK+8Htt
         r067cxS8Eci6Bj5Y/6BS5b2RcpzFHJC1qhA4jc/VK5YbT9vXZtA8OFlrL4auSaNmZKMG
         F87JQ/v9lADrLgZZXWTUGu2B/sudwy/2fr8vMqRTTj/P+c128dBsgEqYRWRDQDKbjSHD
         dbgKlDA66juUGrFLqCQnj5CFJVuML/jgiB1zkvGUo92lzLzKqxLhit5OIWCDsZxaKZAb
         c5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775359776; x=1775964576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPCZXW9hwwHLBnWUfhgTcLuDcn9cCDpsUAoc22QLIO4=;
        b=hmJl53Agy64V8VJLiTe3hR4cuAsst9rs92SP2PTvnmCkZCPKyscZ9Hq+MzGK4BzQii
         7TwWhqH/UIsODgmCfP0yKmefSd0vjHKw1YgrTKFRk+xziDX/S8ecpq6WyH4W4rwmt/PB
         J011c6pRirHi3L5Vmm1BIO/Qhr99Eoo71TjUYlMtS7eNqVJChxRaCB/HmBeWpzaKBT7H
         o9XEkWIUSBFx6doUro/NSC58VmtxOld6Dvv8m5qoFLzevKu+Ax1LQPEZIBZbGDjwko+u
         T5Y+cpGRdmmo7SVCssSi2Y8WFy7IcJ5WynK3oxoaeQgQ5uGxEiK1YetC04BWoJZkMboM
         Hhcw==
X-Forwarded-Encrypted: i=1; AJvYcCX9A6exznHHcfZrzSShj4pczAdDCw2aWX0u8sRP+5rVrgqUsC+XhR1YG+3j1OZNCxwpngpXGnPRD39E@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaBichNV5tLGjrEOXqUkcYjdW9cWGk7V/T1ok9qxSUpqO/mPo
	zJdQPS19PXaxhRFrJL97+vay5JxghIQxP1qxVEvDHlusaC4y/4KZiwIx
X-Gm-Gg: AeBDiev/vpd9rbK6YjbvgpZw993rEE3y6Xt5Q+vSXkxjr1SBAkHj1xyj/lVr4b0Oj76
	Z5dnhY0Lo4qOWlO8SfFjcGjwU3/aJE6xZRaug76rkmS9A8QqLpPCNwXLJKg9XQgG0wI6udPV+yw
	k5BP0J6GUZcbvYWd7iQ7TT0BMzEFOwb4JI1iPZrxUei8DZ0J9F9L7fGLyei2ScoYZSqr2MSrWfZ
	k2aLAjuhxqqsR5wMfr3SlV5gWnytga+ihOXmxcqEJrYckwkXMQuYonhRvsWMWy8sDpJWNigRd5H
	Yzu+dLIZZhI2Upg+vlktOBY3+nlKz1cGNxZCLc1THrgAy7TuZS+DbEoX/VJ0kKWwqqSoRzOW051
	U21FITNS78X2guNlsv25UMIgJ/AB1AkS3gjXWvLZLFgeJ9+EKjfDiodi2HZRWlw2LOZ4Xolo5pI
	fuhEvciXn1c5aNxTjApcSrGYdMCD0PF8JVxUOHsw3AXa14nPPLA9y/aqRFcEF/lDlr
X-Received: by 2002:a05:7301:19a8:b0:2c7:5a7b:e8c0 with SMTP id 5a478bee46e88-2cbfa5c38bdmr3807934eec.12.1775359776462;
        Sat, 04 Apr 2026 20:29:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d488:726d:822f:a13a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c0c2sm9812953eec.17.2026.04.04.20.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 20:29:35 -0700 (PDT)
Date: Sat, 4 Apr 2026 20:29:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 3/4] software node: verify that property data is not
 on stack
Message-ID: <adHW3Oou-fHnvRWm@google.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
 <acpRi0BOgT73pqpE@ashevche-desk.local>
 <acrvakIBxO76OAlU@google.com>
 <act_f13eyaBPrJ-w@ashevche-desk.local>
 <acuGxssSLHIYfUUw@ashevche-desk.local>
 <adHHVPN1O632XFf3@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adHHVPN1O632XFf3@google.com>

On Sat, Apr 04, 2026 at 08:27:58PM -0700, Dmitry Torokhov wrote:
> On Tue, Mar 31, 2026 at 11:33:10AM +0300, Andy Shevchenko wrote:
> > On Tue, Mar 31, 2026 at 11:02:13AM +0300, Andy Shevchenko wrote:
> > > On Mon, Mar 30, 2026 at 02:49:52PM -0700, Dmitry Torokhov wrote:
> > > > On Mon, Mar 30, 2026 at 01:33:47PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, Mar 29, 2026 at 07:27:50PM -0700, Dmitry Torokhov wrote:
> > 
> > ...
> > 
> > > > > > +	for (prop = node->properties; prop && prop->name; prop++) {
> > > > > > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > > > > 
> > > > > I read more about this... Any code that uses vmalloc() (or potentially may
> > > > > switch to it from regular allocator with help of kvalloc() and similar) will
> > > > > fail now. While it might be no issue right now, this may become a such. So
> > > > > with this check in place you put a requirement that properties can only be
> > > > > allocated from a kernel low memory heap and not vm.
> > > > 
> > > > Can you tell me more about this? As far as I can see it will actually
> > > > have false negatives with CONFIG_VMAP_STACK, but should be OK not
> > > > trigger with vmalloced memory... But I am genuinely interested to know
> > > > more.
> > > 
> > > I dug into the history of this macro. It was added for the block and ide
> > > subsystems to make sure that there is no buffer supplied that may not be DMAed.
> > > As we know vmalloc():ed buffers may not be DMAed. In some commit messages
> > > it was explicitly mentioned that this macro fails on vmalloc():ed memory.
> > > 
> > > Note, I haven't checked the actual behaviour by trying that on the HW.
> > 
> > OTOH, the check itself covers only 16kB of memory range. I don't understand
> > how it can give true for anything outside that area...
> > 
> 
> You probably mean b4a0f533e597 ("dma-api: Teach the "DMA-from-stack"
> check about vmapped stacks") but it says that for vmapped stacks
> object_is_on_stack() will produce false negative (which is tolerable
> here).
> 
> I am not sure why object_is_on_stack() was not extended to also handle
> this. From the cursory glance it looks like a lot of callsites do not
> detect vmapped stacks... Let's add Andy Lutomirski...

Grr... now for real...

-- 
Dmitry
