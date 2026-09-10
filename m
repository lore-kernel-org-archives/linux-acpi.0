Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7D30FF08
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032165; cv=none; b=DXh5fA4v3+zMtwN1m5IzO6uUTh4LSwqp+4zb578+i/q0H7nKzzc83aLpc5zv1ED8k91da52eOoqAPflRe5ZQDGNaTDQMLau/qGrWhgwTM7YCbpu9sqWa1mM6n4dHj2rMifx1wU9Vt9/8uBkNRG+lET69igwaA6/wdcb0pW9wvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032165; c=relaxed/simple;
	bh=YR3UqnLLe1lsPwEIvVzghMm+1x/5ZdtNzH39Dc2YzcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScYoU/s1lgJIDQTOu2t16W2fOXcdYYprWpHs0cENpGn3fDLRTdXlTh0U7Sr0hnZL7MuuMaihLF47CJfQZWfIZ/FDiDp1xJwr6i5fRurQyMLj925m4fRQwnnzjO/yrH0esD020KJjsJcIx95O+tnhHOv7sw1yDFYvNiYj3L/uBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfQpCAKE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfQpCAKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789032161; x=1820568161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YR3UqnLLe1lsPwEIvVzghMm+1x/5ZdtNzH39Dc2YzcY=;
  b=SfQpCAKE6GhkfhKdl+xq0U92IYsBIXCHSWIQ63bNa69lwB3llDLe2l3m
   B6f3lF6dMZlAqGe22+eJcJFLryE8Vg5KFF8ZFaPzq7BveIQRIbud9vKA2
   19KnNFkJNFeznhmFzODl77rLWhCx8jc8I/LG0F+oRl2rKiuFUl7KvVlSk
   WJGuMwIj1Jfp9J6s/ZTyVo8VaOZog0GyCWIM0tH0SLoCp8IZShpn12sLA
   VM9hIj7rQQgHP49vZFF54AaimLohNHxu1neCLpIha1O/RKXlitHiFrDAN
   pCNc8FUQY4zeSJ4Rerw1q+sU05xKXXnSW3gT/9a+7jh3BVbt63PpmhZrx
   g==;
X-CSE-ConnectionGUID: qmJ6NwRJTmmSlj1P5k4qQw==
X-CSE-MsgGUID: dPW5eCHIRDq+IReyxzdoTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89689416"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89689416"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:22:40 -0700
X-CSE-ConnectionGUID: f+TLnKNxR22eMCltUD6KbQ==
X-CSE-MsgGUID: DlIcwFjOQ9WvyelE3BUZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="296529848"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:22:38 -0700
Date: Thu, 10 Sep 2026 12:22:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH] ACPI: utils: Ignore leading root scope prefix in string
 _UID match
Message-ID: <aqJ22yK9h4ZHSo__@ashevche-desk.local>
References: <20260831180214.2231161-1-mario.limonciello@amd.com>
 <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com>
 <7f86bfc7-efda-4719-a0c2-fab04fba532f@amd.com>
 <CAJZ5v0gFPcoC4nLFdjcfY5Ysk9Sw38r_rLpzWSxtVPTyTuh-0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gFPcoC4nLFdjcfY5Ysk9Sw38r_rLpzWSxtVPTyTuh-0g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 07:58:56PM +0200, Rafael J. Wysocki (Intel) wrote:
> +Andy

Thank you for Cc:ing me. And sorry for the late reply, too many emails
in the box...

