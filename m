Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DC376BC6;
	Thu, 26 Mar 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514935; cv=none; b=JLiCz1rY8011CtFiE82Eh2XgtP6TyY5M/+IylSWTabC5wYQSakGm2ijTGWVw34C3CGFjw1Uc+KplZ7x1S1NcPmB3zr84GJ7vRueoJW0AgzfV6vrVxJJdVbMXJb3TnSsJrSS3XWJA40FhOYS05Nn0jixsJpzQyHNSoFPNxxlTkc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514935; c=relaxed/simple;
	bh=Fdn/ZJCfBhR8xh4Pgmngup2rIrIPZJS1rBlOHf0y9Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0c+8T1Jf4UpeKkpemIGFcoll7CRFsINp82kQa3XP/3ue9LlmswJG9a88K0vHJVBrS5JYkN6QmMpGeWVyMu4lPGDa3pQNWrYtZ9+j+ugl1dh41nG0YoqmXjnWbzcPZE8hBpZ3GcUMvtRKT2WyqCUe6cyOrPlCMJdrK8FBShVWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKfVQCIM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKfVQCIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514934; x=1806050934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fdn/ZJCfBhR8xh4Pgmngup2rIrIPZJS1rBlOHf0y9Fw=;
  b=JKfVQCIM3YXEHxZ2D/wzyKc4/Ih1yi3wPYqUcIKiiGtbCKiaE7AoiQY2
   VZO1MsLJtLiYp7/B7nXXYCWkvuxFf8NJXiOk8UpAk5+pkv8gtF8a37DzV
   HWz9BPNHQute1RR13Lw6hv5Y7OoBlVbEDBZQGWV6Owf6FDC2E6bIEXJSo
   0OFs2e87+271hphKamugR/e+Ax/AmhfUTyQ+eHa8n3sAog99Ud1kwnk6Y
   RKuh4ISyysokQ7UtusSx+6dg631fDdWnA2bb7zCYPjQ/KTFRf3rwC5C0C
   MYqUmFGioyIDHh7Q6SHCNiA/w7LVc8PZN3MLSUw4ZTy90y2Y2r86zjPca
   w==;
X-CSE-ConnectionGUID: i78dqMy8SGWuIqM56LDYvA==
X-CSE-MsgGUID: ZYASTqI4R0qj7xdZl2bk4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74595133"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="74595133"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:48:54 -0700
X-CSE-ConnectionGUID: HM4pB0GoTbCc/PXCXrxQdA==
X-CSE-MsgGUID: jsWLlxmzQY2u2yHGmOjP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="226581061"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:48:51 -0700
Date: Thu, 26 Mar 2026 10:48:49 +0200
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
Message-ID: <acTy8Wkfs8Sx84oZ@ashevche-desk.local>
References: <acIV6xF8mY-8wd5e@google.com>
 <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com>
 <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local>
 <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
 <acTwqD8fXZSncMIS@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acTwqD8fXZSncMIS@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 10:39:09AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 26, 2026 at 09:34:01AM +0100, Bartosz Golaszewski wrote:
> > On Thu, Mar 26, 2026 at 9:27 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, Mar 24, 2026 at 8:30 PM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > Please post the reworked version so we can review all the details. My
> > > > > concern was that it relies on notifier chains to notify when devices
> > > > > get registered and unregistered, and instead of matching node names you
> > > > > now need to somehow match device instances and software node instances,
> > > > > which again likely is done based on some name. This just piles on
> > > > > complexity where a simpler solution would be sufficient.
> > > >
> > > > I will post it. Hopefully before the end of the week. I want to cover
> > > > both OF nodes with paz00 as well as ACPI with android tablets. The
> > > > latter case will have to wait for devices because there's no way to
> > > > look up an ACPI node by name that I could idenfity (correct me if I'm
> > > > wrong).
> > >
> > > What do you need from ACPI exactly? The ACPI namespace in the OS is represented
> > > by set of ACPI handles, each of which is the object pointing out to some object
> > > in it. Any object in ACPI has a unique path. At any time, after parsing the
> > > ACPI table(s) into ACPI namespace we may get a handle based on the path.
> > 
> > DT is unflattened very early into the boot sequence. Is this the case
> > for ACPI tables as well? Knowing the name of the device (HID + index,
> > eg.: "INT33FF:00"), can I check if there's a corresponding ACPI node
> > (of_find_by_path/name() in DT parlance)?
> 
> I believe so. See how we find a GPIO chip in the gpiolib-acpi-core.c.
> In the similar way you can try finding any object in ACPI namespace.
> 
> But note, ":00" is part of device instance name, it's not available
> in ACPI namespace. There we have HID, UID, et cetera, ":00" is pure
> Linux kernel thingy.

We have acpi_dev_present(), but if you read its kernel-doc, it suggests
to use acpi_get_devices() for the case of early checks (before device
are actually being instantiated).

-- 
With Best Regards,
Andy Shevchenko


