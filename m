Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE0247DE1
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2026 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775359685; cv=none; b=PxzZxSavHM+re17ineqdibxGASWRQ4GhhRfIbTcoBwvjxTzRa+j39alHQJ3fNSGsyGFYMo0s53jKNbV0A2vFnpWWf85si7mU3o9/JdrUNQvEFX4Qlc95NvRcVgHoGkt3f5Wz/x6V5++2k7qtaOrOr+NIr24O6IgPHKoxIB0keo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775359685; c=relaxed/simple;
	bh=RHuAfpAtDI8q2ZAJvwlfLapMc7KWUO9JrIAFMlF/IOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFH7mh1Br/3HB+tWvc2hr/dC/4hZ4QltAOmWMj0gGrqjtIIxSWjAeudJtV+gwnbr2xL61M295o3FAAL43Kd5LKIZ1JaLY+5Fpwr1MBn13Yq14zOKtsk3bzAPBpODvwUn4MmUWB7cZsDjXWGgEsz6FYfMVKiT3x7/yJMg+txFUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5K0Z9KT; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5K0Z9KT"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2cc4c693d59so4324566eec.1
        for <linux-acpi@vger.kernel.org>; Sat, 04 Apr 2026 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775359683; x=1775964483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqQ0dY5T6aoukbdxTtADqJiwNgfD3DdHEcXDDm50GnE=;
        b=d5K0Z9KTPKk/9Ww8SpQbuioP6upOfn6ncGYgzrQ+QmVL3nd6/hA6qvT87X+AW5JFtz
         RNnhL7XiR8xKaePWS22qrRGaLOCy/WAXYtzo2bSBlERwT9Oh9oftLAg9Z/VjfVlJ3jh4
         0cX5CzypM/36/6DKU12lUlZgzt1BGfs6rvhuY4+U9RAb7c3/qWqoOE1fxBzlWKeoYfr+
         h/zJCHfMcYsBT80VonCJ/i9AeImISCNjglXyPS+Xoj7/pXNfUxL35jm5YMXy6o5VqqZN
         CBk3OtjaovYUV2+gpj6VQ/RSfOlI9l6E5f2kcKg4Kluw7jeiW9irmteWFS2EEfzGFMbQ
         NUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775359683; x=1775964483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqQ0dY5T6aoukbdxTtADqJiwNgfD3DdHEcXDDm50GnE=;
        b=aPYAM+IoKk4WduoLmmTDmhQlgF3HQzJlMAPZDTpTVV5NI30IOk1XVp22mHRUZ4an+o
         okhF8Wnjqcl272iiyDTLqBtlKj4zNFJwomKb/y36KUDSWsLCJdRUAu4KOxWM5S/WZHe5
         73ZAquVshnyAFm4GlP68j9aruMdqKjTBDhpiXzgWpCd5hIYN93dzrdEYu15ITS9vh9ub
         G24ogGM5h8IJREUDg3gVQ/apodp+LNLhc+WJ0gEpHMm1b32LuQ2glxWimeWPD5jDLV54
         7tzXTu5U52w5NUPbMhHiSIyG83Cm8N1M1m6b08DCpBBAKXo7PxqYOZ03O0B6E3pEkbk5
         whtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhyStmVbwdA/oXC1ndxmxaqZys+9ss+yQVS5edfExZUBDd1js4OCBz0TdTUJ6STamV8e4CrNv7YRow@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bO6T6vB0gvPgKHVch/bHkQlrPR+4NL02g3mlhYyCxqUf46H+
	sA96c8EZjGu99ayyMBKLFGnesNGU52wr8K5Bd3FdG0/QSkwFJrzLyR5d
