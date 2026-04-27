Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A4C29ACC5
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277768; cv=none; b=OwJYjAfOCWL2A86hspfYXpxst15g+ey8sDfHj+rLvWHNryNV59wqKTelsMi3oE/JBIPcFKuINrSlq7HuJR7g7Wj9EP3JXejHuBSEZF2beBgUz1ZyMpYiPF3PmLSr9FPZT6XXRB3NiWYTR1W7Q72FcF+SN0lHVuebouwZB9tepsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277768; c=relaxed/simple;
	bh=6D6WI9h/HgOWdKUs0QWHirK2fOBqO/lvTMizpPavzhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m06Tt+6A0L/9azDmPpeT47D7EcLH+MoLx7gZFu8Beob/RzM5shDIL3PmikqCWVq4n6r8f4Nfvq5i1eM2GD0C8rWL7jCWtdXfn0BD91mXMu7Wt9mhsJYk3i3rB8s1l2lPg4LyF47W7x1DVgJA7omR5xyBTnqddJ9A6SPX7IJhqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ+LjWUr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ+LjWUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26FBC2BCC6
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 08:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777277767;
	bh=6D6WI9h/HgOWdKUs0QWHirK2fOBqO/lvTMizpPavzhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dQ+LjWUrX7xm7J8IbCZ6g/BQHaYW+cWL5fMDLYpv9j2JE42awoxGMAHGleaOmK5er
	 /l5UKVvDp9j/VRN6kKsqJXE2xQdV2IGQs/hNQBgK+L2vbIX6jGDFhkb421y1WZwLkD
	 RxBKvR0w1Z4Rz2S/tnrjefvl+zZrzLxmEn0Pm7LjAAJo2SwiktzOcvCP1POKywrDul
	 p4r1S+qMTKhNGQVFjidFBkRKzJI8u/gk+G8pVZwaGFZmfJm6o60SDuqBcwDz95DAJD
	 KHftPDHuVrylsteQodhIK4/QvDDobo67FKvkQJFRq5brQHQzNdmvnKkMPVerlZj0eR
	 xFXz8KM+/twQQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso654570e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 01:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9GQiiHnbx1T38e8BhPkyWVw9I5LlTF9bhi1UAzdCruTbIy1gM6KIYriB616UI4i2KFaWV3calIS3en@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1V9G2uJzKX69RB+G2BYvOuouHO5aUMBTVb4hDFELLvfw52gca
	33aVLUlmVqflIPq5mrAW1XGPZiAneIyfzoccM0GAG690FJr6nia4a4K5aT1bS/y2rjvQDSjRckf
	69o4gvpeQmPp0RL+8X1VpROsmkwLamLXOTgcRDkhMpA==
X-Received: by 2002:a05:6512:159f:b0:5a3:f0f7:7da1 with SMTP id
 2adb3069b0e04-5a4172cd17amr15273699e87.17.1777277766544; Mon, 27 Apr 2026
 01:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424124250.92890-1-bartosz.golaszewski@oss.qualcomm.com>
 <aetxEcjE8wD4-ZyV@ashevche-desk.local> <CAMRc=Mem3m8JZXafL9xrUvWZWuFaCofkNEdVYLNMgC+3N0i21g@mail.gmail.com>
 <aeuNEYymSicUcMyZ@ashevche-desk.local>
In-Reply-To: <aeuNEYymSicUcMyZ@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 27 Apr 2026 10:15:54 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mc-Tk7fqZT=JinL8+01YdTGJq-LciZgnnGkaNEXa8Db_Q@mail.gmail.com>
X-Gm-Features: AVHnY4I6orj-67xKvyAVoxUvX0YJCp_u041CAHSIKuRD6hL_Ikhw7dI4X2Dj1oY
Message-ID: <CAMRc=Mc-Tk7fqZT=JinL8+01YdTGJq-LciZgnnGkaNEXa8Db_Q@mail.gmail.com>
Subject: Re: [PATCH] software node: provide wrappers around kobject_get/put()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 5:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> should also work. And here I referred to the fact that we already have a =
kobject
> instance available. Yes, my counter example is just to reveal inconsisten=
cy,
> I kinda agree that using swnode specific API might be clearer approach.
>

Let's do kobject_name() -> swnode_name() separately?

Bart
