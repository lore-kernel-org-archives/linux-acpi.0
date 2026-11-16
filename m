Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852688;
	b=5sjN0xXP9ycH7E3CasMoCCoLWFGMmFYl4IWeMz3Y3oL4mwuK29+lUlx+C1Cbs6K2PuOR
	 Pei9qU5vCy+s/lc79yDp7V9cbT38Vw7edNp288dNPIpGmMrYV/mf4LjGV4/8I+L4mIT4c
	 SD5BMS3q4WQJgwHLXwwg8EgwjCM5EiKe1uF3VxpEhtB4n8/tLaWdTFL4Lv6HWq4qLSFTU
	 w6smGxxuGmxcLQ0+Zch3Fl2IjRDhAahnQnK+pJS4olPm4YeRZOgEbVUKBXj8SnY7If6cJ
	 Vg2eu8ysnjNJQ0yQBIIeR7wQq1G7ksEkZFSAv36Yg/pKeHTNSMkfsqmyzK0FrRjT/kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852688;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
	b=KiW110AIZSWHSR341K+MtPph2u/24iC9Yz2lKf04f6q4/ngk2Lz68xzVMj9fMF9ODkub
	 TkN6hjBuZGvsELbRth4/0wxpmCtQVnT1UySuQ59vch8QAzHlt/R9p5u00ZRc7nv0WLcPf
	 8T4tYr1lt3tZKiWCB/z02FtBfenwCmJSczhsVNT4Ll2Ghiaw5pq6hX2prMV937AOzsstf
	 xil9tphKPYP+zEGAlrH0zmx3ZfZQCgaIkIAxqzZgbY4iBzCh0p8PyfK8A2FoXZ0UiPBhr
	 qoRYpKMRTn/J4e/eGUpE8StY8ypBTAhO5FeMlqGty/A+3ZbA706rNlblWXGF0wtpfFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ajwl/Ojj";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TVZ6sfEX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3C606A329
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 18:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B3C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ajwl/Ojj;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TVZ6sfEX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794852686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
	b=Ajwl/OjjU5CmBV2ebqc5nd8B3NwdIZUk3pBbEdH/nXSz5T5A/wvuJ73FJUEw5KBQK+x/+Z
	takwPZu9iQZDEOc6y8reYr7KIQErkFkIn5wT9ffdJ7tTd3r1VI1QZXsIfOoPWoOZigKxy/
	83BDxVPOOzZ8sabO3s7HI5EVT24Khp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-RVG8tasvOSWfIbAputKjVQ-1; Mon, 16 Nov 2026 13:11:24 -0500
X-MC-Unique: RVG8tasvOSWfIbAputKjVQ-1
X-Mimecast-MFC-AGG-ID: RVG8tasvOSWfIbAputKjVQ_1794852683
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49d8ce126f6so2325364f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794852683; x=1795457483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
        b=TVZ6sfEXCiZZMnkVHVsfBCoMNa24jRM6/8XKC7Etpi4QiTOZthuZrBAfCt1u7i9vqZ
         Xhis0lDO+/BLOLmamYdKkaj6qtG1L/fOtvgoLOhdbcU+CmrC8H69tHkyEl8t+qGaQmud
         PRhLL6W6jKdPI0PiAb1iJOJSVRCaSJZONJjdHk/y3RVagk8oWiFkvMsHoPXhfLLFWR2b
         Tlr+WIz8NkZtWP0jWnGsh6tOFhMqcRmrLj2AlOtVmZWfw0wTVw/9SnAjYbR1UiSppTwT
         yVB7JovPdhNrIHh0PujhIfBQmp/T6/DvyMiLNb5TleZOpO8qxDeEKffBqc2dOcYl7PZZ
         DteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852683; x=1795457483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKsoUNhu4YSb5FTN/5GjXyEK3SxZsgadI5bR2g5138A=;
        b=L/WH+lAWCy2c844Csuq8JQ3/oKQUSAEg5YAKvdY+X5DoyCKY4EK2sGhij1U7dbkub9
         j9vjrBPbnBN424NT6F6nSCJT4jRbbEUip55tJjo8aOJP4rQE4wmlI0YiwgZTYVo9VREq
         9wka6A9QTWAN6RQVyOj9ddUqO3EtN/bPpq/axs3W5PbOyPsNQanthLNbOl3/pxwo3LGs
         bNXPkfqrFtnrQ4y4wEn/MIUP3OTLZG7Yw6i3WxII9KtOOt1YCRFnLQgonA9HG+ofQVpI
         oSGOpOWFq2tDptmHbnSvwTeC3NWCLX2TWviTFWwdUQeOgKnhSvxjcAH2+Q5L01gt9zwQ
         RygA==
