Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09C3ACA71
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409231; cv=none; b=J50zIJh8T4ehRVril3EFuGlocXY+G3RzR706Av/eyb3BgxP+COzTeSjcPU9l0PMq+ef/B4J6kmUiy0zySrWbKD12afAe127yVnBiyKIgE7OIApQXWXMAVmsPqu+fQNC46nmixeV5dWNdpAWVxTLcVosLytowiIzA0VOZpStjdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409231; c=relaxed/simple;
	bh=bW4Lcl+ROSBNPUrB8CNA2HrOrOhdvNO7Bz253DXWnn4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgAUA/XKO3+iE5FTXZPi+yF71N4/H9Xqjrt+E+SUugQzYF3kWxHbTIX0Lf3hA+oAX8g8/8kVgKFZ7aHZxrD2hAxOqR8TV/ZH4xIJ+5n/PgwL9UR0A7+g95iINRmMVt6smOFWsGnHeU7HhH8RUcHf599sML4l34yzodd3mkQ+GWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cETGzNHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cETGzNHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131CF1F00A3A
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jul 2026 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409224;
	bh=ZrZGOwP5B01XzisV/2lSakcRQu+bfQOZKRCHG+hKN8M=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=cETGzNHthxtLXPaqaAF548RD9GSQTCvlXyuY+TRanmCcB/GUqkZqjv0e4gGXJetsM
	 u0RnwRIICdUz+KWrglcwQrOA8vMeBP2zA4X+4B5u5ykXhPzgusn6FXBWYlFjqakHSh
	 ce0XKPZdHnXvpBYj6dJI0z8LaAy+5Gs5KyRSkmeP2sNNeu1qpa9BWjgZZB88kj4caK
	 qLhODutEBjPR51JpQkX1Mj4bb3t4wLUphv/UjUZZnueBLSawz6BodI7LBbKvIf3koW
	 Wj/fE3dAFrL5JKaT7keQcLEwB28GqVidWmFMm21hQoJjpH3uOERqjKqxXxL3oZs/3e
	 iGOiCRT5z04QQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3995e22ef81so3156711fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2026 00:27:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrgkOnBimJKfP0KAl3+FHVS2suRrqPZiOwCo9N4FtHoNORZdQkHbfYE76RPAXMdQGCF++zUO7o98nxM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+naLh8AaeL8IVwUkQTUqFQS6EK6JPMSOmIwFs59MAcF49YUN
	bnYd16Q7BqWOwSLLPd5+1d+c0Ikg8tOy0unaUt0OBnozfoibZdfBiZG8gKS+C3armQwcaJH+tv3
	xD/M8fnNCmISMb/r/G+cRaIE4qrSbmqJ5BtVDZZgZyQ==
X-Received: by 2002:a05:651c:1a0a:b0:396:ade7:4153 with SMTP id
 38308e7fff4ca-39c697222ebmr4269631fa.0.1783409222850; Tue, 07 Jul 2026
 00:27:02 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jul 2026 00:27:01 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jul 2026 00:27:00 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <akwKlx2uTtHXI7zT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-swnode-fw-devlink-v1-0-b90058b41839@oss.qualcomm.com>
 <20260629-swnode-fw-devlink-v1-3-b90058b41839@oss.qualcomm.com>
 <akKT8q5TjkMkZkmB@ashevche-desk.local> <CAMRc=Me4oJG47C2LOzRvagbEtAWKqbzmQ_R2VG4rt6zd1-QE5Q@mail.gmail.com>
 <akwKlx2uTtHXI7zT@ashevche-desk.local>
Date: Tue, 7 Jul 2026 00:27:00 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdNfnaz0e2P32d_jWdsvtW1-zNF9ddUx092K3TUgzB7Jw@mail.gmail.com>
X-Gm-Features: AVVi8Cem5ut2dgsOwY3Bh_PHkM564EYcgUEVcmUCNMvQrUrYuAW0mstnDj5h-8k
Message-ID: <CAMRc=MdNfnaz0e2P32d_jWdsvtW1-zNF9ddUx092K3TUgzB7Jw@mail.gmail.com>
Subject: Re: [PATCH 3/5] software node: add kunit tests for fw_devlink support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 22:05:43 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Mon, Jul 06, 2026 at 07:42:36AM -0400, Bartosz Golaszewski wrote:
>> On Mon, 29 Jun 2026 17:49:06 +0200, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> said:
>> > On Mon, Jun 29, 2026 at 12:52:08PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
>> >> +	static const struct software_node supp_swnode = {
>> >> +		.name = "swnode-devlink-test-supplier"
>> >
>> > Keep trailing comma.
>> >
>> >> +	};
>> >
>> >> +
>> >
>> > Redundant blank line.
>> >
>>
>> I actually leave a blank line between static, const and regular local variable
>> blocks for readability.
>
> As far as I know this is against the style.
>

I don't think the docs mention this particular situation - correct me if I'm
wrong. Since I wrote it, I'll likely maintain this file and my personal
preference is to keep the newlines. I hope it's fine.

Bart
