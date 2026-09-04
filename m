Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA864FECDD
	for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540266; cv=none; b=ujzRuohR1cYq9ruCL9eUgc/MYOv4qeEd0Xg92g0Kw9RUguTTV/n1uuCXqXKZA6ZICnbThvof0gW6KXdenQm7uVTGOiKCd+EzHU4EBasuuyJn19BFUWytcltpCy+hSzhQ0XvJoTQOedrnaJbha2IpJHA6vQ7AdK3QnEvv3Lhk59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540266; c=relaxed/simple;
	bh=zuOhkEhl9/3hyPjwkXOeT9Ut7Y3NkxiWsPCsZKsgbNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+A0Xf8IgHE5sqkH/uUpOGcGy6Vtkpog2E3Gw6pmRiMXixLVrKKfJ46STdwqzKTnDaynAInhIhNw5vI49paAxVENZHy/V6/EbkDUrANOStEFE54BebfW5n5y+2+BGqk5UYCjFYpf1mjQ7ld02udZUZ07iz3wzLUat599xDcgm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=lkplYKnu; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="lkplYKnu"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90cd43bd740so13603656d6.1
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2026 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1788540263; x=1789145063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w/3GNXQSGCY34ByWxnrlCAFhsDJSzJ5v9o2W5RmLNQI=;
        b=lkplYKnuLx52STNBRE9/OmlWQ/WfYs+lwfMhZ000DoGGVaVdCgDiuDXUS/1p6Ruc9b
         2KGIuOHOp9dmFNj5tCeJ3yrQuTGCqe/vUECH0bhV9EDuZt82XUxU51E8QjSNL9E+My+J
         atNG2VhcgWGy3HUdVYpyePtJbA/G3T4Q93TvB8aC09O3Vj7NODxXvte1l+BOU4sUvEve
         grRdxqU9xVVfeQ3EcGGQQEx3qX2U9ywwIAHn81+UP46ynR1JPXIwrDnekXGEt4+MDcIR
         YI6GlKskDu9ShKEpLxWQKK8uJgn9kB32lvhylpkFZkAFM54XF5nUQSnO58yPxGO9Uxah
         iyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540263; x=1789145063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/3GNXQSGCY34ByWxnrlCAFhsDJSzJ5v9o2W5RmLNQI=;
        b=nvJ9KsUEAK0oLjgCxtp7QkTzia/fsQ7sg2/KlBC0bGE4jYVjNCcwVSSX0HQSVaZSbQ
         fzf5UoYYiZKIGb7EZgvjFeuegLRGTpzxVZ7Bbfgkiu9kQl6wMZPq44rI/LP+jYmfEIgD
         53RwKCvrxQZYH6Q/Mc6RZag4VZO9mUZ8Iiyne1M673fzSdaliYxcBhnmO46rD6z3hOHG
         StaabFSR9o7EN0/O0mCm4hr9q0BSjiuEhTOxrBKMieXFAVhinCXDm7xl7AhVXH3ZfLpN
         4wFbNtV33uGeKr+peeu8UVuys4EimUAPvIeYb5Z/oL5FsYVPAWJvzJO9UP/+cGAAwXuA
         schA==
X-Forwarded-Encrypted: i=1; AKwUvByfbdddugKmmEQ48ek15dk/OO9LD7ni/EQ7pi4rK/hEy5ePTXA/q5REQh/Mvp6j981M+NNPNWMIg0Yb@vger.kernel.org
X-Gm-Message-State: AFuF++mw0juidHeN4XgC/Pe6/07Uz1oo2jkLwVQ+DfqtaegaTjWNLoC5
	F+Yr0EO8c0VeODOQL3MsyePX+uJmJ7FWxtFz9snVBClrqeadOnBs2N6i239rLLB0cA==
X-Gm-Gg: AYBFou0f3vpGz+9ucd3u0uxpKd5DlQJ1LRuRrOCKY6j7bydPFBWgqegGqzSK4mAinAE
	VnuVyGcJ9+KbpfFlDgC/HU6ZsKKcU9ejcGc4KMKOLsJb04u8gBh0G74/JvkcnGAqoCbln+VPkfS
	5wN9YL9deeSK61NQKIUz270mA4bl9Plel8T9QstXQ8dcs5j588/lTabvMCYoBykDWkQXu5NZN6R
	lr7YJpdD+zxWHzREiIXoFGRKvzfkOcS8i90v2tAZO1fqeB7nd3Y5DYuhWUfVaQFZJ+l+VXMbZH5
	KrG798m1dgVuE9+t6TZivdV49eYjLHJLDceLgV4Yh98FxxSIfzLOttlHe+QB0XU5v73g/5NsSQg
	NKKwiPIGo8aT11BPw8UjDgOzqV5KpTf0y80e8QvTsWg29LjNyIkxXcW6Mrb+EauC1GDQVVYRhvO
	kqqD7SW2FwRK2hxu5PkCqQYVOVKpmQAXCOOSIVHif2l9aKe22XjrMx/niMHcN+6w==
X-Received: by 2002:a05:6214:3003:b0:910:3d6e:ed46 with SMTP id 6a1803df08f44-9103f0db656mr78478096d6.31.1788540263010;
        Fri, 04 Sep 2026 09:44:23 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d64sm24672736d6.14.2026.09.04.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:44:22 -0700 (PDT)
Date: Fri, 4 Sep 2026 12:44:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v8 08/16] usb: hub: Pass |struct usb_port*| to
 usb_port_is_power_on()
Message-ID: <c3740c4f-6ae8-4c6e-8f80-105f1607ef55@rowland.harvard.edu>
References: <20260904084158.1341550-1-wenst@chromium.org>
 <20260904084158.1341550-9-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904084158.1341550-9-wenst@chromium.org>

On Fri, Sep 04, 2026 at 04:41:47PM +0800, Chen-Yu Tsai wrote:
> usb_port_is_power_on() currently takes |struct usb_hub*|, but only needs
> it to tell if the hub/port is SuperSpeed or not.
> 
> In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
> state tracking field in |struct usb_port|. Either structure can be used
> to identify whether a port/hub is SuperSpeed or not, as the field in
> |struct usb_port| is inherited from the hub:
> 
>     port->is_superspeed = hub_is_superspeed(hub)
> 
> Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> |struct usb_port*| so a subsequent change can use it.

Minor complaint (not referring to anything you're doing here): 
port->is_superspeed really should have a better name, more like

	port->is_superspeed_capable

or

	port->is_usb3.

As it stands, the name is ambiguous.  It might refer to the speed of 
devices that the port could connect to, or it might refer to the speed 
of the device the port is currently connected to.

Alan Stern
