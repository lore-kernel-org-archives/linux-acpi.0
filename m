Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6873D646E;
	Tue, 31 Mar 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945998; cv=none; b=MgvHLpl77uTKjy2aHmSzt6hFt5XpmDroasuA3ZacxT1/DHDnJqon0vumiXYzjAhOhDjcGpjS6lGuM/HaY3SH8F6hliMSLBFfMo2qY3DiXilo8qJSdsIW+9mOa61+WOLU8UeTfXsff1lbwYPW0cTp7HLrQ9aztFzH5bNcAeijoJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945998; c=relaxed/simple;
	bh=E3UR6Om5DylRcHLnfOgg7SK2tUH1XM8E1E8cTvOjPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4IuKej7fmgDxwLLYpHcrepOGk7xghr7jCfCloHobXpta6uHx+JigKSLT81S5wwO/VwVJfssatS9oINYVqo/zYi0CHSRJvlsSJMKSX2fbA4Frf0nh0Y6ML1eJzhMAg5AS41E3G4y8cIK4h357/m020V+OvAk5Yo/Z+e/4ukwuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksQ/T4Y+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksQ/T4Y+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774945997; x=1806481997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E3UR6Om5DylRcHLnfOgg7SK2tUH1XM8E1E8cTvOjPz4=;
  b=ksQ/T4Y+QsQrdZqVceB2XWpN60oZFWwIuWy0MFae0OpPQsYZfrALKPhs
   /QBcIpsCAihAs0j6VOFZtvgk3FuNwKuvZNt7MBjO50DsWxxJybWuuSwF+
   JvlQSrLGTWRRHfFBz66imvB24pVQgXJKa00hN+ZD3Q8cyqAwomI9BerMq
   KHOp7mMQGD7C8HaEIU3Ox2byJPedUh63chkZJWM0rb3vqAv7e9E7w4Alk
   EA+Rsb2MyDMdVGco0IuI0ftHQjhBT+QSkGIGENBOkPclTxZofgHVXYGCd
   QuZ0dDGa+QbL2MQWI/w+41/8V7K8XIKV/cQjM6ygnEvR9tJUlEabv6LWo
   g==;
X-CSE-ConnectionGUID: Vlw3U+luTR25J3Q3WFImjQ==
X-CSE-MsgGUID: HKXKtr/lQpi6gKS2fOn6mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74983533"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="74983533"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:33:17 -0700
X-CSE-ConnectionGUID: 0s9iLhXERc+ZG8BZPXQmxA==
X-CSE-MsgGUID: LON+JSdlT7SerqV9Jw/bMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="256808051"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:33:13 -0700
Date: Tue, 31 Mar 2026 11:33:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v2 3/4] software node: verify that property data is not
 on stack
Message-ID: <acuGxssSLHIYfUUw@ashevche-desk.local>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-3-3cca5ba136d8@gmail.com>
 <acpRi0BOgT73pqpE@ashevche-desk.local>
 <acrvakIBxO76OAlU@google.com>
 <act_f13eyaBPrJ-w@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <act_f13eyaBPrJ-w@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 11:02:13AM +0300, Andy Shevchenko wrote:
> On Mon, Mar 30, 2026 at 02:49:52PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 30, 2026 at 01:33:47PM +0300, Andy Shevchenko wrote:
> > > On Sun, Mar 29, 2026 at 07:27:50PM -0700, Dmitry Torokhov wrote:

...

> > > > +	for (prop = node->properties; prop && prop->name; prop++) {
> > > > +		if (!prop->is_inline && object_is_on_stack(prop->pointer)) {
> > > 
> > > I read more about this... Any code that uses vmalloc() (or potentially may
> > > switch to it from regular allocator with help of kvalloc() and similar) will
> > > fail now. While it might be no issue right now, this may become a such. So
> > > with this check in place you put a requirement that properties can only be
> > > allocated from a kernel low memory heap and not vm.
> > 
> > Can you tell me more about this? As far as I can see it will actually
> > have false negatives with CONFIG_VMAP_STACK, but should be OK not
> > trigger with vmalloced memory... But I am genuinely interested to know
> > more.
> 
> I dug into the history of this macro. It was added for the block and ide
> subsystems to make sure that there is no buffer supplied that may not be DMAed.
> As we know vmalloc():ed buffers may not be DMAed. In some commit messages
> it was explicitly mentioned that this macro fails on vmalloc():ed memory.
> 
> Note, I haven't checked the actual behaviour by trying that on the HW.

OTOH, the check itself covers only 16kB of memory range. I don't understand
how it can give true for anything outside that area...

-- 
With Best Regards,
Andy Shevchenko


