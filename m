Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw [219.87.157.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603ED245020;
	Fri,  2 Oct 2026 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.87.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929522; cv=none; b=WIcZEo7ZXoF8rEXWKBfaxSLIJRWIAxVl2RLYvvmtQQOPpw/pWs+LH74yEn5ti+4AeJEMYxTJuRamGRVUgn6hne0eulS176dACEc1LZgnmBq21UKEnREk4/GPRFfC3Y6Lqe/VoHDzabDbrqnZ3eOKkBtJwKhc/ebeK1TZr/Pu7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929522; c=relaxed/simple;
	bh=Qrov18ygbN4DzouH7nd5661p4G8g6lTax+t9ft6hDcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Por211knbbnhHWcnoMlQULSEi7N3g9+kljvCr+BPgyywophZo0mKMQ/0wYZ1S697bNYCxLKQBZHCa6v/b3Lz/wpxC50Y11AETdgETbg2/0ES47kG5EabjoZOoGkHruLFaJWd59Y4OrS8Dsvc1/dzm1DRJi4waiP92ATfZ3f6q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=UvgzNE3K; arc=none smtp.client-ip=219.87.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="UvgzNE3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F57QhPvlDhlmPS06WMg0e3CP4MNfwy7uaHW1VCudM3A=;
  b=UvgzNE3KKXp0XUBw/CVhsUdHLamRGJ3P6Qwmu5mveFIPQeo13kdHWF+K
   YMlCxMTQME7B/sJSc5NseysB07G4gwK3u7/BqY85kS1qLxAMGoSyDO1xV
   vAO/9Q7UjS2iC/Vb0s8uakZ25fcRVGzil/5RbaiWs97a+JTbyGqInjrEC
   UUm5mIUnMXv+pUxZF7JWNuA4W+lc8tEQkOLBHw+T08rCKkvdDAUH9A4k1
   egXUdxFMdmoYIHC8zUXCgftLYNKgc0Fcleb16YXijpUqDaAiZaqb9UJ5q
   tqNGq7jJ7rslS0WJKhMXQISRTzIVqwkljRR4feq0aj8uV2AQLIlhhgsw/
   Q==;
X-CSE-ConnectionGUID: C17vLvoIT5OBrt9xA/jY5A==
X-CSE-MsgGUID: mq3OAHFPR1yMG8qJA5SNuQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 02 Oct 2026 16:25:15 +0800
Received: from jiraproxy.ite.com.tw (jira.internal.ite.com.tw [192.168.35.200])
	by mse.ite.com.tw with ESMTP id 6928PBXC078014;
	Fri, 2 Oct 2026 16:25:11 +0800 (+08)
	(envelope-from ite_pd@ite.com.tw)
Received: from amber-VMware-Virtual-Platform (ITE01791W10.internal.ite.com.tw [192.168.37.107])
	by jiraproxy.ite.com.tw (Postfix) with ESMTP id 067A72F04;
	Fri,  2 Oct 2026 16:25:11 +0800 (CST)
From: Amber Kao <ite_pd@ite.com.tw>
To: edward.blair@gmail.com
Cc: W_Armin@gmx.de, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mika.westerberg@linux.intel.com,
        rafael@kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
Date: Fri,  2 Oct 2026 16:25:52 +0800
Message-ID: <20261002082552.7084-1-ite_pd@ite.com.tw>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829145516.13500-3-edward.blair@gmail.com>
References: <20260829145516.13500-3-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MAIL:mse.ite.com.tw 6928PBXC078014

Hi Edward,

On Sat, Aug 29, 2026 at 03:55:16PM +0100, Edward Blair wrote:
> Add a UCSI transport driver for ITE8853 and ITE8800 through ITE8805
> USB Type-C controllers found on desktop motherboards.

Thanks for working on this. I'm from ITE, and I wanted to let you know
that we have been upstreaming a UCSI driver for the same controller
family. The driver was posted on 7 Aug 2026 and has Heikki's
Reviewed-by:

  https://lore.kernel.org/linux-usb/20260807-ucsi-itepd-v7-0-998ac11ed0ef@ite.com.tw/

A follow-up series extending it to the IT885x and IT527x series has
also been acked:

  https://lore.kernel.org/r/20260924-ucsi-itepd-it527x-v3-0-a7392aa087f5@ite.com.tw

Both drivers target the same register interface (CCI at 0x84,
MESSAGE_IN at 0x88, CONTROL at 0x98 and the vendor interrupt registers
at 0xbc/0xbd), so it would be better not to have two drivers for the
same hardware in drivers/usb/typec/ucsi.

Our driver currently only matches through OF and I2C IDs, so it does
not yet cover the ACPI-enumerated ITE8853/ITE8800-ITE8805 devices on
the ASUS boards you are targeting. Would you be open to adding ACPI
support, and any platform-specific handling those boards need, on top
of ucsi_itepd instead of as a separate driver? We would be happy to
help with review.

Heikki, Greg, please let us know how you would prefer to proceed.

Thanks,
Amber Kao <ite_pd@ite.com.tw>