X-Forwarded-Encrypted: i=1; AL+hErGAPylGN4/XgnvbVyVGomVp4PWbcJTV7olqgBkl63htqTVA/lVuhN12YlcpATzBoYj2TNXPaR1yFZGv@vger.kernel.org
X-Gm-Message-State: APuU4Z9z18w9hPZr8/Phhod2yxdUEAP4V0uQYOODytsx1Tr34haOl4lc
	9+hckoFmuleIzEvNoq54gvlO19JfvrQEuN0Ly+FPZHLU3ygWA7EGCK1OpekkPqwfVyAucTI/b3E
	fyrHYnlALKOZZ6n8bVz2X7ndpQsLINlBZl7Ow6RYFlZcr62+GQTOgQWX1EmzbgrE=
X-Gm-Gg: AZFdTZe8u8mMjhZEJUFfLWcz6uLvpDXAXbLLi15t5VdITkcnudCzJ1eL1Id4/LKg0KL
	Cv5HuSPZuuxlWIg4/fuYu3j5/sIFMq+3pk8x81m90V8VtbhHUF63B4ILPEmgVdba7f6q5KflcSc
	93ivkbneduxq98MOb8z3SOat6k5fEPSpjEtOWeHMrJ6dJLxiGfUFdW4w0/0RRDNxrsRbd7tMYVG
	1Pdz9MZfgTfkImfM7oAMdSJ+qvzJUApI014XqIW+pyb1NhLv08yXkjlmf6ibulGODlTh8YRif7Q
	3TPv7qo/AHn//htDauu/xYBButgqdvv+GZ0SFKdugAi8pu5bCPna7u2stKOSISQVR5qlZBOu2Vq
	uQjbYIzATzT/34xgOvOlwA407YGiNUX951FOumGbIAg==
X-Received: by 2002:a5d:59c9:0:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-49c72ba7408mr23907879f8f.52.1794852682843;
        Mon, 16 Nov 2026 10:11:22 -0800 (PST)
X-Received: by 2002:a5d:59c9:0:b0:491:68e2:bf2f with SMTP id ffacd0b85a97d-49c72ba7408mr23907826f8f.52.1794852682303;
        Mon, 16 Nov 2026 10:11:22 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:151e:a200:7a96:1b15:81f:ebed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c6451sm25043648f8f.45.2026.11.16.10.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:11:21 -0800 (PST)
Date: Mon, 16 Nov 2026 13:11:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Ott <seott@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Fiona Ebner <f.ebner@proxmox.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC] Unrevert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <20261116131025-mutt-send-email-mst@kernel.org>
References: <c7f58d1f-3dd6-1456-31bf-7b62641c6e5c@redhat.com>
 <20261116121123-mutt-send-email-mst@kernel.org>
 <b59dadbc-035c-0a70-8947-bb0123bd5021@redhat.com>
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
In-Reply-To: <b59dadbc-035c-0a70-8947-bb0123bd5021@redhat.com>

On Mon, Nov 16, 2026 at 07:03:23PM +0100, Sebastian Ott wrote:
> On Mon, 16 Nov 2026, Michael S. Tsirkin wrote:
> > On Mon, Nov 16, 2026 at 05:52:23PM +0100, Sebastian Ott wrote:
> > > Hej Folks,
> > > 
> > > using ACPI PCI hotplug with qemu on ARM for a device with a
> > > BAR > 2M fails because of a resource allocation failure in the
> > > guest kernel.
> > > 
> > > Without ACPI hotplug the same usecase works because the native
> > > PCIe hotplug controller would increase the resource window of
> > > the parent PCI bus.
> > > 
> > > X86 shows the same behavior but default resource window sizes
> > > are different and qemu can use ACPI DSM #5 to hint the guest
> > > to keep larger (predefined) resource windows.
> > > 
> > > Efforts to adapt that behavior in qemu on ARM failed [1]
> > > because they've caused regressions elsewhere and maintainers
> > > thought that Linux hotplug controller should be changed.
> > > 
> > > But this also has been tried before:
> > > 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > > 
> > > Unfortunately that led to regressions as well [2] and the patch was
> > > reverted:
> > > 5df12742b7e3 ("Revert "PCI: acpiphp: Reassign resources on bridge if necessary"")
> > > 
> > > I've tried the reproducer mentioned in [2] using recent kernels for a
> > > couple 1000 times and didn't ran into issues.
> > > 
> > > Could we give this patch another shot? Or does someone have another idea
> > > on how to make ACPI PCI hotplug work with large BARs without breaking
> > > something else.
> > > 
> > > [1] https://lore.kernel.org/qemu-arm/0de640a2-8807-69cf-4429-672263e3e759@redhat.com/
> > > [2]
> > > https://lore.kernel.org/all/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com/
> > > 
> > > Thanks,
> > > Sebastian
> > 
> > Why would trying the same thing again lead to a different outcome?
> > At a minimum, I'd expect an explanation what changed.
> 
> I couldn't reproduce the reported issue with scsi hotplug on recent
> kernels. I have not done a bisect though since I couldn't even build
> the kernel for which the issue was initially reported with recent
> toolchain. So I can't answer what exactly made the issue go away.
> 
> Sebastian

Try reposting and including info on what testing you did.

-- 
MST

