Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852231;
	b=H6Rz3JMTJKMmOjiWPB+DZObSqGk3OBwHXsiufnkvXW6wjUfUNbS5ykNyWzptCC7VjUM+
	 OKOHz0fI1z0jgGORSvOiBL/DncNPd5wloSA2o9EER6SYRkDd1xy09lGjKIuerRGdpZMxZ
	 ppPYCAPRns0zGhgNNWR9zcbEWoScyFwQOkiLvcJfRc/4r3gP7pw9VnjNIfSvxy+FqKu3h
	 cZsYi1Ozz/wjUW4c+OPQ80AlmMCDOoepdgsye6MkqUwLJmeesuNF0lIz/bf73DQFE1x2q
	 BEv7J1s+7UuJwaYOkHorrV6nkbXdXqNIjf4pVK37cW0c+o7HEYrDwqRf1Y1pjX43bGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852231;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type;
	bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
	b=DnlFiS0K7BoOU22KCAiD2RICuLxL04abXvPpYylkHqm8IGZKBD68u6ml0ki9tLnX+BnZ
	 qrtwVyAio04Z0Tc07w6CyRHPzxAl8ZNsbzC7rEQIUshH89IQq4ehIY6hzGSQh4dkxFk6A
	 S3dcU4dCf87xoHzs/jA2gJm1+oc27HF12WBpBJhnky4BiyDHAaZxdz5ui5VkPUx/Dldmc
	 wyVEgp0VHSTIsVYPKr2XD0Q8QDEx0/GK2ZizoqWvsoojdHB0mDGQTj/CQ6ZuZU8wRy1JN
	 cPWR0eeC1zmStmHdnDtPrDeSyfB/M9L5QcKPfA5EIQlNRwZDgDQLcSN606kyUX8+eLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSpRFd9E;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=brGP6Ba7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606E606A322
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 18:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5606E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LSpRFd9E;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=brGP6Ba7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794852229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
	b=LSpRFd9Exb2x5J87hQYhdE6D5OPVFXYmFIEzR4Gy0KehUklkwgqXOmdVIY3aRoEitHbE0p
	Pcjm32aEVs4zJMYWg2b1ROoT3QrpqYTKUeN7WvoxSRP+flgsPgcaP8TYZ/m0EDzcKje6Mv
	UawLsFjlbCfj0JkA5uKyizWGbkfuD38=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-q7lBxstaMr2wLAf7PPqq6A-1; Mon, 16 Nov 2026 13:03:26 -0500
X-MC-Unique: q7lBxstaMr2wLAf7PPqq6A-1
X-Mimecast-MFC-AGG-ID: q7lBxstaMr2wLAf7PPqq6A_1794852206
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso16232855e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794852205; x=1795457005; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
        b=brGP6Ba7PSOK+rJmlZw4V7dx2J/TaHAtgZ43pfjitPEKar5AdDJXCPHn3t7Vqpjcl9
         okXjyzVE+P/RcveEr6oDahHraSA+k9VvDKt8eC1jIhqbq+mCSXsyH8at8DnsuwB2RsiA
         3sXAmAYmwfD8T41ZJEqDCHjb5lUdHTpXnrERaP8iKuSXOS/rIa1VgLsGrL5iyN/JjHts
         c/J6UnNcl708YDawZ+caL+J3P6K6Ksbwbo7lL3W3KKg43PA95RYMHIY46Y1Xb+NHL8UK
         ezacZY7boIcgWRIpbEPCAj7KK8Zdb5LdB7xmNQrn4VnVGKC6AobBytdM5Lx5P+KgENJ7
         4L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852205; x=1795457005;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ME+tq2h4VrXHL0j3HMmUrv6ccZFFxfaadCJgOtMkU34=;
        b=uPdr1XgvOT16pGeHvVAX59oRZgWNHIQ6xzFiZLGjHCeRW3cmbCy3iZw/ONwf7OGKM3
         aHytcZUC9rLfvZwsbz7UwdY5osrF1Gk/IVApoFq5NZXBBuzsp9gB5h9KVTAbND+5DAiV
         UEztyL/npY1CxN0sTyIbSYvvDxEjYeuJBxTZMmPEEGBUIH3/xZ1fEvOFcROH5gkdGHNb
         UAgIWDKHfv7cmr9KIuPYmwx5zfiOy9AAL2GewZpywpMk7O8inJ6BA2fP7PGlL6mJGonZ
         uRlkVS7BgcgDaS31iJql7OJ7BIzri+tRXSjTR4gV8blMoYXyartbp7UB9a9Qn489eEXo
         Xorw==
