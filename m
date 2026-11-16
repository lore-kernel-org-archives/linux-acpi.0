Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829984;
	b=U1/IM/rs6kBdMwy9j/X7mqzlZPMpRFaqV8vwyiRP1Gm8pj1THaukkdsUPGYenELlrrvc
	 xliIErGrMAxRLKq7ko+na7/ESuYIALRJaLt+fUdptG26SuIUI6/wbByXH5OXVqvWYD1/S
	 EHokU7jbciMNkJ2UEGugRk9NbwnatDYrJktLVXzF+p2MM+vl9FQmawZvlEqVXBKRs3U75
	 GsFiZNoqwBrYC1jQCYjrS4DxlR3zGBcBuSFSVCa/n418c+35k6CMRXNOSwDBIQNpi7c3o
	 Wm3NexsqUwarVRk6HuVcWQZTtYSkYAlzckE6MHOfNSvUUMvcWyB6QbMt2eoNdLK1gFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pO7ejxuisYFiK67OM4MpgvsVQ7/7ICx6J2Ag4S25/oU=;
	b=HoI1YY68NNJLsCPZqnewK4HN4+mUJacMuWVU+v13xazsVJaxnjBo51zUc5maCJyemBCR
	 zl3OKq/o+fZZ7Y+GA9eJ3PJ2gKjFkx1aVGObKhF/l9yE3MOuZ2TfOBZwrULoDgKS5b0xm
	 WliirMFkZ0H50GT1nP/HjGIfMorHHFIzdTu7ZTYDCXm8NUkswX1bLH891aF5VkduTP8MI
	 2NsstQAEUN9f6s87tCOf37gtOQq+pEbrCU09D1yn6ZWOjmtgRuV2ACjDNEejzAAsRnVOb
	 o9waz+2T+/Gr/4CdWBlhkX8HXOFUvLyDDdwNsfE4xwCYu1/HHElyDKSxy07SKAHEIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EQorfjr/";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ECB606A337
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 11:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86ECB606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EQorfjr/
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e10a70540so1815928f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794829983; x=1795434783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pO7ejxuisYFiK67OM4MpgvsVQ7/7ICx6J2Ag4S25/oU=;
        b=EQorfjr/le+xrt6rRx0aqewV5C/72AyI7slViP9I2mMqrY2frCMiC9eA2kU6PldTfe
         d2ppNxxBW57kub0UzJYDi2m1bmxBnaQkiv+DBn7m73b82wtWpXZge2XEBVq8Yj5BdyiG
         YuY+Hzn4cGfJDC2pvnbKrEDdfYWt2Z2iBDbH4ycXbvMHzeqt/2lqu3i70CUXVOK26kmu
         GVLINhavriOSnCa0I1E/mKgT9MiAv+t0eJFkLeN7vlyZTXhcdbFV3CpeBKR3d8JeJxZI
         3rV3PATeMttVTD4o/HvUX4HGKlhQviYoK1XMcV4K8Zc9LjGTSHhnLxeKxHdxvvktLTto
         fhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794829983; x=1795434783;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pO7ejxuisYFiK67OM4MpgvsVQ7/7ICx6J2Ag4S25/oU=;
        b=XNfkxuCO43JPyLNnF47ZwHBgvg2zyzOE2a1ndXyIrvpYc1a9dxMepMgl1iEvqTsH4H
         4rTRLHUzoXTxX6SM6pqP97X1UQF+SQxCNn9jC1rEWZwIIbGX8orpomOxCI3apKYBs5LB
         hIsWgQIvSNOa5Qrzc+QZw37DUeBMNh93Vw8STCUcFWGYDVk8HMCCU/Bqbly0SmpJImow
         w29OgywQuuftZcBQfyhFbnDn8eP80A8vYCtEBvcfNiU08gTW4uq92tWrwHqRCQKzNA/4
         EF5BUVUwNTZg9Oi3ezPedCj0n9IlObenJ0cVc3bycnfT1MwGb8uvBbXuYykHVVjw42fv
         MOtg==
