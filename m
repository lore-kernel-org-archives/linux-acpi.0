Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDABC14A
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2026 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429366; cv=none; b=Z/039eSQDUOAjgY0mbMX0vy6Lg+0FJGWGLn7WAIJj20Zrl+tUqGzo7oysn5vqJd9eqwMCHQX5wjuhKrz3XncDoMWN92At+DEW3+tlcj210Emobqh2VyvrJQ2D584DkcAAqL54Hr1qDgVc/NuHjIDNU5fHjpc18F/o4ayeponf58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429366; c=relaxed/simple;
	bh=zzMy5NtaL7AD5tUyCQ9LrBMAHeKvVDbZmilsbp1EV5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX9h7bl32EdLt3LC+k0BP4LqLGdJhUFaqUWmL9+E5joBrQxNZeI4I60cb9viklbcv8hFT1pvvf97Dpu8Om2vMQ0dnegFJXY7Rrur6ZoNJN0bADKn/STk7+HOl45JNP9TkkWP7ynomt8bE+PuHxA6XeZuAlAIkxgHHSVl87mkecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IIJzTkFp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IIJzTkFp"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso6182251a12.0
        for <linux-acpi@vger.kernel.org>; Sun, 05 Apr 2026 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429363; x=1776034163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=IIJzTkFpFcypFf+JpBX3kCLy4JMfCv1Zs9fbxJTQgUS7rm58OjvRrT9CimkcgwAhtY
         dAGXR3exlHudrXtFM7sEMOgh7dqGp1kBAjICp288kBXERVWeQ3A6rwkucTQ8Uvszfi3c
         TazsJ1AFAZUDj1IFGL2z5lXoiyzJP9ezfObVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429363; x=1776034163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=czoICTTzOYkja/7ekTdt3gCUVm4z0gpFfDAAdPi+tvZQlPGpuHTDTFcPsat1tsywIf
         /XjtuBveviNT09Ovv5p6nhxaZhkmzeqbmT8gi3mUGIrL2aGPzjKAJCyfGlBfy0uW/qlg
         794y8tlRKC0JQfQ9n6d19B30VkfabU5hoDARI1+WO/zbNHbnsnlf8Hod3S7uKTUm6uAZ
         mAk1rf2sWSr/kOgBgIrrpKQGXE83PYq8ntUep8rPwc3XvWNppHNCGetxoQ+FAZ6Fioca
         ZjobeRA8cLcV1U9px8GTNIn8YCqekeiQCbdJXFBNJamlH5HsZ5f5SMIBpTNQjyiOeikB
         MOeg==
X-Forwarded-Encrypted: i=1; AJvYcCVyCD0EcfTSGRw/7EdWQiPUL7xmifYts88csYybkg6dcNfabMg8Urj+6E/cK1r6n29KWkzJeki5BoO2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtdhm5Drbkx97HT6SNpZS0cAEeC7ei7TJ32OB++cdBMNP3D2A4
	achAJtpYvzmmi5VuLWeeuQI/+4CCX+IcELdEpUsA+MuHlFeLE5cbvXPJUq22e3ClsP0U21XDx+H
	bv750BCWS
X-Gm-Gg: AeBDieu3X5PSoocLmHEwNpbVyAUiHrB5IP44c/Zv+I7PLA/Xgi5N5q1L7aocLCODDS2
	FLyipX65ravLpyEkX6QkzJLlgho3SEQS0wSc7DpBuzFrkulRR0aDuIXeRsLfvynRdvvhfnOW6lS
	GNmciFU85LsFcevK6D8BsITWIprHc85flus1syIhHUJ0sULY/mkwpgTZvt+Bkxl8r4lIVO79AlT
	+X7gIX6HGmjyR26jWMwMEjJIsUKWRhP2rXoY0WbJ1aJx1U+oZBu9Q6U607WLQHhvaPiiSIXwNZF
	1B5I1z+msfvSdtKrFeRay4/89Kv/vyXhDiFXEsinr41I+/RM1IO8SQ+1Mb6i+GCAboCqgMz1vZP
	RonZ077pX1m8qiB8uxQzEAOeTB9ZZQEx+bdEQXKQiGGawSd187cf2v6lloxwRbknrxl1ZcAl452
	hNDQc/TuwalWURdFkeHmw/wUJ3LkU8T85zcAdvuqnFr59uhIx/kqB5Qa3aYc2Wlg==
X-Received: by 2002:a17:907:2d26:b0:b97:6147:def1 with SMTP id a640c23a62f3a-b9c679aca0amr471876766b.33.1775429363135;
        Sun, 05 Apr 2026 15:49:23 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99ec7csm422010666b.14.2026.04.05.15.49.22
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:49:23 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso6182237a12.0
        for <linux-acpi@vger.kernel.org>; Sun, 05 Apr 2026 15:49:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQisS6V5ra9Fugth+APgQVaR8JxgrjH1Ddy/j/n90nrBqiGsdv/GfPJXThUOP22RwiCuD8f+JUEOfs@vger.kernel.org
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug
