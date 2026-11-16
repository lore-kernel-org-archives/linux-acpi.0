Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849174;
	b=pMUq9N+WUlE88AdL2GfaBtCy7Ai1oXTvhAUiBXEYctgokEk8ayQLwrk0V8CcCgJnzHfJ
	 eu/TD0+0ZJsdvU9/qcajZGUjEr9H+KGj7gbbjgA2OZPN+Oy+6+NkbmbylTRMaDNLfu1YV
	 PoN3PqNiKOgHhDz58xBWxL0TVxyNVEQOh7WMYPAHr8i+Z8A8s/lAfBEmNmbiwuE2wJsFZ
	 Qn4rCQua0xX2Jn4nU7m7UoqaA4P4y0zIeVgY1zeZCYxmWDWxCTcWC0fkjntwOn9T7wDSY
	 OvBI1TvTwqMr1ytl98RTRGxy3mXlwEBlt2fGjX00Ga6RO3fbLJjt/oXV/gpABuzirOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849174;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ND6MCiJs7gVtLtVEYGeGji4z+whT+xiFpU4NkGoFN1U=;
	b=PDunY9XWWQ836oJWUYI9md5BUtOYnZFUA+rMn15Y4r499x5vNmSIO151Yap2nEn4YRxx
	 k1AYhF5gdOWiFP/IKVTB4NU6gdFjc7UcggF+xkuP7qxn+gCRVBzTlUak3AFuOCwVBt8s6
	 VRe3HgNFNBkm2n8vbx9UJis+SBN/KD9lObjwYj00FPTUH4wkeajcA8FpZOjzk2MT/1i9L
	 bF31lewnJZWqZzyGvcuXWJIaICgWg2K99UiI4EV2pk/M/4j8Shnhg9Tl7eGyAhUmNTfXT
	 eMUn6A4XVFQmt9HZF1MmCcZFml4A+5csxbUmvG5jm0+h9b9lExHdIUauKEeTA9eT5wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4c357ey;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D3Fk5c7l;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F361606A337
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 17:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F361606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4c357ey;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=D3Fk5c7l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794849170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ND6MCiJs7gVtLtVEYGeGji4z+whT+xiFpU4NkGoFN1U=;
	b=F4c357eyZMyXP/UMEu653zKsFyb8PybU1JnViyC9CC0D0jqdcFEKBW9pWnG4OjCwgBvbbY
	iJ7Pi9KctpCk4YseCv2zye82vspsvy65r076yFMjfB6eRT1zM4Psgy9uNt9SmJfyGaZQ3z
	TIjlWlq7MZ5t/xBGEgPDZLOaA6MHLdQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-R-ahnDJ8Oqufy2NqAOVeqw-1; Mon, 16 Nov 2026 12:12:48 -0500
X-MC-Unique: R-ahnDJ8Oqufy2NqAOVeqw-1
X-Mimecast-MFC-AGG-ID: R-ahnDJ8Oqufy2NqAOVeqw_1794849167
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb66fc3aa6so18487285e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794849167; x=1795453967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ND6MCiJs7gVtLtVEYGeGji4z+whT+xiFpU4NkGoFN1U=;
        b=D3Fk5c7l6VjK/qUkqONm/a+t4xd5potOFEOUoLKPIiy7eyVMImHaiKaXITcScN+7/Q
         vTQ5GFsHjY0zZG+X568mauTZbf44Bqjy+yx4m6auYW/uQAqf5hKEsujKhA99mwhymodq
         96zOTX7AoOKDjBeq/u/a1EkfzsLOYVZU9LYu+zqzOD1qBJa+QMHmNfZfGAQZ0yvBJg7+
         rOcojbfBOXwz45V0lka0TfyOTPSDnioM8B1vR6ENT4wdsS5CchYcQV2BW12ka0B9IfpW
         KCU+YqZq0azWuY0YHsWFOf6kmnpc/thByH3t+UIKLBP8C/VOLS8ynGoGmwhlHRTPBUy1
         +zUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849167; x=1795453967;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ND6MCiJs7gVtLtVEYGeGji4z+whT+xiFpU4NkGoFN1U=;
        b=eknuUfqUfEngs6r/PqJMsFI0hdYDTkwT6uMmsa4u4H7NKs1sMAy3CyILzLPcl2FyDV
         dd4oAaHpLopFe+GhHo3tzJmvVCwk3JUpWxMJP7dcGZlalBNxvU3nyW/0+HRBQkP9uBZQ
         GIImVF9xIK7IL76vQuRa3xOykDkkHXPwTu66TpTbf6l5xXq21AN+S1RaffwdI4ep4imK
         Kxul6Q1rfXr6EjHWUI9arg7D4wJE4UF0XLcKEWWmxQYfeP7kO/yVVjAjUfFLDz6t0kZO
         Az6u4Dgr7EK+lWotYPcZtE0YHt5zHb30J94gtXZQ5vKqKDB1Zj8EgfbtGaUJxTf7yDHb
         geBg==
X-Forwarded-Encrypted: i=1; AL+hErFXqjxoa+HZGLGUoqQvAWJfEjPAg80/VVJtnDgsYARE2GO7QvKwmIpDez2/+F2kp/6zrvOwbvALpktF@vger.kernel.org
X-Gm-Message-State: APuU4Z/uoaNOyZUCXgLeN0XrHODooMnjLVtB/NJYoVMeaJrx6ZV9k3SO
	TjeLhN2T6lulko9gVDVooWJ/3SiyWKrEisnUOwST44yWefQFLM5A5OigxwP5cqlK/qndxyL0wPq
	N1o9xqNTC6vfMmK/muCh7Y94CPqziZrcxpYCW48hWbUp5ZnauD3bykPN7iriBNfs=
X-Gm-Gg: AYBFou2YLLdOanUcYcx70BvnbDk7PaDjC7HfZ9eAe/w7kr5VX9YBq6M1N0dGnyB2OYD
	qQYjdBpn3DOomoPlfkOU9qtbOhiUEXh1I6B1Uswrb3oz0YEOt9IKZhv6op/rC9DnChICr9X834S
	kagDTpw/PXHTbb0425lebPy0FNxFIK2n2fWRwGxxaztNESWPrFWXJ5Vi8IntWGCF4DCgtmLVNRP
	VGMJIkibo4t7/Gt9HPFJJom0ujGjgoieDydEy4fM7ImKqVn8cjyyRAPnXhDJvkzanZgdnBvES/d
	ix5uNjhGBR68nbUJnuz67Z6q8J8uUsldLO+MNH2uZClOqd0iCM92+sn/Po9HgoYbEXnJtNFSRaN
	6jBFr9QY4JbNQj9R7XmTRiSNTMgJ+NI3/DgnciKAfWw==
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr158546595e9.14.1794849167292;
        Mon, 16 Nov 2026 09:12:47 -0800 (PST)
X-Received: by 2002:a05:600c:e555:20b0:4ba:761:97a1 with SMTP id 5b1f17b1804b1-4bb55a50f1cmr158546165e9.14.1794849166849;
        Mon, 16 Nov 2026 09:12:46 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7813fa23sm7270025e9.2.2026.11.16.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:12:45 -0800 (PST)
Date: Mon, 16 Nov 2026 12:12:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Ott <seott@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Fiona Ebner <f.ebner@proxmox.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC] Unrevert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <20261116121123-mutt-send-email-mst@kernel.org>
References: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com>

On Mon, Nov 16, 2026 at 05:52:23PM +0100, Sebastian Ott wrote:
> Hej Folks,
> 
> using ACPI PCI hotplug with qemu on ARM for a device with a
> BAR > 2M fails because of a resource allocation failure in the
> guest kernel.
> 
> Without ACPI hotplug the same usecase works because the native
> PCIe hotplug controller would increase the resource window of
> the parent PCI bus.
> 
> X86 shows the same behavior but default resource window sizes
> are different and qemu can use ACPI DSM #5 to hint the guest
> to keep larger (predefined) resource windows.
> 
> Efforts to adapt that behavior in qemu on ARM failed [1]
> because they've caused regressions elsewhere and maintainers
> thought that Linux hotplug controller should be changed.
> 
> But this also has been tried before:
> 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> 
> Unfortunately that led to regressions as well [2] and the patch was
> reverted:
> 5df12742b7e3 ("Revert "PCI: acpiphp: Reassign resources on bridge if necessary"")
> 
> I've tried the reproducer mentioned in [2] using recent kernels for a
> couple 1000 times and didn't ran into issues.
> 
> Could we give this patch another shot? Or does someone have another idea
> on how to make ACPI PCI hotplug work with large BARs without breaking
> something else.
> 
> [1] https://lore.kernel.org/qemu-arm/0de640a2-8807-69cf-4429-672263e3e759@redhat.com/
> [2]
> https://lore.kernel.org/all/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com/
> 
> Thanks,
> Sebastian

Why would trying the same thing again lead to a different outcome?
At a minimum, I'd expect an explanation what changed.

-- 
MST

