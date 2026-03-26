Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E03B6C07;
	Thu, 26 Mar 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515812; cv=none; b=tC+pTQc7gxvQATY/c1XVXk61LRM9oApUjTESi0pLU/iVqa/X2m1ynfh8pnB4i98eJddjqYBkDxmQBLeRAmv+v96XUU4PniaFmzhh0nwFbmLKgCXHlfqYDgg365/esN2AcTCzZo0mjds1SggIo397CMTJua9HuUNjO4uyTbdewaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515812; c=relaxed/simple;
	bh=IHrp3qcbUirCp94NsEtIYd8rf/kv8Pb6+qqpXq11Pxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snDtJn03trFYbCFC+Sy/NJ/SjDfELbzJ+LetlfC9WAcCL64fkJO+pXX4U/gBta4f0/UedfYCT8+26Kr7Ou49zCm3f/Z8UwrM0DAg62HLP+unouy4yC5LdV6AkFlKPiDMdsrq1Cmm6PWnN7niVNQsXvB6Pkrr1PolKz2x14x9zM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tt20P8/F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tt20P8/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774515812; x=1806051812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IHrp3qcbUirCp94NsEtIYd8rf/kv8Pb6+qqpXq11Pxo=;
  b=Tt20P8/F5gT0AjFloNjb31p3jKb3tPTY03WNLbKYkRMbGLSlwmtVQzQf
   S2sPImpiaLtmY1db/VWA6ZpXyXve1L0VtIjkXEu1WtxnIbn3fTBJpwpLx
   bn6V4WeJZyToHVfUAQxAH5x5Fs7HbXSqadfXUUiIYEktj6kPFAhZgrrAL
   fPdRPgaMcz9JFdXY4nBzvESxOXWtr/PSgupPhmWKiK/8pZnc4Punura4t
   3Cpw6r4AXvaYbEmh1Nz8hnVwOw+5HIVRMfJQQW6HGcBhBtE4LpZro0im6
   TzKEd2fmu+EhplTPJqTjhZXwVQm5Aubh3u3dlfpVQFsJRQsLIG0x/rVNp
   Q==;
X-CSE-ConnectionGUID: TYJhqN8YS1WvRg2A+5BkQw==
X-CSE-MsgGUID: +FtuBVQmTu28s1LtyPGneA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75530814"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75530814"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:03:31 -0700
X-CSE-ConnectionGUID: 2Q1+ycJPTDK+6k70ZCre4g==
X-CSE-MsgGUID: L6X4ANMzRaSDcTFvQ9JQeQ==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:03:28 -0700
Date: Thu, 26 Mar 2026 11:03:26 +0200
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
Message-ID: <acT2XtIKyG3smt3I@ashevche-desk.local>
References: <acIV6xF8mY-8wd5e@google.com>
 <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com>
 <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local>
 <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
 <acTwqD8fXZSncMIS@ashevche-desk.local>
 <CAMRc=McUD+M4oYOAyhU845nuSF6yve_JuaTDSNBWw3Ah3OVgrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McUD+M4oYOAyhU845nuSF6yve_JuaTDSNBWw3Ah3OVgrQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 09:47:03AM +0100, Bartosz Golaszewski wrote:
> On Thu, Mar 26, 2026 at 9:39 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Mar 26, 2026 at 09:34:01AM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Mar 26, 2026 at 9:27 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote:
> > > > > On Tue, Mar 24, 2026 at 8:30 PM Dmitry Torokhov
> > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > >
> > > > > > Please post the reworked version so we can review all the details. My
> > > > > > concern was that it relies on notifier chains to notify when devices
> > > > > > get registered and unregistered, and instead of matching node names you
> > > > > > now need to somehow match device instances and software node instances,
> > > > > > which again likely is done based on some name. This just piles on
> > > > > > complexity where a simpler solution would be sufficient.
> > > > >
> > > > > I will post it. Hopefully before the end of the week. I want to cover
> > > > > both OF nodes with paz00 as well as ACPI with android tablets. The
> > > > > latter case will have to wait for devices because there's no way to
> > > > > look up an ACPI node by name that I could idenfity (correct me if I'm
> > > > > wrong).
> > > >
> > > > What do you need from ACPI exactly? The ACPI namespace in the OS is represented
> > > > by set of ACPI handles, each of which is the object pointing out to some object
> > > > in it. Any object in ACPI has a unique path. At any time, after parsing the
> > > > ACPI table(s) into ACPI namespace we may get a handle based on the path.
> > >
> > > DT is unflattened very early into the boot sequence. Is this the case
> > > for ACPI tables as well? Knowing the name of the device (HID + index,
> > > eg.: "INT33FF:00"), can I check if there's a corresponding ACPI node
> > > (of_find_by_path/name() in DT parlance)?
> >
> > I believe so. See how we find a GPIO chip in the gpiolib-acpi-core.c.
> > In the similar way you can try finding any object in ACPI namespace.
> >
> > But note, ":00" is part of device instance name, it's not available
> > in ACPI namespace. There we have HID, UID, et cetera, ":00" is pure
> > Linux kernel thingy.
> 
> And how would the four instances of the cherryview pin controller be
> identified in ACPI? I've just created a dumy table with a single
> device, I don't know ACPI very well. Could you post an example .dsl
> here for testing?

They are identified in the driver by using HID + UID combination:

https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/pinctrl/intel/pinctrl-cherryview.c#L1757

https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/pinctrl/intel/pinctrl-cherryview.c#L273
https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/pinctrl/intel/pinctrl-cherryview.c#L367
https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/pinctrl/intel/pinctrl-cherryview.c#L412
https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/pinctrl/intel/pinctrl-cherryview.c#L412

In ASL it will be something like

	Device (GPO1) {
		Name (_HID, "INT33FF")
		Name (_UID, "1")
	}

-- 
With Best Regards,
Andy Shevchenko


