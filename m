Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7939FCA8;
	Thu, 26 Mar 2026 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551695; cv=none; b=COCA67mqZldPu/z+U0gs4SXZh6FybeOeRf8mUYJFrvU4cKL1GCsS34FXDo0bKfgTOQF8HWh0aRCulnKECnOBUxfTSSi90hYnobaE+HYkF/zZoQdXxw939sxF9w/wKtp4WGiflvhs/df4FMoisWy1OclfrFpuidQUc8pjq3xbff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551695; c=relaxed/simple;
	bh=pemYj7W8qnWMM3IVzS/AldTzqGCv3suyEAE2D6hM5OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri1ePTH6ncywjsG2HB6GdgFyB3Eio+PsIb1SLytt+3UGGE6woARkVU9kKE1j1rL1V9DRz53kjlznE7a7tV/plrywqHlqDSCye6ACvr7yocM6WMKyfpTlSZJQlozYhdcS0fH8I+VLspN1vdxR7X021jR2w/FSDmE9FHRZA2bX5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Huv9CZgi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Huv9CZgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774551694; x=1806087694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pemYj7W8qnWMM3IVzS/AldTzqGCv3suyEAE2D6hM5OQ=;
  b=Huv9CZgiKWt2aqldB6FdnyWIVUQTpkiL/UAs9I2yzQ7AFKDUFigeqjC1
   +ZMf5fZS6jSXZgK2FSGxFVx7bl3Rlnk9xv2Dn9M1XfYbnw6sRT6AXAP/Q
   xZwJ8IyaTL1caxhC3PBIMclRUa9kwg8unF1hPK6+T+0z9nudLSLXvRZf8
   2DQq+XqKOQeYPDh7D+kTlIs3d3NpR+eH6/2nTi7vnwkVpTITVB4g+BLlS
   jmtvXqAi0bpPUW3Bt0qSErdo5K675PMkQn7A/u5K4eEstXAPcS3JmTdPA
   Gjr63J9sIMbIgEuJt7ztIzjwbzDFcG/Ve5zcdwsVMuPHNw6rQ62ohhWKz
   w==;
X-CSE-ConnectionGUID: jtg1qP99RX2JDNa3Am61Hg==
X-CSE-MsgGUID: UtJRYc8bRxmp7ywHYnnoTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74652592"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74652592"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:01:30 -0700
X-CSE-ConnectionGUID: oWnWrdXhSuqxXeb2amQQsA==
X-CSE-MsgGUID: GRCYOhJMRJS4HNWoHMVpbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="229558134"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:01:27 -0700
Date: Thu, 26 Mar 2026 21:01:24 +0200
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
Message-ID: <acWChJZK-xwpuTZM@ashevche-desk.local>
References: <acIV6xF8mY-8wd5e@google.com>
 <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com>
 <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local>
 <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
 <acTwqD8fXZSncMIS@ashevche-desk.local>
 <acTy8Wkfs8Sx84oZ@ashevche-desk.local>
 <CAMRc=MdrxYRhB3MWnhTPM9FqzF-_P7Br5mRJ7kYOxQ2G3zjdow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdrxYRhB3MWnhTPM9FqzF-_P7Br5mRJ7kYOxQ2G3zjdow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 04:47:00PM +0100, Bartosz Golaszewski wrote:
> On Thu, Mar 26, 2026 at 9:48 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Mar 26, 2026 at 10:39:09AM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 26, 2026 at 09:34:01AM +0100, Bartosz Golaszewski wrote:

...

> > > I believe so. See how we find a GPIO chip in the gpiolib-acpi-core.c.
> > > In the similar way you can try finding any object in ACPI namespace.
> > >
> > > But note, ":00" is part of device instance name, it's not available
> > > in ACPI namespace. There we have HID, UID, et cetera, ":00" is pure
> > > Linux kernel thingy.
> >
> > We have acpi_dev_present(), but if you read its kernel-doc, it suggests
> > to use acpi_get_devices() for the case of early checks (before device
> > are actually being instantiated).
> 
> Ah, but I'm seeing that the firmware node handle of the acpi device is
> part of struct acpi_device and is only initialized during the scanning
> phase which happens at subsys_initcall() time?

Sounds correct. With that you can just check the device presence in the table
and maybe evaluate the status (but I'm not sure about the latter).

> When using
> acpi_get_devices() you have an abstract handle and no fwnode for which
> to assign the secondary node yet, right?

You have no fwnode concept in ACPI namespace. It's Linux thingy.
So, yes, until you have a companion device (ACPI device as object of
struct acpi_device), you have fwnode, without that device, there is
no fwnode.

> It's not like with DT where there already is an instance of struct
> device_node to which you can assign the secondary fwnode even if its
> device doesn't exist yet.

Yeah DT in this sense is available earlier because they are just
static data. ACPI needs an interpreter and hence some preparations
to be done before full access to the namespace will be available.

-- 
With Best Regards,
Andy Shevchenko


