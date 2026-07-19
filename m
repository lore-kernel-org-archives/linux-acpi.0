Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DE38E8A7
	for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458392; cv=none; b=MeZz6xMPxTS5YMC573iLrEgYD+APnBXepqFnpeSxe5fyPMPOiowfMSt8kYfthxktmPK2FXpL+XSvNB7CbX0ShhV7wcqFf0s30Yr47o1qWDcRFvVgEhQOE2ut2I3nt9VPSwkZwPS45+L363EMnySCwqIzTfaO6LGWZ0aY7iG700g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458392; c=relaxed/simple;
	bh=nSUugbg6Zm5K6TkJVSzDZZu7MzUj3h07ZOpInD9XoqM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:
	 References:Subject; b=RqEA1ipMatWGHidoq9Ci+TtDzrCY8q2EaU5QLqf+0iQ1CMGnyBY3sdHbvTxJN4fJE122dHmqAupR5Zml40es/REnqZoD9y+LD4nOhsjyoOyZeej8OxP3PezZuNwxldaFxcZTV57H9CpYGOvYZcVVGLWtXaoupuzkc5IW97Awnd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwltyhxu; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwltyhxu"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4955d5bc59dso35915e9.1
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784458389; x=1785063189; darn=vger.kernel.org;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSUugbg6Zm5K6TkJVSzDZZu7MzUj3h07ZOpInD9XoqM=;
        b=fwltyhxuTU6/vKez13vwwMGKEkdNlqxv57vueG0xrcTWQrZLWSiUvewOJwv2FcHDcR
         zCjuGBmhNto5YIK6Em/6J54T/Nyt0xvM3/+9FcTymYGt300Ccx0NHiDxKXLSyUbg6y+L
         uvo1RueAsjFZNb7WJEEKZpf0VFBWSYKUbgHmX1T0O1hR1JpZyN8hqse+zMAAngj3pDgQ
         Y3RkeW7MgNlWGRUMOA513yOFXzmLosDvIJJK89I82z1GWV2EA08IudipavsAZtlwEwTF
         HqkJU/umIySxicNyZSJQ/fFi7iXpD/fA8lwKUnUCM95648OMMEJO1M9fW2CCaruHlkEN
         yvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458389; x=1785063189;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSUugbg6Zm5K6TkJVSzDZZu7MzUj3h07ZOpInD9XoqM=;
        b=Ow3zJank7MOshJMfLXZPFODDDTTKJylsZMeqtQcB037KjB9qv7rAT1leZ8sH8IBZcP
         /E8GMDGI04EJnHR6mlNfsOXTeyxxqyTdMyVBN1XsIQs0mLhBImXddSPpQb41pHIhxveD
         vFv5k9gnnmadi8eqw5Qw1HIdkbVF6TVHpEhWwv06Qql9/ltKMRtl2judE9S8FMJE1vxa
         u9CSma+w2HwuSqXkcUARBdvHVD458xCEGEwxHy7x9/r7MyxyDa8gQdh4Sf/dS9KXVGiw
         4R8froLUK/i7LJ+2nVIh99Lbkfa3zvQfUcyb+bTuxK4aObj8C71YHs3TF14rsfRyJlPQ
         rYJA==
X-Forwarded-Encrypted: i=1; AHgh+RrXqjV8RGwjSTVX0rvqm22iOxhmJWNf/Bu4ZJVhX4FxFHl+Nrhg91sRgVjr4oqHNlu0oaRMwiPgIxbK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22dPpLyycd/tg+H6AZdF1m9c1sukHwuj1tBW30SU6MTnF+lqy
	3PfJt2l9Guq0vBnnwqwCHPM0dGReiTETVW6kCicWZwn2BJRhoBvmPhZS
