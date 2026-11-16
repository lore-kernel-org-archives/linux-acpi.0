Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847952;
	b=ZpOaQ7FEfDHpLsdAnhM9XE9v2s7zKFe/D+EXHgwNokCdbQI89uRZ5Zvc1g+s41sgnKCS
	 VkCK0+xE/DP7KYre4/735QofrrjcwTennNgc/3wQwXpAkmPrlnjTXHzPNoUk3/z56uAes
	 Z43SFB1Ik3UbVX5U+RGrtF53ysZnD5/KpaWswVu9K8FUvdMv1w6KqCNB7hdR2xCulExhv
	 w+NH8Emq5+cX/D9jNxo7Pgx4ai9n1KBvO3Xz1rXkUsXLeKhoEF2Jn1mQ3uRdCUofdECIq
	 88F2YpWjzKZY9ea3NTvu95zVzB2GCArzUoQVAmGUFUvZ6hHbATh988725IY3P7VoK7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847952;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:cc:Subject:Message-ID:MIME-Version:Content-Type;
	bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
	b=kqzQPDn9I1u2rDJ06r82yXRQAK7FW4g+JcS3Z2sY63VJSulLU50QyAkVzo/a46keYAUt
	 vgJxRlcLnK4JIX5gT5q24pdMKbq+FoWN+s5rPPBDYR5rk1Dcm6Cw4KztKnrvhpGYQVfp4
	 vVc4LclHi74UHZN4RjwHmprGfDeWeNoZXI/bYjdanStKxKGrmdqmbwygZUFRgbbDo/B6Q
	 IPyl4OBrgm7eOR1v0ZMu7FKocXPt/68WPPU21AJUdUIKvUR1zYRcC5kHX3hT4fV9EQqL9
	 YB4Rhubj1mu/YI0yqvquMgamjZE1UjNwWgE0GlSeYzCoejI0vhyzdh4xOkbIlrwc4+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FJXTzkTw;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9Bq3kgT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C51606A31C
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 16:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09C51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FJXTzkTw;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z9Bq3kgT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
	b=FJXTzkTwkbGi/96/r3L4Q4ywEV2YChHWqfWTMTuZz2S03B2qt78rmLXtj7OPxtJqh5yzHJ
	QNRHfrgbXuDz7INy0YVsAM0Bo7nvR3wKNrSNFyYASRiHPhZedu7gP5b0k0XzFxUljdzmw4
	/wfFZPbFzF1dDZrrQ/eQmKKA9bKSTZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-eTg5v2C7N1-VgE6yfwEBVA-1; Mon, 16 Nov 2026 11:52:28 -0500
X-MC-Unique: eTg5v2C7N1-VgE6yfwEBVA-1
X-Mimecast-MFC-AGG-ID: eTg5v2C7N1-VgE6yfwEBVA_1794847947
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso31283905e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794847947; x=1795452747; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
        b=Z9Bq3kgTw0DCa6pe676LPIqnNDt/9WjraZ8G8Xa+5UDdxR7RDHiETX7y0P0rXYvM/n
         H22ZSGbgsInFe4/12Hd67R4wKKFNrCCa9UwM5oQvzDLfDFD0uK6F8omJo+TGF12vrOMF
         g+p4oM4EE6sP9gtfCyRpjHU05O+sVCgFMUnGOng9wzueevjy0OYTfYd9gG60dq7OyDjs
         k1Ngq9rIYsvwDyzcVYH1N3NGwilFL6QEEjGkYeYcDgkwnS5I2gWfB1j7o8E/QdjKFTv9
         dWKqhBrlVlDGmmJws3Wt6VcJsljbwC29/kkRETWZC1mHZHfHczKk6NNMXyT7Abkp/Jsb
         Iufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847947; x=1795452747;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lkky0MHcMsr2IU399Y8ejtHfxWCRsa9hqZWRLib6U2A=;
        b=wHmc+cguXnGHxFomUlGnMMH9ZtoAIKm83A6PNpjh2nYNRp3wSdJ9CqMT7htDrFgp0N
         Zf4KNaVka4eVp8tGWDe9YbnqFXpI4uxTHvOZ+WMhjpm6s8EEjJI2ubSmCf/hbmDLL5JO
         5HIqg4ucu9WpDalXXH87x6BGTFjg5D9UjXDGE+6xdMzA6P7Lj6zOn9r3v7y4FiqrtenQ
         llAgABCBlBe+c05oTR2Rk0bi269AhhV4iv/muSla+efqerwT5UzQlh65ZoSIsdrTVYGU
         dLUxFFbMZyrO8vEPIRZJrY4FALH1VJFkEJsmpR5Y13ZDcQHzmdVFHBh1xGK0OfjRPGlF
         fN6Q==
