Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53130EF89;
	Tue,  2 Jun 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394659; cv=none; b=QaHTtpY/2LZzFuaF2ASQRnVdvX1qGwwRPpY0e8QQVxzc5Em7I1Gcp8+CxGeePnLMd5PWtHzGnfdzvLeNG8xp5S28BL6TjXVDnnAY37b3Nw2qrRQpv0F+48NF6QRhkCy35VR/R1r9mMfnjvXoezg157TS0Dl+THydYIX5SCIFaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394659; c=relaxed/simple;
	bh=YdPwtikXRDaKpAOURi931IMQBXVu9ZmCKgykjG/ASVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7IUYsZQtEheYzJONf+o/6gNcKkeQKi0Bd1fQKykL/ZA3hhl2sMjvUqoo9iiRc/Ajzn+z7fyKQl5LA0hrNQXM4mnCFVFpdvL8v7Kr9zUgoGPrA36xJB9KLy/fIy7D8nyIa5WWhZ0LIuK7CDM5fnKd5oDMlvqwlvlXh86YgkY3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhRZ+sFo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhRZ+sFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780394658; x=1811930658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YdPwtikXRDaKpAOURi931IMQBXVu9ZmCKgykjG/ASVA=;
  b=RhRZ+sFogQAhBasN5PvZxVe+Lirc0L3e4+Q3LykQx4JdhtdgCsUdGxIb
   /Bby7jQwNQvNlENkKHbFHAOB98bN39u8p7MbhRy5cgp3l1fKbZEl1mv/6
   h9PrpveFQBD9bwVNau4RVA7U1HP/tp7LwIGy9MFFN55V215E5EXTJjJ8G
   qgULHzvR3tHNoXrjpUFW/OvwXJlMnya+3Sa5AqpeoXf2Jx3Y/OHYqitZY
   3qHBPUp9/uIQ0kNDK66nuT/IuL6uP4y1fDxXb1CjFTIp5rEuITaV2jTmb
   kYDMaXSNiZa53E+AZh52LqGy+6UwAgy2U3fg8o4bkiatRzh7blND2RrPe
   w==;
X-CSE-ConnectionGUID: Pv2dGPB9RLqskjoz6Oo+Vg==
X-CSE-MsgGUID: F5FNRG7fSG2XhvGtRrSL7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91860368"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91860368"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:04:17 -0700
X-CSE-ConnectionGUID: w/1ggkKISzKwlP6E1Ef5Wg==
X-CSE-MsgGUID: dTroBSPuTpK9ONqmP5wXuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267510766"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:04:15 -0700
Date: Tue, 2 Jun 2026 13:04:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Marco Scardovi <scardracs@disroot.org>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Marco Scardovi (scardracs)" <mscardovi95@gmail.com>
Subject: Re: [PATCH v4 2/4] gpiolib: acpi: fix resource leak in OpRegion
Message-ID: <ah6qnf9ij6Fu967D@ashevche-desk.local>
References: <20260531120816.17255-1-scardracs@disroot.org>
 <20260531120816.17255-3-scardracs@disroot.org>
 <20260601121815.GS3102@black.igk.intel.com>
 <ah6M_vEIREG0w_mV@ashevche-desk.local>
 <20260602095346.GA2990@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602095346.GA2990@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 11:53:46AM +0200, Mika Westerberg wrote:
> On Tue, Jun 02, 2026 at 10:57:50AM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 01, 2026 at 02:18:15PM +0200, Mika Westerberg wrote:
> > > On Sun, May 31, 2026 at 02:03:09PM +0200, Marco Scardovi wrote:

...

> > > This is really complex solution to a problem I'm not sure that even exists.
> > 
> > The problem that potentially may have an attack vector is the malicious ACPI tables
> > (via SSDT overlay, for example). So some of the validations (like pin index in the
> > pin list) would be somewhat useful.
> 
> Yes but with SSDT overlay you can do much worse things than passing an
> invalid pin index.

Still my point is valid :-)

-- 
With Best Regards,
Andy Shevchenko