X-Forwarded-Encrypted: i=1; AL+hErFS2fAzjeg4akoNbWaU1ny2f5c47CzjAyA3+MORnZgSpMRsa9RQ7MvjHcoU6A7ZoKQNvzvGpRJ6Xe3N@vger.kernel.org
X-Gm-Message-State: APuU4Z8R5KpNcJ1z4IsyxBEaMXuyUVh1gVxy+QIWMWsHLtaAK9IzgmPr
	xwE+NQqPdTQKOZlMxCIoyTgEmIiRUbxVP3b6Js92dAVRteAWtmvcU+6eMgo0fU3Oz280ZjXEZJW
	y+FLVcGil6yWlS9mAROU308Hl/ZfLU0p3QsFSOKDAkr4nssKBYLqvIkeuUN48UPg=
X-Gm-Gg: AYBFou0yRU9jMeWlnCVwtkGleAIsevHCzrhl6rF4MZoQtXxMXLgJG9da2SeTl0wv1oB
	cIskXidsygjvUNVjuAUBtHrnDv3qe7XY2XMNF3C9zWDHTTEph+HOz9cDVsK/ufKGbYuko2LDgi4
	KZkLM1CDkx41VAj+sjwsyH5YORvI7JQeukewc1pZBk7pppmsooYj+F8gw5JDK1NyscyqJr04FzQ
	c/4AjCHHhuztzc+io4GgpPcMKBC1DJGfJyBb8S3IVzUofH9pwnOdvGtJLPBjTpAaG0gd5Urf5Dd
	UkJCYL8OP+2QjmSojdQbhZpNtCdb3H27i+yeKQ9NcHpjfSSDIks9benFzpPVU76nG+DY8HJNagq
	pkg+IlAwDTxCLxIihJIvobtCQXYmoXG47qCiRwV7f5+wynMygZl2uvhyM1h7S8+6c4JpuRFXWab
	YQvhgxI82X7NrZVGRU9pM4KzjXsw1iVbhUX+mjBw==
X-Received: by 2002:a05:600c:8b65:b0:4bb:6a5a:783d with SMTP id 5b1f17b1804b1-4bb6a5a795dmr108705665e9.18.1794852205594;
        Mon, 16 Nov 2026 10:03:25 -0800 (PST)
X-Received: by 2002:a05:600c:8b65:b0:4bb:6a5a:783d with SMTP id 5b1f17b1804b1-4bb6a5a795dmr108705085e9.18.1794852205147;
        Mon, 16 Nov 2026 10:03:25 -0800 (PST)
Received: from seott-rh (p200300f6af3d8001f2fecaef96c12e29.dip0.t-ipconnect.de. [2003:f6:af3d:8001:f2fe:caef:96c1:2e29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm4126565e9.13.2026.11.16.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:03:24 -0800 (PST)
Date: Mon, 16 Nov 2026 19:03:23 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, Igor Mammedov <imammedo@redhat.com>, 
    Fiona Ebner <f.ebner@proxmox.com>, linux-acpi@vger.kernel.org, 
    linux-pci@vger.kernel.org
Subject: Re: [RFC] Unrevert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
In-Reply-To: <20261116121123-mutt-send-email-mst@kernel.org>
Message-ID: <b59dadbc-035c-0a70-8947-bb0123bd5021@redhat.com>
References: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com> <20261116121123-mutt-send-email-mst@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 16 Nov 2026, Michael S. Tsirkin wrote:
> On Mon, Nov 16, 2026 at 05:52:23PM +0100, Sebastian Ott wrote:
>> Hej Folks,
>>
>> using ACPI PCI hotplug with qemu on ARM for a device with a
>> BAR > 2M fails because of a resource allocation failure in the
>> guest kernel.
>>
>> Without ACPI hotplug the same usecase works because the native
>> PCIe hotplug controller would increase the resource window of
>> the parent PCI bus.
>>
>> X86 shows the same behavior but default resource window sizes
>> are different and qemu can use ACPI DSM #5 to hint the guest
>> to keep larger (predefined) resource windows.
>>
>> Efforts to adapt that behavior in qemu on ARM failed [1]
>> because they've caused regressions elsewhere and maintainers
>> thought that Linux hotplug controller should be changed.
>>
>> But this also has been tried before:
>> 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
>>
>> Unfortunately that led to regressions as well [2] and the patch was
>> reverted:
>> 5df12742b7e3 ("Revert "PCI: acpiphp: Reassign resources on bridge if necessary"")
>>
>> I've tried the reproducer mentioned in [2] using recent kernels for a
>> couple 1000 times and didn't ran into issues.
>>
>> Could we give this patch another shot? Or does someone have another idea
>> on how to make ACPI PCI hotplug work with large BARs without breaking
>> something else.
>>
>> [1] https://lore.kernel.org/qemu-arm/0de640a2-8807-69cf-4429-672263e3e759@redhat.com/
>> [2]
>> https://lore.kernel.org/all/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com/
>>
>> Thanks,
>> Sebastian
>
> Why would trying the same thing again lead to a different outcome?
> At a minimum, I'd expect an explanation what changed.

I couldn't reproduce the reported issue with scsi hotplug on recent
kernels. I have not done a bisect though since I couldn't even build
the kernel for which the issue was initially reported with recent
toolchain. So I can't answer what exactly made the issue go away.

Sebastian

