Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5391556BAC;
	Thu, 15 Oct 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079934; cv=none; b=O5iTNKevbXwdioswavc7trDwSfrfGP72yAlq4YI2bCMYtOGADh4bSrP5nj90MXj8swXQyYZZsGnpvwAccREYkb5gABQ+F8DlzeFVfiN0pnypZsNHs8hjIZXSSdRfmsDErbgit45dEI50t0ldHADlt5Slpgi0ojOXrGG1NbEs7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079934; c=relaxed/simple;
	bh=45VSe3nRbT/NfoQSQGgs+uoKL+bfGe7PkGT2oRQpJ4Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PB4uNhBrQ6c+URSE2hT509EXRP772WC+Tk29BD3jltqdCmX2unyNMrI1UcSo2g+qX4fPsnccgJs1PG9NWXRV9QPLuIKKtNuYLoSCI4vbqre/aQaWWKWOeJA+NpMZyVRUYys5QKZk6AFVOXggyF/lXanqkxJZv4ElMCpEdnaFHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tuxEiVzG; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tuxEiVzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792079894; x=1792684694; i=markus.elfring@web.de;
	bh=45VSe3nRbT/NfoQSQGgs+uoKL+bfGe7PkGT2oRQpJ4Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tuxEiVzGUvzjGxdlWWIAm0i7k49HBy1+vCgVa0rUcPWR3u+aArZcyH0skyz4oFhw
	 7pWT806q4VnFWlbNmYevnAPOm2rmfYP5b2xZWWrVeUskvQwGM03qWuvM0wXN85LLk
	 58O6vLYXio0z1i0MwI1g7XYNDDC7XKBwAL3lWn5oAdN3WtwEaWGk7CzmsuHGaIT4O
	 W0hdewNqPDJUro+/euNzMJyZ8+KkDFztg7lVWEi1kIRQK2rT7keBGvLlKgVkbYQGl
	 UQcvPfw/WkF74LDnesPMyahS9SZ14oRjoiZ8U9FofzKEczvCw3u8x1zPcOt/bDkyb
	 W47bO6Z4OEp7UfpTwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5jv-1xQQP10hIP-0097iu; Thu, 15
 Oct 2026 17:58:14 +0200
Message-ID: <ac7a622e-d8b8-4c89-a091-16bbf070344b@web.de>
Date: Thu, 15 Oct 2026 17:58:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Iurii Trukhin <yuri@trukhin.com>, acpica-devel@lists.linux.dev,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Erik Kaneda <erik.kaneda@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Robert Moore <robert.moore@intel.com>
References: <CAOx7e9+Vv8Pdyks=AbE5XG0ZyDgtKToKyBLTnt+H5RPn6VymVg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix parse tree memory leak on AML execution error
 unwind
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAOx7e9+Vv8Pdyks=AbE5XG0ZyDgtKToKyBLTnt+H5RPn6VymVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nTAi03Sa+tSdOGQipQ77LLueaId2JdnpSFHkCn8FuigQkLzuVqy
 kk6iSmU1fFVrgj1RFmyjyxnpJdNwVGbHhrjwj0b3QaGp+j9iuGVyFfgK8KA/TxJ9DQtjeK0
 pUuHkI1u2n9F+wUSk3rHkCcDNOCa4eYvTFx/py+rPMIqSfNzpzpv2JM6inGERa6SPpbWToV
 3Zzl1WL7gWQyKUyHeXRmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hjie2duiw0E=;MA0ZZn8Bz8Dtb7z98/DWQc4qkTu
 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

=E2=80=A6
> Fixes: 5088814a6e93 ("ACPICA: AML parser: attempt to continue loading
> table after error")
=E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.3-rc7#n145

Regards,
Markus
