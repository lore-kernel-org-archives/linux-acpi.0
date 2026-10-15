Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2751AFE0
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058118; cv=none; b=RT6zX0+zBVCU+GxxswB6MlC05CSUDs3hE1w/8/pOiug47oFRKLJB0CKobqBxdvWlxn+x8vgekG8yb7P4rVKf7WPjQsSX6Y0sff+kEPDvMCG45EG7IA+1ssVxILPEtBZ1f54x3AmOjn+uXrPldINBWD0cOUDjntwItNO77LFiv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058118; c=relaxed/simple;
	bh=JLGAow2rLUO/+TKOPOX0VJmztAPGduP307ghbO3dOEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KW01BkuEnHEGiLE1sIYF5HOLVJloM4Gfo53PqwKiI0fcmy4REA/C67d+RM4/uPiKHRS3PM9Gqfl7WThAwT+3l48jDLrVtTlA7I/Pf8MzB4fnl5jmc1mqsTHXBUsvwoMlSAWrcT1BBwgurxHuEBQFk79HCip96HfdlOafvWflV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjV9QYzv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjV9QYzv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53391786e55so83097771cf.2
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792058112; x=1792662912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaMd1QSYMqEo5wIiy4wQAPVusgGd/ylNS3r3kXBy7sc=;
        b=rjV9QYzvJMPx4FYBxMEwoe/VqHo0fj9IqklI3SEAkS4+Dzagc00P3KLWV78SuopmeF
         yXqu0bRHT2nXtDgUlGeev3n6XalrLHQjZeWITiFuSSWF/zdPZJh1yL5Gv7Nc9PtKDkRO
         PQY5/BnLXFghyXKWGlR6kU4FBz7+iT6XjQ5iv7eX23RGREMrGF8yjId2O5Ruv0BxexAz
         HV4H4TuvpdnY5GVqbvXjqAiifeGRs/kSLCbbYdr5VhOyhMIrlyCOrX4gr93BDugT8/l3
         u//zaNCJGDDzmefMEWtC7DxxVBls8fwdITWx3gY0Z3lZmqWCK5CFOL0iDefbpAWf5bww
         L3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792058112; x=1792662912;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaMd1QSYMqEo5wIiy4wQAPVusgGd/ylNS3r3kXBy7sc=;
        b=AyC8QoO//8jGEL+mEsDCkQcHqKNmHtj+Q73Xayxrk+BVjFtlQ4tpL6HD7fRh5/qYNq
         z2TQIw1M0qUslJUK0YqxEbFj+ZTnJHSRFKggZ9mIYBUSCl3Kts1HqYyW+eTAC7RtFWfp
         7a2/y91k1a4TOdRyv0ku4+k5WPfLYWI9fzeY00nxeOwMHyazHr1IeoXvYcFw3g6hg+6o
         hhggPf7b5hBDInqrxvMcg/WgYaBSN5n0VZ6EkDHjyBEoc8sITrYfD3aALdzsj/Vp/eVt
         npENhQ8uIENYKafqNO1Qzm9UdVoiIU90XN1XXK9GLuju/ZAT7KBRuhB8WU3JaBaSlgYc
         W1nQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQT4EGH9U+25RmB7ncBDOqa7c80LRvEvqR+YNR3csn1QY+XozI9+GfufbZrGRqFBnyg3pmCfkm2HQ6@vger.kernel.org
X-Gm-Message-State: AFq9FYLAAyO/Kv5+11wWaDD/y/nXLeSmgj6OS6DDKCSBi5tXgU81BpMT
	Yu5Ev1De4giY/u6rSZpQrQ7/WRX+TXutDWhwRVcs+DdoCe689qaZXMvp
X-Gm-Gg: AYBFou04phYyyoCRLtEZMaUZK1a7WmugvAcH6+UVh5WKW3FuDsCJe+sp1usbpzkXsFi
	MbLhWuNB7lFDtjCPk11Y6pIUBwWipbZr3+5XaIHbxjw+GT+Lg4Ar1svAsFDlIJ3In8IcKa8F4iI
	8EvSgfB1VgAQ0bd8Hin8BY9VffkA/Ucof/t/3+tbHAf5eDZI6fNv56C2/fEjJ7/nkm9W7REZQHZ
	eRABRGPyhWRIsfCYIgp+f04xTNPS1NYua92E/JhVR5nL7Vk1Yf2cIk1xGIhhQ8jbtlO/5qdEKA+
	6wscVzGDYzoAxszntztP0my0iKPYtAdMS8+Hci66wgpHTxanne2dJdz7Bm1hQE+9Fa+DK35a0E6
	xGFUTkR0Ri3HxHlP3tw7Qx9kZ9Vqszijelhq8/Xlb8U1bPB0meI2Nsq/j8OrL2N4uoCtniWlPgF
	egyqFATGCZaWRwu4vvozBrXk0eEc6i8AVymx3n4NDyjgTo/EIK+AwhraFFrjhcbCUlqYKLi3jN7
	yith4H0+P2xFwAqN8y15LYOFJCN19fnKWBRiSCO26Lw
X-Received: by 2002:ac8:5d8d:0:b0:532:d6bd:1b3b with SMTP id d75a77b69052e-5359fbb3ad8mr327227621cf.52.1792058112058;
        Thu, 15 Oct 2026 02:55:12 -0700 (PDT)
Received: from [192.168.60.5] ([207.115.103.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361269f364sm21663911cf.2.2026.10.15.02.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 02:55:11 -0700 (PDT)
Message-ID: <2df90a2a-770b-4439-9d01-bd8105084719@gmail.com>
Date: Thu, 15 Oct 2026 17:55:07 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3] platform/x86: panasonic-laptop: Add
 platform_profile support
To: Wu Zhipeng <zepwu@foxmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>
References: <20261007190446.38862-1-alexyeo362@gmail.com>
 <tencent_7F39F02728B55CE3B1878AAB51BAA0FE2D07@qq.com>
Content-Language: en-US
From: Alex Yeo <alexyeo362@gmail.com>
In-Reply-To: <tencent_7F39F02728B55CE3B1878AAB51BAA0FE2D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wu,

Thanks for testing the patch on a CF-SV1.
While the fan curve was observed to change, it is interesting to note 
that the CPU wattage appears to stay the same after an unlock.

Based on the data, pkg max temp is a bit low which does indicate the 
possible presence of a firmware level power limit.

If you do find the time to test,
may I ask if you have thermal and power data when running Windows?

Initial observations that have resulted in the creation of this patch 
series were made with a power meter (can be a watt meter from the wall 
or a watt meter from a USB-C PD monitor).

On the SR4, maximum on Linux was around 42W, while Windows had spikes 
that went up to ~60W (on the AC charger) or ~80W on a 100W USB-C PD 
charger. (in addition to the higher CPU temps with all settings on both 
Windows and Panasonic utilities set to performance)

Application of this patch on Linux with TLP set to performance resulted 
in similar observations when testing.

Additionally, may I ask if you have tested to see if thermald affects 
the fan or power setting?

Running it once in my case with the defaults has resulted in power being 
unlocked until next reboot. This change can be observed with both 
turbostat and a watt meter when plugged in.

The DMI quirk code is appreciated but I'd like to clarify the power 
unlock part first before including it.
