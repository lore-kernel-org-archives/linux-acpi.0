Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFD38F658
	for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458398; cv=none; b=PGFoxEDJS3Zjf5OC64I+cXIKc1IlcCQ2BeBey07YGhZLlSKbSZuOOjJ8beX+Qfy/Jpy1N2TSmTwIMjCc3ZKYYO360zH/5bjcskcTUpjV+PKjhT/BFBsCxTQkWdzsOT0IL5Cp5kqvRqjjn7Q6Vb2fahlRKMQ1mJAPAu+XqJSbfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458398; c=relaxed/simple;
	bh=7a3PA//x3G41UfQaAOXFMnSu1jAl9E2CW/KLlWdbgLk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:
	 References:Subject; b=OLWdc7QwjO/Tg+tdKQF+8XrYtmid21uJzwYYrKk+Ycy9vBnXE5wf97XBcyB4giwMOiH3op9ZF3dmJxkSiPNYt8+io4WyhmcHAnK+5051gFVDqTkBbyZPLatZ5n8ks3/8CDmTgipc9Dckw8N0VCDEteOm5pUxoZ3xEO0du8Fcw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvHVRn+s; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvHVRn+s"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49266a8770aso2974945e9.0
        for <linux-acpi@vger.kernel.org>; Sun, 19 Jul 2026 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784458395; x=1785063195; darn=vger.kernel.org;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7a3PA//x3G41UfQaAOXFMnSu1jAl9E2CW/KLlWdbgLk=;
        b=cvHVRn+suAX8Vs2nbqVuSRZVAxU/2eGHB62xQQ9T1nar2UVFTjtxn8u+sYVKAufeV+
         H08YlmK2okFlbS+knZ/7NgeSdDbTdNfqAYlflV1qDPmnLBOtKFehH8EkI6lKLr2RqiUG
         UjhU2vaV8DV0IAeMK2jpyewmjQUua9/OBiSpEPQDa/f5XmNpB4vtTrO6vzMo8W/VgcxZ
         KRP3IqD8SIkiWmwXa4YULeq4adYzigtIjuCwK2IW2FO3HBMwPA/tklw4b1QYbwIWsI39
         VGLqUX96ZcEXoTRVRfbZJdSoSI/VcWegVt2JoRSFRCKQS3jg0Nl/e8Aa4UIW4yefEI9V
         phjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458395; x=1785063195;
        h=subject:references:in-reply-to:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7a3PA//x3G41UfQaAOXFMnSu1jAl9E2CW/KLlWdbgLk=;
        b=ft0ya8Y1Tg0HWN6orIb4gwnOlTs2ttk5xsJ0mtokudziurokVC0W4cgx041hBof40h
         HaT6XOJTRzCyJU2l3jDwXrWwHhoG7fz0TOcCqd/ZybLCycYj/ULlnqtpQ3Pz+v9i3afZ
         npF3Q6EP77HQansyx7vkyV6rsYI39v5w/o1fdkNoXuJ0ZDl9iwk0cCWPNc1VwInD7hbD
         IbW+jWRsSUmQ+XhbuVDENQSKDuBIdJ7OW3o0YGfoUIc5XD2ryL+0Xug0iQBrZOz8WMLq
         uP+vtQJuB5rhkKu+X+lX6hCwfhv4WMa3CMhH/elvG76or9UP7+SBOS8jGQNBXXqaUXqj
         K8ig==
X-Forwarded-Encrypted: i=1; AHgh+Rr9FHyDTjweUR2yPXnH29yaskBwCNddZyYumMG5V4Id5b/XiU/daj+CWzf84c4KzissotMKyzsfIITb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywawwktj+NExs3YTajGONcFJsBfzD9ANnhFmZYAoFKetTKaSB3/
	NM/uBJbUbRymZMkW8/ZXPiNQk909ja6seCkyG0PC0BP5j88agqtEUGmq
X-Gm-Gg: AfdE7cnnrwQ+sTZmk8IZjcJ+10JnaWK0oz/27rxSo6SSPJSo3IPZUyObXHZXepUWTIS
	5n5UzdmRCRbUd82yec8hvqLUJrKsoBukV9jYdiLP0GjcNT0mnEy+g98a4OT4FdltOxns1vvjZOV
	XHyJaHgMb0wVo+WhS5tUYX5EPrNdatRZYrG7E8PtxkCn4x+u7KNLUhlCOnkHI47acDC9/gT94zs
	Cj0KLjbqUwC8tX/mwwWKUGMmVMlIrzhVZL37zXMvG+7v2T1Ayv2MwxOe3G/Q6xEdZOVImwCKOmo
	8TjBPqf/vlqMGPRfr4OJMswuSzcJebkudv0m/TnxDlOIJOMfJixGptiFlUCjVBYICgUZW1rRgAB
	t0jyeNMfWKtllp3S7Aus4xBQGkwOgCKDfIXAncxsEICHXcLF10MZaXPLkluFVPYySTZXmH3tCA1
	hVeWg7Luygzzc5lw==
X-Received: by 2002:a05:600c:548a:b0:492:6e72:eee with SMTP id 5b1f17b1804b1-4954a50b65amr56505845e9.3.1784458394960;
        Sun, 19 Jul 2026 03:53:14 -0700 (PDT)
Received: from [127.0.1.1] ([95.70.199.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm141919705e9.1.2026.07.19.03.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:14 -0700 (PDT)
Message-ID: <6a5cac9a.b39440a8.65068.2953@mx.google.com>
Date: Sun, 19 Jul 2026 03:53:14 -0700 (PDT)
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
In-Reply-To: <2026071828-blunt-survivor-834f@gregkh>
References: <2026071828-blunt-survivor-834f@gregkh>
Subject: =?utf-8?q?Re=3A_=5BPATCH_2/4=5D_drivers/misc=3A_add_Goodix_GXFP5130_eSPI_fin?=
 =?utf-8?q?gerprint_sensor_driver?=

T24gU2F0LCBKdWwgMTgsIDIwMjYgYXQgMTE6MDk6NDNBTSArMDIwMCwgR3JlZyBLSCB3cm90ZToK
PiBXaHkgYWRkIHRoaXMgZXh0cmEgbGluZT8KPiBTYW1lIGhlcmUsIHdoeSB0aGUgZXh0cmEgbGlu
ZT8KClNjcmlwdCBhcnRpZmFjdCDigJQgdGhlIHBhdGNoIGdlbmVyYXRpb24gc2NyaXB0IGFkZGVk
IGEgc3B1cmlvdXMgYmxhbmsKbGluZSBiZWZvcmUgYm90aCB0aGUgc291cmNlIGFuZCBvYmogZW50
cmllcy4gV2lsbCBmaXggaW4gdjIuCgo+IFBsZWFzZSBkbyBub3Qgcm9sbCB5b3VyIG93biB0cmFj
aW5nIGZ1bmN0aW9ucywgdXNlIHRoZSBpbi1rZXJuZWwgb25lcwo+IGluc3RlYWQuCgpBZ3JlZWQu
IFRoZSBlbnRpcmUgZ3hmcF90cmFjZSBtb2R1bGUgd2lsbCBiZSByZW1vdmVkIGluIHYyIGFuZCBy
ZXBsYWNlZAp3aXRoIGRldl9kYmcoKSBjYWxscyB0aHJvdWdob3V0LCB3aGljaCBpbnRlZ3JhdGUg
d2l0aCB0aGUga2VybmVsJ3MKZHluYW1pYyBkZWJ1ZyBpbmZyYXN0cnVjdHVyZS4KClRoYW5rcywK
TWV0ZWhhbiBHw7xuZW4=

