Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2737B028
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jun 2026 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338175; cv=none; b=l4GtUjv6zU96FjI5lxHXAUQLyJUlJYT2k69BPrIL5FqK2v8WmwcR2pVbG5DjZW3BBaOdj5hay1lEsy9KFkoPACxvMaVRPTu7yJ1gXDJ6PuEPQEh+hFTzq8VDAhTXlDUc+c0zFguJrPwtfa4kPo9CQ1MIzH5gETt4SCBFh6snwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338175; c=relaxed/simple;
	bh=9q183NFC9fS2JbtBL36Ugl1YrAbf8Ci2YCyn/eMtdUU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=XWIxHcfcr9YfLyv/H/Z/1hLmZq8fdOXlWSBIkihRJ0wUwZSUBbdEjSgcvK86yOpkzXUrFcmSDyjtZRENi47Fo82Hm4W/Sv3Jit8Rii1R5EbBUrX7DnNm9qBkhGfPl31uR/4fZ+tLp3h8jYWIpQy3Ku4zbCIIvvBZWXpTz++lmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com; spf=pass smtp.mailfrom=ciaorelated.com; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciaorelated.com
Received: from 89-26-47-193.stat.cablelink.at ([89.26.47.193] helo=[127.0.0.1])
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <info@ciaorelated.com>)
	id 1wU74P-000000003xH-3eTD
	for linux-acpi@vger.kernel.org;
	Mon, 01 Jun 2026 20:09:02 +0200
From: Dogan Karaarslan <info@ciaorelated.com>
To: linux-acpi@vger.kernel.org
Subject: Open source social media project from Salzburg
Message-ID: <e883185e-817e-9a5e-4057-0c241c7e37e7@ciaorelated.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 18:09:01 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-AV-Do-Run: Yes

Hello,

I found your contact through GitHub.

I=E2=80=99m a developer based=
 in Salzburg, and I=E2=80=99ve created an open source social media project =
focused on communities and meaningful connections.

I=E2=80=99d love to share it with you. If you like the idea of an open =
source social media project, I would really appreciate it if you could take=
 a look and maybe star the repository.

I=E2=80=99ve put a lot of heart =
into this project, so any kind of support, feedback, contribution, or =
simply sharing it would mean a lot to me.

Here is the project:
https://github.com/dogankaraarslan1/ciaorelated

Thank you for your time.

Best regards,
Dogan Karaarslan