X-Gm-Gg: AfdE7cmeIHL1J0esthAVmJFI7eBQUO4+9UsMMr6hQdgMLqReoXQ42JCJVXNDxu+iCqK
	RMfnGriU4VEWgC37eXaF2SMH51r1XsD+TfjjuGGpu69bBfNjYbMSmexI6jmPShopKEk2x85lXnw
	N8LO2EoTLKy5DpvTisj1G326fyNZO17D82OM/tLcSNf9hzdxHGl2sHVSqzC+wTiEWS4OKzLAa3z
	hthx9Vw+F5G2vIdm9BJepiPznHnVdsBXF+o9DK9LiDeDvSAqYgeeON3KvZ7Gg2c6MDN8XaWHVOr
	1cmM1B/GOBwWPoiiVGgzg0iIOW4sB3fnlW5EqfZx0TrHv7kHlwtje6IrS/5UpKJDH2MF4SCCvXD
	darzZbl24ONJ6frRsnwD7qd4HIIGO6KWTMJzMjXuvS+zBbTmpnQ0a2Hpd8VXammsJR9lq8KLlFz
	2e5q4=
X-Received: by 2002:a05:600c:19d3:b0:492:506a:f48c with SMTP id 5b1f17b1804b1-4954a50b806mr56201465e9.4.1784458388816;
        Sun, 19 Jul 2026 03:53:08 -0700 (PDT)
Received: from [127.0.1.1] ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm141919705e9.1.2026.07.19.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:08 -0700 (PDT)
Message-ID: <6a5cac94.b39440a8.65068.27ee@mx.google.com>
Date: Sun, 19 Jul 2026 03:53:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: =?utf-8?q?Metehan_G=C3=BCnen?= <metehangnen@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-gpio@vger.kernel.org
In-Reply-To: <2026071842-trillion-ogle-1f66@gregkh>
References: <2026071842-trillion-ogle-1f66@gregkh>
Subject: =?utf-8?q?Re=3A_=5BPATCH_4/4=5D_MAINTAINERS=3A_add_entry_for_GXFP5130_finger?=
 =?utf-8?q?print_sensor_driver?=

T24gU2F0LCBKdWwgMTgsIDIwMjYgYXQgMTE6MDY6MDRBTSArMDIwMCwgR3JlZyBLSCB3cm90ZToK
PiBJIGRvbid0IHRoaW5rIHRoaXMgZW50cnkgaXMgZG9pbmcgd2hhdCB5b3UgdGhpbmsgaXQgaXMg
ZG9pbmcuCj4KPiBXYXMgaXQgY3JlYXRlZCBieSBhIExMTT8KCllvdSBhcmUgcmlnaHQg4oCUIHRo
ZSBwYXRjaCBzY3JpcHQgaW5zZXJ0ZWQgdGhlIG5ldyBibG9jayBiZXR3ZWVuIHRoZQpHT09ESVgg
VE9VQ0hTQ1JFRU4gaGVhZGVyIGxpbmUgYW5kIGl0cyBvd24gTTogbGluZSwgYnJlYWtpbmcgdGhh
dAplbnRyeS4gVGhlIG5ldyBHT09ESVggR1hGUDUxMzAgYmxvY2sgbmVlZHMgdG8gYXBwZWFyIGFz
IGEgc3RhbmRhbG9uZQpzZWN0aW9uLCBub3QgbWlkLWJsb2NrLiBXaWxsIGZpeCBpbiB2Mi4KCkFz
IG5vdGVkIGluIG15IHJlcGx5IHRvIHRoZSBjb3ZlciBsZXR0ZXIsIHRoZSByZWZvcm1hdHRpbmcg
d29yayB3YXMgZG9uZQp3aXRoIEFJIGFzc2lzdGFuY2UsIHdoaWNoIGNhdXNlZCB0aGlzIGFuZCB0
aGUgb3RoZXIgc3R5bGUgaXNzdWVzIHlvdQpmb3VuZC4gVGhlIG9yaWdpbmFsIGRyaXZlciBsb2dp
YyBpcyBmcm9tIFZvaWQ3NTUncyBvdXQtb2YtdHJlZSBkcml2ZXI7CkkgYW0gcmVzcG9uc2libGUg
Zm9yIHRoZSBtYWlubGluZSBwb3J0IGFuZCB0aGUgbWlzdGFrZXMgaW4gaXQuCgpUaGFua3MsCk1l
dGVoYW4gR8O8bmVu