X-Forwarded-Encrypted: i=1; AL+hErEhqVp8w9vPXSuhl24Ecp9Zd9MgGprngbladvx0Eyypb7hEAK2alaAJQx3Ven7let5106DP8yY3hxie@vger.kernel.org
X-Gm-Message-State: APuU4Z+anr3rafC+Rv/rmLmwC1AtVFS4ghQCFIpzF8iHblHTkK/YG9As
	7qLm44vTvbfDjnxbmzciDdfgeb7PIpmQ2BDsUpNA5ua7VNFSUTg4kkEs
X-Gm-Gg: AZFdTZcEx13Y31H57O7NsAI/Oa6/rGrUIQ2hzz7SUwpFAtZKIoF+JkVJa9Ez2uZbpgc
	jlzbTMDmgZBsQgaQTc3J2QvvWET60EcDUB8rXwXkB4AcBkkUsOVqG0ZJIyoeYp8x/UByBcnrkoJ
	Ip84kUiIO5ijeCJ12NFWRD8BZbQXIuCTsGYOyjx82YwE7gqk/LXm+Lf41nRsP4/cy+yjeESV0FR
	qHEzu+EtM3kv8/NcIlg8pywLTsDKUHACvVFOnIQAn+Bt1ZuGHOsQi7T+6Rp3jQq+AH57LpyhQnF
	V0+gMp/n8k0c6NevxeF9pnoNmMH4Cx9l9xw5G4MfMi+9CCYM3/Gd6ZG6L9DQFYVEDl/i7sFWmKO
	F3pxYWn3LjJjAClj32CKzL0OQHuYQs9JZshufzG1poZiKb6RcLEh0lPGHs0c51Zr5HQWak8/uJX
	8dFm9XkqHjVupXti1xoWaHmZb0sONKdfkkTK8vQSTyqhb9emxxUgoDVoCGWr+O+cSZqmvp9RJss
	pmZFhYLEAaL4airqGcgQLeOqMwOc6rkMUZm5sAirbMGBF8ucI6d1ClcvtcT2mpxGAY3+VlQxCH4
	YFp3DOWw+x4EEcp/Irep3jS+TW54OkOB8z73qbkQ1fv/QmFyMbM2n9nlO8a5wDc8vA==
X-Received: by 2002:a05:6000:2c01:b0:499:1c0d:4568 with SMTP id ffacd0b85a97d-49c741b14a0mr24577066f8f.48.1794829982872;
        Mon, 16 Nov 2026 03:53:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm23686370f8f.0.2026.11.16.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:53:02 -0800 (PST)
Date: Mon, 16 Nov 2026 11:53:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, linux-mips@linux-mips.org, Ralf Baechle
 <ralf@linux-mips.org>, Joe Perches <joe@perches.com>, Alejandro Colomar
 <alx@kernel.org>, linux-hardening@vger.kernel.org, Krzysztof Kozlowski
 <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, Danilo
 Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Johan Hovold
 <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: Off-by-one in arch/mips/bcm47xx/time.c (was: [PATCH v6 02/19]
 string: Add strprefix())
Message-ID: <20261116115300.544a33ec@pumpkin>
In-Reply-To: <avriaVSTl4jL0OEo@ashevche-desk.local>
References: <cover.1794667407.git.alx@kernel.org>
	<0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
	<c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
	<avi54hgKgovNHfKy@devuan>
	<avriaVSTl4jL0OEo@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 13:00:57 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Nov 14, 2026 at 08:49:21PM +0100, Alejandro Colomar wrote:
> 
> [...]
> 
> > > And these are all candidates for converted uses to
> > > whatever is the function name or steq:
> > > 
> > > $ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)' -- '*.[ch]' | wc -l
> > > 946  
> > 
> > Looking at those, I've seen a bug in BCM47XX, introduced in 2224de9d152b
> > (2013-10-29; "MIPS: BCM47XX: Fix clock detection for BCM5354 with 200MHz
> >  clock").
> > 
> > Look at this line of code:
> > 
> > 	$ grep strncmp arch/mips/bcm47xx/time.c
> > 			if (len >= 0 && !strncmp(buf, "200", 4))
> > 
> > That strncmp(3) call is wrong, as it's really behaving as strcmp(3),
> > since the 4 is off-by-one.  I'd like to know what was the intention.
> > Was it meant to be !strncmp(buf, "200", 3)?  Or was it meant to be just
> > !strcmp(buf, "200")?  
> 
> When in doubts, preserve current behaviour over refactoring.
> 

That entire function is strange...

David
