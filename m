Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283B390610
	for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116726; cv=none; b=XdmrvGaJyUn/wELj90qqNbwdOJ+C9qeALsfkEnRYshSuNgElx1f7HR9rvH6hCire3C7R05OInVCuyUG5z7hHkrkhiO6iI18HRf3nB27Yj3KSy3UW7ZiHB9kmMn4w6pQlzeCb+7KtzHzZpky0eZfQxRq/IAwh1uqE2ebsaIhX0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116726; c=relaxed/simple;
	bh=zDXSgmJ2tRAcpel25RDsriS/fscVsj1OaijNRM1kSN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=r2Caor9TtPEJ7z6gasshMF/gWecUnKS0LPN23z4CdL5kglAcccMQvqfB2PB8nSm18+Ju3f3SabcAwnIW0CLvuGyFTrpBY56HSsDixN0nQhD3vS2j8frEhWQv9FnOBI9wZIXwp2EPP/wAZdYB4X4LJkPGLnhE1a9GJylMkdQZQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEfsvQE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEfsvQE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C251F000E9;
	Mon, 22 Jun 2026 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782116723;
	bh=vqRfM+pLyxS0RQYI90CHqOpCF070Xi0CJ2klkY+U+yY=;
	h=Date:From:To:Cc:Subject;
	b=NEfsvQE1ATJY/gd22ssFZtN8bgZZei8fxsP0gB7zBXlJFjPl3AGO8npSJZdYJPQgD
	 P3oSzRSYWX9ImkAY7UQP4i68Xy/uRVn+oczC/mMIQwkKJnTeOFbjQqesM947jumFjU
	 QFH8xlt4jwNWzQRcGewsD8MxCXMUH61m7Wg3dWLxNdxCubRuNrUEzNFYe29yfxJmjz
	 ZGMehWwI3FC4AQBYrLYPI8LmzWN0g1zOrwTJigEF0U8DeihvQg76DaVj17Kp6LV4u1
	 a9vBbgsVniLkW4KYjNkAQ4q6hSBAQEwEO4ISmSUYuuoVTthAJYnTdGHtElRtSuCzTz
	 N9DZAqTJ29uyA==
Date: Mon, 22 Jun 2026 10:25:18 +0200
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: uswg@uefi.org
Cc: taoxiaofei@huawei.com, Mauro Carvalho Chehab <m.chehab@huawei.com>,
 linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 qemu-arm@nongnu.org, Dong Wei <Dong.Wei@arm.com>, Samer El-Haj-Mahmoud
 <Samer.El-Haj-Mahmoud@arm.com>
Subject: [RESEND] troubles with ARM processor type changes on UEFI 2.11
Message-ID: <20260622102518.0ad0e4de@foz.lan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

(as I got no answer, I'm resending it, c/c some ARM people as well)

Hi,

I maintain ACPI HEST support on QEMU and I'm one of the Linux kernel reviewers
for the RAS subsystem. I'm also the author and maintainer of Linux rasdaemon,
responsible to handle RAS reports (including from GHES) on Linux.

There is an incompatible change at UEFI 2.11 spec at Section N.2.4.4.1,
which, according with UEFI 2.11 changelog, it is related to this issue:

	2462 - Fix the Type mnemonic description in the ARM Processor Error Information Structure

This is the second time the specs changed the meaning of the type field
inside the ARM processor error info:

- Before UEFI 2.9A, the spec has a list of values for error type. 
  From the specs, type, at offset 4 was described as:
    
            - Cache error
            - TLB Error
            - Bus Error
            - Micro-architectural Error
            All other values are reserved
    
    Yet, there was no information about how this would be encoded.
    
- UEFI 2.9A defined the actual expected values as:
    
            - Bit 1 - Cache Error
            - Bit 2 - TLB Error
            - Bit 3 - Bus Error
            - Bit 4 - Micro-architectural Error
            All other values are reserved

    However, even being an incompatible change, the spec didn't change
    version field at Section N.2.4.4.1.

   Linux, QEMU, rasdaemon and likely several BIOS implementations
   were updated accordingly.

- UEFI 2.11 changed the definition to:

            - Bit 0 - Cache Error
            - Bit 1 - TLB Error
            - Bit 2 - Bus Error
            - Bit 3 - Micro-architectural Error
            All other values are reserved

  Again, another incompatible change and without changing the version
  field at Section N.2.4.4.1.

With the current mess, it is impossible for the OSPM (and RAS apps) to
properly map ARM processor error types, as for instance, type=2 can
mean:

	- Bus error (up to UEFI 2.9)
	- Cache error (UEFI 2.9A and UEFI 2.10)
	- TLB error (UEFI 2.11)

Please issue an errata incrementing version number, to allow OSPM
QEMU and rasdaemon to properly interpret this field.

Thanks,
Mauro
