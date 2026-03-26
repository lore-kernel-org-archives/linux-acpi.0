Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D38318BA6;
	Thu, 26 Mar 2026 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514350; cv=none; b=gCBDcuwONPdwV8OtkfLAU5X62HoZOsN3NoybaAqvrzrrkKGFmwn2lbbtONP6uPSL5LcJPZKAkThofN1Exc3AhNX3ZiF43QebKP1u46WcoamfiZSZBWAInm6YHKmb/zLCeStxzpojnwTjVxLdftPtvzwwrK0aTmZxB4n9psJMmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514350; c=relaxed/simple;
	bh=dolKZ2T2hKjiD7l8rsZt2YJGkpZN8fGE1/996ve0iIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brTuSNPfyWvxWuSMcjtFMIDl3a0qhBNAetWpJg6yKSQu73xJu4O9v4NAO5O/8jw1pAZEsA+80VX9Fn2YBhtGGV88Rbe8wjUZu42PpiyaLu9hqe6NOxJmOsd0jgBgDlEiOpHs6iIwsQbxPpcg4sBZCXGa3JSUmOsv35zuK4klT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmp+26XV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmp+26XV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514349; x=1806050349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dolKZ2T2hKjiD7l8rsZt2YJGkpZN8fGE1/996ve0iIA=;
  b=dmp+26XVE8vFI4+Tk6qlQblqdDYrEeXtfFsggS903ZEvqKB5B7zNrA7R
   RtJIhzBlPk5oDBscifJr8fEhp7zEZjF9Qoa5P8GDfEJV9ZZAw8DYoTQc3
   q8EMR8aLpu7iaRfjGx2Ssntlw1eqofMb3j7RfdfLTujnHJ7mPrCGW7PaA
   qS+8zbzhKLiWBsfAgGFRtCsIegq/gH4UcVJXAMWgQ4UfSZPn4D101ejlT
   Nxx+cDcbYFfLgU5NSta5tNoeUSLc0cA/utr2Oig85iKQ/e/U8SnzgnISQ
   qgagwVShnqkF5uDOfpI+BL44B7Cn20OdSnwiYnplPpJy3zWDS2ckz25el
   Q==;
X-CSE-ConnectionGUID: yFBZ8kYeTJSEug4WctmhOQ==
X-CSE-MsgGUID: u7J5lvezRK+3WzAVsI8Ffg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75468468"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75468468"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:39:09 -0700
X-CSE-ConnectionGUID: UWvrOqB0ShSejoTmbSN4nQ==
X-CSE-MsgGUID: 1KUGVxvaRjaA+m5bkPuzTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="229711001"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:39:06 -0700
Date: Thu, 26 Mar 2026 10:39:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: allow referencing software nodes by name
Message-ID: <acTwqD8fXZSncMIS@ashevche-desk.local>
References: <acIV6xF8mY-8wd5e@google.com>
 <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com>
 <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local>
 <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 09:34:01AM +0100, Bartosz Golaszewski wrote:
> On Thu, Mar 26, 2026 at 9:27 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Mar 24, 2026 at 8:30 PM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > Please post the reworked version so we can review all the details. My
> > > > concern was that it relies on notifier chains to notify when devices
> > > > get registered and unregistered, and instead of matching node names you
> > > > now need to somehow match device instances and software node instances,
> > > > which again likely is done based on some name. This just piles on
> > > > complexity where a simpler solution would be sufficient.
> > >
> > > I will post it. Hopefully before the end of the week. I want to cover
> > > both OF nodes with paz00 as well as ACPI with android tablets. The
> > > latter case will have to wait for devices because there's no way to
> > > look up an ACPI node by name that I could idenfity (correct me if I'm
> > > wrong).
> >
> > What do you need from ACPI exactly? The ACPI namespace in the OS is represented
> > by set of ACPI handles, each of which is the object pointing out to some object
> > in it. Any object in ACPI has a unique path. At any time, after parsing the
> > ACPI table(s) into ACPI namespace we may get a handle based on the path.
> 
> DT is unflattened very early into the boot sequence. Is this the case
> for ACPI tables as well? Knowing the name of the device (HID + index,
> eg.: "INT33FF:00"), can I check if there's a corresponding ACPI node
> (of_find_by_path/name() in DT parlance)?

I believe so. See how we find a GPIO chip in the gpiolib-acpi-core.c.
In the similar way you can try finding any object in ACPI namespace.

But note, ":00" is part of device instance name, it's not available
in ACPI namespace. There we have HID, UID, et cetera, ":00" is pure
Linux kernel thingy.

-- 
With Best Regards,
Andy Shevchenko