X-Gm-Gg: AeBDies9NyaShgxtfpE+bPcI2p72TFhrTHBrhDOgQ4Dv5HcOUkHdyzR3K5ZU5Ic4IBv
	XFIJWzPi0pSi1SaQsH1nXQsZ15qVzs7kKqSFfFSmvMLkYl16Ef6up4aoroOkbuhZ0zojBg75tOm
	XRh53W6ewQUXbUzva5R65fx1WbBLk5UL52gBbxF1PtpDERHIdkksfGqiXe4rEUInJUygdUbN/wr
	K0q6RnEwhqpwS6ps8uWyk3YBQMLBbRfCshG+cUN7TVhuQcIUGRk7FOIIi7FEnpUeSolI/bT135S
	iFsdf130DpvKQhvx6SvSYhz4Hez/RmoQgPYyaxtE7hMB8CM/9WaH0pRt7IDlLUTr3Cf8InZs6io
	zQWOdH065s/biw6T+b7KZk5KW1CqKHoP9l2GyRurp/ZhDnTHx1oTQL6j+0ibXa399N+6FH2JJZq
	4faZ477WelDXXBT90CTCzRir0w7F3rrpmI3uKFXhgRQXRv8kAGYoS6CDAEfq8ZVXiY
X-Received: by 2002:a05:7301:1688:b0:2c6:cdb3:bd5e with SMTP id 5a478bee46e88-2cbfc365473mr4057705eec.28.1775359682847;
        Sat, 04 Apr 2026 20:28:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d488:726d:822f:a13a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c151sm10108101eec.19.2026.04.04.20.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 20:28:01 -0700 (PDT)
Date: Sat, 4 Apr 2026 20:27:58 -0700
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
Message-ID: <adHHVPN1O632XFf3@google.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
 <acpRi0BOgT73pqpE@ashevche-desk.local>
 <acrvakIBxO76OAlU@google.com>
 <act_f13eyaBPrJ-w@ashevche-desk.local>
 <acuGxssSLHIYfUUw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acuGxssSLHIYfUUw@ashevche-desk.local>

On Tue, Mar 31, 2026 at 11:33:10AM +0300, Andy Shevchenko wrote:
> On Tue, Mar 31, 2026 at 11:02:13AM +0300, Andy Shevchenko wrote:
> > On Mon, Mar 30, 2026 at 02:49:52PM -0700, Dmitry Torokhov wrote:
> > > On Mon, Mar 30, 2026 at 01:33:47PM +0300, Andy Shevchenko wrote:
> > > > On Sun, Mar 29, 2026 at 07:27:50PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > > +	for (prop = node->properties; prop && prop->name; prop++) {
> > > > > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > > > 
> > > > I read more about this... Any code that uses vmalloc() (or potentially may
> > > > switch to it from regular allocator with help of kvalloc() and similar) will
> > > > fail now. While it might be no issue right now, this may become a such. So
> > > > with this check in place you put a requirement that properties can only be
> > > > allocated from a kernel low memory heap and not vm.
> > > 
> > > Can you tell me more about this? As far as I can see it will actually
> > > have false negatives with CONFIG_VMAP_STACK, but should be OK not
> > > trigger with vmalloced memory... But I am genuinely interested to know
> > > more.
> > 
> > I dug into the history of this macro. It was added for the block and ide
> > subsystems to make sure that there is no buffer supplied that may not be DMAed.
> > As we know vmalloc():ed buffers may not be DMAed. In some commit messages
> > it was explicitly mentioned that this macro fails on vmalloc():ed memory.
> > 
> > Note, I haven't checked the actual behaviour by trying that on the HW.
> 
> OTOH, the check itself covers only 16kB of memory range. I don't understand
> how it can give true for anything outside that area...
> 

You probably mean b4a0f533e597 ("dma-api: Teach the "DMA-from-stack"
check about vmapped stacks") but it says that for vmapped stacks
object_is_on_stack() will produce false negative (which is tolerable
here).

I am not sure why object_is_on_stack() was not extended to also handle
this. From the cursory glance it looks like a lot of callsites do not
detect vmapped stacks... Let's add Andy Lutomirski...

Thanks.


-- 
Dmitry
