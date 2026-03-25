Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501132FDC2C
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462295; cv=none; b=ZKcHdfFyyVuad9xkyMuGK8xDJhmsClCXlqcK+Ig+Lj3/x2r/Y3n3ZLyQj4qenoKZZC8gXuBip0z6f6OLbockTYvHgM0sNe7PvGQVjG2RRrwBwgbkyX5qyUF2EWN3I5qiH/dswzJCrWQEjW2vmk4jxunKkTAlyjr91DiCH7Fwafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462295; c=relaxed/simple;
	bh=UBwKxEoADOSTMP3lZyptRDYOtBtcnX3g1owjnqVBmIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpITwxlWfaawrEpZS4Lklhlc4SfE/1J0rS72AQVSih8y5ryocVW9kk85B3sZDE1jAvF4WuV52IpXfXsD8JF+uJ2adWnK8wUKxz5ONMVT6AccgGx3UpgaztWqCy1SVZkJb7qfA7H8EiEPGLPyouTpfxDL9UY6a8AiKfKDI6Hw6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFh55fWn; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFh55fWn"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so254175eec.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774462293; x=1775067093; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=584IxrfAi6B/ScV55kQLVZQPPg7Co7vyP0pW596N1Sc=;
        b=WFh55fWnt/khWnrwzpz+uoGzMWr+Bm+I/70qmH4FJ0vFs8gz/iganxu33ohdN2V7pM
         G1pU7z4BSz/mRPSz8/Weh5QYaqk9S5eSR+UuwE0wFjWrguclbqeCj+ukmnUGDHnBojrh
         Ny9xEWLzvhg91wWP2/LN0naHx6UO3fE8Wq2FfLoGI7jMXwFpD+IHMSl9cMbVMsHwG6bu
         1VW8Ha7+UumaNGTtaetI52JyN5T4+cMOJBESBDquZKd7waCgW8wkeXFGqnej9LhRr0s8
         MsJMKOnwWFfFoB6HVkqOMdURnbsZqrVS4RZ8FBz1QQ5hv0eeOMzZnIkZa1XlzNaEyL+Y
         xqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774462293; x=1775067093;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=584IxrfAi6B/ScV55kQLVZQPPg7Co7vyP0pW596N1Sc=;
        b=P8TbWJsxSkQqoe+F8SJDhXBYLGv/yE2ertOedxS82J77+7lDqrSkCeWsYPrCFaykzU
         /PbBZnCpeaPD7x+ibQt4PWlPOla4EFj7otbTlpwrkpeT6Mvi99JdVWs0s6+eEEGzHjaO
         RhEfdtMFYZ1O92uZD9592GGcKWNWrU7leKb0NVv1VjoNVRc08SMEDxNRzFrJ3BUH9suH
         uWBhyohZA7+FD1H64YUW+uni1eMS59sQ5tJRcX2agVBfM1Xu/wm4raEKKYKL957CqOIi
         yYIwUIugBhKHBsVpeFkOvoOuKOhtMYQNL7y6BVdUQR/yFwiYybYR2gaRDusy/+Jvm8V+
         RLgA==
X-Forwarded-Encrypted: i=1; AJvYcCVI8xWIQwxsP9W5kgKcIPxP9sC3RGf04TJC+FTgie3tSTsK94f7noNchVK6F00O3XFFj5viuIDOUGk7@vger.kernel.org
X-Gm-Message-State: AOJu0YycN/RHk6Kog35tUlYyT3ihnqyH1lx0Ys7lhPetFtvmbkeYj93/
	LhA9Jls6wdrikz4PpjZ0Nq3KidJpsspOJ1jKeI+yWCWHmmEFWBzPypqFSMOyzg==
X-Gm-Gg: ATEYQzwKOLEdV6OSbIt4cie2OC51gAq6gvLqhPdFwyTGQytIWFCWKDDgIRK1hyzFYbL
	wkNlOj61/L9+fnHfh8wu3Re/mwL7jhSoroGRcDgbmSqbpsQ8AC3g+B6vkK1IGOrEaNqXFwnEWBz
	lwHvG24qbwW+bdBwKfi3ZtEkGh8mo7O7IyObAdoVjkPt7LPzLz86EX3xgTyfBtxXpssoV4WPwtc
	ngkQLTBgb7xGtN9PHZM2GNK0IyqXpMzyj6BDkIQ+fYh1sRXXCLAk4BUrfzarUtVJmIQiwOapW8l
	IdoIka0xILBJR71N0ofh1X21ERUEQZitWMD14OIJPwjk2P9FbanDUdDnSHv8XBuoJxWlAtB8vvW
	ojGg76eekUcpQCgDWqYgZ5NIl+qbKIQosHyT+YOTUmH6IE8yoIm5RdHXc7S+cSkyww2csXJ5exu
	ekYfkTFRUKxjF2/+AthpEowvuDKAn2alz0U7WJAT/OvtChGAFIRHLHWcH4Va7YlkoQ
X-Received: by 2002:a05:7300:2153:b0:2b7:b7e7:9025 with SMTP id 5a478bee46e88-2c15d42a129mr2169805eec.31.1774462293350;
        Wed, 25 Mar 2026 11:11:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec7f9c9sm543011eec.12.2026.03.25.11.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:11:32 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:11:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: allow referencing software nodes by name
Message-ID: <acQkxvgndGyU9GLu@google.com>
References: <acIV6xF8mY-8wd5e@google.com>
 <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com>
 <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>

On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote:
> On Tue, Mar 24, 2026 at 8:30 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Please post the reworked version so we can review all the details. My
> > concern was that it relies on notifier chains to notify when devices
> > get registered and unregistered, and instead of matching node names you
> > now need to somehow match device instances and software node instances,
> > which again likely is done based on some name. This just piles on
> > complexity where a simpler solution would be sufficient.
> >
> 
> I will post it. Hopefully before the end of the week. I want to cover
> both OF nodes with paz00 as well as ACPI with android tablets. The

For paz00 I hope Tierry will pick up my patch converting rfkill-gpio
from board file to dts.

> latter case will have to wait for devices because there's no way to
> look up an ACPI node by name that I could idenfity (correct me if I'm
> wrong).
> 
> > I think this approach also will give trouble when there are multiple
> > users of GPIOs provided by the same gpiochip, in cases where users are
> > split across multiple modules.
> >
> 
> Do we have any such use-case? I haven't found any. If we do end up
> running into this corner-case, it can still be done by centralizing
> the software nodes in question. But maybe let's cross that bridge when
> (and if) we get to it.

Android-tablet could probably use it. The gpiochip software nodes are
already consolidated there but the code could be simplified if we could
simply use names/labels.

Thanks.

-- 
Dmitry