X-Gm-Message-State: APuU4Z9ObmPlicke95EDBrOPotHRX53Dhej4YLMadD3l0JFkRHEN/vGF
	kR3mzeqTAqdP0ECom4RpENBvao+k873JXbTakfh9c1rGXMxkIvAVyqYLizt0B8jAUUfAFHeNjw+
	B8EmP/B13cKmJII8Lh/G1RVNPsE8YytbcSyH81a10ABsx8ORhE3nzCZFgcBEUshc=
X-Gm-Gg: AYBFou2TXC/pWNlVQmNuhouX3759p4rUqoDxNTVPEu3hJ+jRSO7wZ4iHfNUHCUu/kya
	NdLnGmJZOWuIs6hUXRgJPv/aerKj4H3PU0v51/YlTrh8HWBSnPG4feBBq9/Vw8pplUgfHlQe/Te
	kw/8TV+ZdxySFJc0QHzRRXfHbnl2kJF/Igz5opFkpdSC18twtKjCYPVUVuSAAUb10dCcK12mSZH
	r8+xHgZLZ9DxXoUAtm23rp3LLU5VycXjkOBHQqJTo5XtSSA5uvlqXtwGV+yPNB4TB7WZ20YJ3Qi
	7rHR22YjiKjYfDT4eL0aTkNaHDhBbrK+9CgixcXnRcWZRyyyTGKCoxlx/SnMFA+hkxI7n1zUuM3
	7FKfHbm+RMeWucm8c/kHeawjsjnUlMuH3RkLrgRHadPScF/gAY031yC1WczMxdQsusUbbJxhjHN
	CwxabTtE3Dh97qjpdSoifEJvxDIzCpzV5ShswX/g==
X-Received: by 2002:a05:600c:3509:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4bb559f3633mr216665815e9.1.1794847946740;
        Mon, 16 Nov 2026 08:52:26 -0800 (PST)
X-Received: by 2002:a05:600c:3509:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4bb559f3633mr216665155e9.1.1794847946032;
        Mon, 16 Nov 2026 08:52:26 -0800 (PST)
Received: from seott-rh (p200300f6af3d8001f2fecaef96c12e29.dip0.t-ipconnect.de. [2003:f6:af3d:8001:f2fe:caef:96c1:2e29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783965d4sm1390415e9.7.2026.11.16.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:52:24 -0800 (PST)
Date: Mon, 16 Nov 2026 17:52:23 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
    Igor Mammedov <imammedo@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC] Unrevert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hej Folks,

using ACPI PCI hotplug with qemu on ARM for a device with a
BAR > 2M fails because of a resource allocation failure in the
guest kernel.

Without ACPI hotplug the same usecase works because the native
PCIe hotplug controller would increase the resource window of
the parent PCI bus.

X86 shows the same behavior but default resource window sizes
are different and qemu can use ACPI DSM #5 to hint the guest
to keep larger (predefined) resource windows.

Efforts to adapt that behavior in qemu on ARM failed [1]
because they've caused regressions elsewhere and maintainers
thought that Linux hotplug controller should be changed.

But this also has been tried before:
40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")

Unfortunately that led to regressions as well [2] and the patch was
reverted:
5df12742b7e3 ("Revert "PCI: acpiphp: Reassign resources on bridge if necessary"")

I've tried the reproducer mentioned in [2] using recent kernels for a
couple 1000 times and didn't ran into issues.

Could we give this patch another shot? Or does someone have another idea
on how to make ACPI PCI hotplug work with large BARs without breaking
something else.

[1] https://lore.kernel.org/qemu-arm/0de640a2-8807-69cf-4429-672263e3e759@redhat.com/ 
[2] https://lore.kernel.org/all/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com/

Thanks,
Sebastian

