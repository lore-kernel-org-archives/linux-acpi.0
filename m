Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D143BE164
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082039; cv=pass; b=eyf64/3T9v38UjVgvezyvJ6DMtUSxije7rBM5cgHf7jMwZ4El8TL8xYJCycp3dcyWBs+h8jzv7qFnr4IkSK1DaMWx/zsi+TKD1J8YJ/nKmbjgYo6VjueQU3d/bXzlP2JqtrnBwLymxXjRkVjNW0lN22nqKe0lPhYxpV8XqMsI00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082039; c=relaxed/simple;
	bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8SIXHwsWQ0yX2GZlW3obm0T1QCGwexqvzoVVYMFzAu5k5jf6bKMm3Zlr1cfrd5Rc/kAHePXEIGAEaYWtnlo0QABr1UqoOX0m4Shrb65yUoIcXqgUb1ROixx3X6cpC4MyQZTrEDXOLz4jMZzma+Q4W7eKUp3lbaoS+1KvHi2/ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hk0Zh+sY; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hk0Zh+sY"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7f4f1c27e61so2593887b3.2
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2026 02:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781082037; cv=none;
        d=google.com; s=arc-20240605;
        b=RRFrpjcnPh7wnOnoEOGpROb48LL2/95AkCylndy05NlqjrmCBeR00+Nvvw8W7oTI6w
         lBHRkrn8pLUFjybU9sDJ6RlArpK1c83CWscKi86WjINRslIHnMDeAp4bbFwuZS/Eesls
         lBGR/IZfB+MFrad7cSiIiCV7hMX402uPEoCCNCJ/r8us+RXEmdJET9GInYyetHP303Dc
         Rmhft6Moyt6ip8CMnZ6s1gRYbgI/D0TTQ3gRsjB+V8hEYdXLuZFKLi7amdW8nbYkNv+F
         eCjp5pSdOC7nkSl9fIv354nIJc7RB/HP76OCvVaSRS+NGxVjO+bidFg1Csci09oIjB9J
         5rZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
        fh=DvypF0aC6xFvazf/k0uw//PpNmgCkT/bxLYghlVYpZo=;
        b=FCi+QyAQwn5bCs79sSiuAfxyItoSeMJrD+IJz/03Bw7VewiEyx67Sd9O8hhfTPXnfk
         8etWPESoKUIveIvKN3egD6ucOHJBJP3p0BIU3hpmuGEqPb/p0gkjkJsF+VfCC/9a/fov
         lS7ZY507iPfLjhXaoRqBW7aHjgiFUZprLllW0KwZJlniyceuSty9P/ezT+Kac2gLJjO1
         DprMigv48YlC/G7KiRIIOKLjU06IDxC7l1QHkkxxDaJUHVCztrHNrL6sHg6j6XYkiOs3
         apP3V457yDNf7x84gCDrwNJfBCotIumAsAwvoXGJToxX0A75p3gekCa1EkRtdvgLjIIg
         0wvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781082037; x=1781686837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
        b=Hk0Zh+sYg13jIEQGiM/zoJFUZAyBdCKzaRaO9w3/+Ct/dDp+VZi6j/5rWvdh2rGcoj
         ysGqmg9X+N/rk+Jlo/OAoB0066b/spaORrvGb93ntsw52NsJCleS7f40UU6+nbvqrG4A
         5ezLBKWcdRidgvbZcthPs4STlzgNFGa0mHlGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082037; x=1781686837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrbLcQyisI1OEjYF2JehulwALSIbAajyo9F3M0zxr/E=;
        b=h8P6yJODcNhPumUxWbGErGBRm320E4GIAPEmxwMahZETIQar8Jt7Z0pJWoREUVbOYe
         ZX16hFFeDCDaHmgt7tLNR6jpUwP0MVk1ZDF4vX+8iFZjbV6TPtKlKMwy6rzkOyBUaCNT
         DEcjs5gWf5JrLI5s6tHouhVAM6kTCfSmzmFH8eGkXQIjKHAQrl8iV9r21W+1MP9aYs+/
         XBoPjNi7bgYzzcforPwHS8+UUFvqOQh4w3lsQ/OGsjvb/uEIMjpBnJl24B5/qQE79Mzl
         Q/pWgEZi8+W2vDTjWiD9xgE17LzjdYtjLWm/jmDhLaxNM2EgZdlfhXxy5ZAetZ4yE3AD
         E/Kw==
X-Forwarded-Encrypted: i=1; AFNElJ90XDu7/2hr9qGxtktUDbG1OVkQ+U3z59jGSBApZPul1I8qpsBktGw++P7ydl0s9R9dTrDAKHB03PJI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAstYBJSCNBkmrovSpBfl0EsXmjalo8scK0/BjsOpKigrMT8Kp
	rVrmVPbh96PF/EhN26zFEwjla8TjMJo4oMDzHLHi4Km4yU7ws8hQecJLBTX1rl8JqMZi2T3O2UK
	zE60h1mP5QeRo0r3Ra7Mj6d7eEaCkuMlgwB1CRqJO
X-Gm-Gg: Acq92OF9f1+1J4j5ENQxiZtgbGc9Gws0cWEX24liqBDSbOinDsf1hdqLkcctVnt21dI
	iNkE6UgE9W6R6tNtQFT2weldZUhfGKqkpOjy+me6CotDKAvJI6JuaZmZzZUOJI5K9hrv8aOXU/6
	HzQAjcOF8EqGgoN3VGJGrIqOm7JvlbE37Qdz76mQJ7h1conTMjFOR+rbe8xJchoR1RPl0gYDq1W
	gi9KRcvx6KphlBN9qW33SAqJ+RYe+hG9HUNPRJy68Ern485ISc8ZbkVx5E16dc7+KMyPBvrAaG5
	9PrI7XBhI4j6LlYGlu8XWUnZI3IZew==
X-Received: by 2002:a05:690c:6c08:b0:7bd:8d1e:39fb with SMTP id
 00721157ae682-7ed0a4ed459mr225795957b3.7.1781082036496; Wed, 10 Jun 2026
 02:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-4-wenst@chromium.org>
In-Reply-To: <20260610084053.2059858-4-wenst@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 10 Jun 2026 18:00:24 +0900
X-Gm-Features: AVVi8CflqNzYUTj7jVe9ENVhBouReNOK4zYnRNLDpQhNXfjJp66LGpOOH45Xjpg
Message-ID: <CAGXv+5ENxq3B63M-HnW95we+2r+WLfCLm5TZ820zWiC8FSakSg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] power: sequencing: Change CONFIG_POWER_SEQUENCING
 to bool
To: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 5:41=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> USB support, including the core and hub driver, is bool, no modules. To
> be able to use the power sequencing API in the USB core, the former must
> also be bool to avoid the latter being built as a module.
>
> Change CONFIG_POWER_SEQUENCING to bool.

As Sashiko pointed out, CONFIG_USB is tristate. I was looking at the
wrong symbol. Please ignore this patch.


ChenYu
