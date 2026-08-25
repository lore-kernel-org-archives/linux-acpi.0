Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272742A149;
	Tue, 25 Aug 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661149; cv=none; b=QqAivcOYYcqDxX23oJQhIO75AJwbr6HU+Q6EL7lMYJGCSCoxP1nGjY5chz4NCcrzzvFSAI5D4wHo4lniEb2UApNTMyfvHmM1pO2bzcxKg52yFoJzDCrOeCkpyN0AIi3YFeWkwM6Dhx6ohbQNLhR9jzU9IdWJIWNfS8BoSsmx9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661149; c=relaxed/simple;
	bh=yZJnwuoX8Px1kHOr+lOdamjCGgByOBfLdLWzzcBHDG8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VMkv+MyJjVNa1UU7lEUjlFavocG5E45ARiNwsJdfk5znqRDNNmJAcYII+ccBIWum4Ty79vCuuhFN5K5m8+EfXaLqw7fX6TMCLeWOZkS7Vv62ubG5yhyTVVLxdswpYOQ8hIJw1TabiWYzayjTReN3pL3BZdJPofxa720phkfBodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlXY+t/S; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlXY+t/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787661147; x=1819197147;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yZJnwuoX8Px1kHOr+lOdamjCGgByOBfLdLWzzcBHDG8=;
  b=mlXY+t/SOVN6dfXUNitApXcAIFtF7Ce049ai7KbHWCnMMDKBNV38C92w
   RE2j15bVul7CnB8ywAYulGiuFlKAP1npepNY8HDSPNniHO8kIUDYCA31g
   1lO6RvZ7UWWr+yV4yGGvUV7xnrRoBx9qsORR1kLBd69/zset4Ahs7LCRV
   5hvnYKJ18m+7CcbOzZmoLOQ3hEoOg924LVn1/DqbmnTN9UehXJBfpzKVW
   dcu5uxoRdmZGUQF1qbucp0NuXBIURV+QyoU833xQu8Ogd1KMMXok4NaDH
   HEB6z9c1dahecywyXcuqt4mHEh8+RjpyP/aS87w1W/1kApQXdI1Lqojd/
   Q==;
X-CSE-ConnectionGUID: vCmOY4+TQZ27Ydfu/PMWBw==
X-CSE-MsgGUID: BzbKtVuoQyO9T8E2e7Tf5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="113659861"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="113659861"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:32:25 -0700
X-CSE-ConnectionGUID: WX5D5PDXRT270oYzK9qVaw==
X-CSE-MsgGUID: 8G6WcAtNSq27YWUA/bnlnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="267315335"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:32:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 25 Aug 2026 15:32:18 +0300 (EEST)
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
    linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
    Daniel Scally <dan.scally@ideasonboard.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI
 objects
In-Reply-To: <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com>
Message-ID: <134e9566-7913-86d7-1e8b-b2ca9ebec55c@linux.intel.com>
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com> <20260824211338.3583976-4-sakari.ailus@linux.intel.com> <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com> <ao2FmNRFjSJVxhrL@kekkonen.localdomain>
 <CAJZ5v0gQVFxSkkjPbRf6bsKdgUBGduZV0M5SWrHoeB246ZLqew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1517076747-1787661138=:1165"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1517076747-1787661138=:1165
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 25 Aug 2026, Rafael J. Wysocki (Intel) wrote:

> On Tue, Aug 25, 2026 at 2:07=E2=80=AFPM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Tue, Aug 25, 2026 at 01:51:18PM +0200, Rafael J. Wysocki (Intel) wro=
te:
> > > On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Use DEFINE_FREE() to allow ACPI objects to be released automaticall=
y.
> > >
> > > But at least some of them are allocated by ACPICA functions like
> > > acpi_evaluate_object() and so they have no proper constructors.
> >
> > You could still assign the return buffer to a local variable. It's not
> > ideal API-wise though.
>=20
> Exactly.
>=20
> > I'm not quite sure what was the point you wanted to make but I reckon t=
his
> > wasn't an ack. :-)
>=20
> Using the _FREE with variables that are not initialized through a
> constructor is questionable, so this is generally not particularly
> clean.

The driver does call ACPI_FREE() for that pointer so clearly it's already=
=20
using something ending with "_FREE" already. So unless Rafael is=20
suggesting ACPI_FREE() should be renamed, I'm a bit lost what that=20
even means on concrete terms.

> There is no cleanup.h in ACPICA that is a more traditional C code
> base, so mixing up ACPICA code, which ACPI_FREE() is strictly
> speaking, with cleanup.h stuff is not particularly straightforward
> IMV.  I'd rather not do it.

Perhaps add the DEFINE_FREE() into int3472 driver then, it seems to be=20
what intel/pmc is already doing (I don't seem to anymore recall why it was=
=20
added there). Using cleanup.h for that variable it clearly simplifies the=
=20
code flow. It feels a bit stupid to duplicate it there but I guess we'll=20
just have to live with that if there's no place in any acpi related=20
headers for cleanup.h.

--=20
 i.

--8323328-1517076747-1787661138=:1165--