> On Fri, Sep 4, 2026 at 7:32 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> > On 9/4/26 08:26, Rafael J. Wysocki (Intel) wrote:
> > > On Mon, Aug 31, 2026 at 8:02 PM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >> Firmware may express an ACPI namespace path used as a _UID with or
> > >> without the leading root scope character ('\'). For example, an AMD
> > >> IVRS IVHD ACPI HID device entry may carry a character UID of
> > >> "\_SB.MHSP" while the corresponding device's _UID evaluates to
> > >> "_SB.MHSP" (or vice versa).  This semantic difference is due to how
> > >> Windows PnP enumerates and uses devices.
> > >
> > > Can you please elaborate a bit more?
> > >
> > > I would expect _UID to return the string without the leading
> > > backslash, so where does the other one come from, exactly?
> >
> > It comes from the ACPI IVRS table.
> >
> > https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

Link is behind SSO, which Intel employee most likely can't get :-)

> > p306-307 talk about this field.
> >
> > Here is a sample entry decoded with iasl -d
> > (from BIOS on an affected system)
> >
> > [223h 0547 001h]               Subtable Type : F0 [Device Entry: ACPI
> > HID Named Device]
> > [224h 0548 002h]                   Device ID : 0068
> > [226h 0550 001h] Data Setting (decoded below) : 40
> >                                      INITPass : 0
> >                                      EIntPass : 0
> >                                       NMIPass : 0
> >                                      Reserved : 0
> >                                   System MGMT : 0
> >                                    LINT0 Pass : 1
> >                                    LINT1 Pass : 0
> > [227h 0551 008h]                    ACPI HID : "MSFT0201"
> > [22Fh 0559 008h]                    ACPI CID : 0000000000000000
> > [237h 0567 001h]                  UID Format : 02
> > [238h 0568 001h]                  UID Length : 09
> > [239h 0569 009h]                         UID : "\_SB.XHSP"

As far as I can tell this is weird (very unusual) interpretation of UID field.
Whoever created a specification should be informed about this.

> > Setting this field to _SB.XHSP does fix the issue for Linux, but this
> > has problems on Windows.  So my hope was to let \_SB.XHSP work for Linux
> > too.

> So how does Linux process this table?  Maybe the leading backslash can
> be removed in that path?
> 
> But I guess it may not help because _UID may contain a string with a
> leading backslash.
> 
> > >> acpi_str_uid_match() compared the two strings verbatim, so such
> > >> entries failed to match on the UID even though they refer to the same
> > >> object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
> > >> the exact HID+UID match to be missed and the code to fall through to
> > >> the HID-only path, spuriously raising a FW_BUG.
> > >>
> > >> Skip a single leading '\' on either string before comparing so that
> > >> paths that differ only by the root scope prefix are treated as a
> > >> match. The integer _UID path is unaffected.
> > >
> > > But this sort of assumes that the string returned by _UID will always
> > > be a namespace path, but is that the case really?
> >
> > For IVRS entries this would be true since this is what is in the spec:
> >
> >  > If defined as a character string, the ACPI UID marks the instances of
> >  > DMA-capable devices with the defined DeviceID (e.g. IOMMU visible
> >  > Routing ID). It should match the ACPI device name space strings with
> >  > unit number, but without a trailing \0 character (as the UID length
> >  > specifies the size of the string already).
> >
> > But I don't know universally it would be true.
> 
> In general, they can be free-form strings AFAICS.

Exactly, the semantic of the content is just arbitrary set of characters
that is agreed to be unique (enough).

> > I suppose one possible modification could be to look for the length of
> > the string being at least 2 on the string before incrementing the pointer.
> 
> I guess this change can be made because it will only possibly cause
> problems when the only difference between the supplied UID and the
> string returned by _UID is the leading backslash and they are not
> supposed to match, which is unlikely to happen.
> 
> However, the kerneldoc comment of acpi_str_uid_match() needs to be
> updated to mention this.

I don't see the direct question to me, I assume you want my opinion about
the implementation. Ideally the specification has to be fixed, so we do not
interpret UID as some "special" string. In a new version of the table
specifications it can be amended with a new field, for example.

If we need to solve the old behaviour, the skipping leading \ (and backslash
only) might be good enough quirk to make sure that the rest of the callers
(and possible future interpretations) won't be affected. TL;DR: Make quirk
as narrow as possible to avoid false positive triggering.

-- 
With Best Regards,
Andy Shevchenko


