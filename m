Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A01DED40;
	Sun,  5 Apr 2026 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775386040; cv=none; b=UEs9TKPxzrU2THvBWDWD5fXe+QIsC4XlRrjXZtq3LxF2gIqMiqETO3K6XGyJc7lov6xDtw+BukMlSrpyPg+CPXRhoyw2WLhD2AmNkrPdEFQ0Yl0FKskCIOqDo/3VyngffN1mL0qf/clBsW57atokL1uLUL8IS3QO5/YXpadt32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775386040; c=relaxed/simple;
	bh=3/xAUXdB7tMQHhUb5b6WaZNJWnfNgLRk1jU7Lz59N/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8AzIhq0X+r977LidGz6zia2Bk8mPpWVGgy4s4vWO7NgC0p4HIzswXzZVkfHcrIwwMkXmUJnyQC6yKn2OUDdT2MGR3nu2BbATEnZCEJWB8rLPMoCTo3EJp2hk6AGDo+b48Gknylif2T7sIX14aE6UhBugfPgoWV9XPiHrg7NwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dYW27GzR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dYW27GzR"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 70F1E40E00DE;
	Sun,  5 Apr 2026 10:47:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HOn28BpDDegi; Sun,  5 Apr 2026 10:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1775386029; bh=l8mMNRLIlYu4GeiYC4B+NQAXWKS7BO09v3lq8JmNPOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYW27GzROsYwQAU+uZYz6SCuTmfN6PpMZ7LFVeoU7h3gxtR+7TZ234u9h/k5oeym3
	 k+LyjzPNaT9DMMhIoYd4coT9aylnDsw5WyjJWfAM1XkUgESmFSw2r351wviAK11EVl
	 CLLdtPgUI1CDUPqMXSFQbhqrar9NWFNR/+Xelg9pHvgsZ0cWPGkIwbRreHRUsb8r5m
	 gqKBxMdfpm/11g/AzjxIfRsng8vHVqBlP7TDlLzsXtxTStM72jOibWbSGmxE8TstdR
	 G/yTNf2W/humOFk2a0DEinbCcbWxc9ocS9IW0sU9/5Pxexh1st6ux7vR1DLnNQFnBm
	 4ToNEfb+XCAr5RxnFG+27DHpcRukGMlV/aKvHJajo0FnhdcEK266jPcFHRRaHPyUSa
	 iNjSccuGWygEFS3wAlX1cCYh5swflQW304IAp/BZfzCIsnIKVCL5o6T/qH2Rw283SG
	 GPP8O1iimQxS9Y8tQFPzfiPdyNcNMsOB4Kk9yqsM8jPg03dtGuas6d5GM9po+hwzOw
	 c5R9P2ME9xycQSQukVqSWyBU6Bij3ZrUBaN6auJ7JBOFEHmY0l+ylYy/eVkSY/MWxQ
	 HT4jEMJojBXePBijj5+W02jBquKj895/xJSsP9rKUwjkJy6/r2wTyppFgJQnWGMGQy
	 TP81uFKcQ5phDWDgR9y4+m8s=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id CD81A40E00DC;
	Sun,  5 Apr 2026 10:46:55 +0000 (UTC)
Date: Sun, 5 Apr 2026 12:46:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
	qiuxu.zhuo@intel.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
Message-ID: <20260405104647.GAadI9l7s3ZxWymIP8@fat_crate.local>
References: <20251009132055.GA472268@yaz-khff2.amd.com>
 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
 <20260216202546.GA420258@yaz-khff2.amd.com>
 <20260219143345.GA5486@yaz-khff2.amd.com>
 <4e0c5a7ce9f1ab35eaec2c2908df3681ce6eda4d.camel@web.de>
 <8530d765-6676-4ba4-98b5-07326c8dc924@amd.com>
 <290ee50cbe68d246a9899b03d5c7ddebc549f0bf.camel@web.de>
 <20260223214825.GA3130@yaz-khff2.amd.com>
 <20260403140501.GCac_JDVCaX0eCIDUj@fat_crate.local>
 <f5f4251da81752ccae59b6ffa158fd8587458431.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5f4251da81752ccae59b6ffa158fd8587458431.camel@web.de>

On Sun, Apr 05, 2026 at 10:47:02AM +0200, Bert Karwatzki wrote:
> After ~12h of uptime I got the messages that a bogus error was filtered:
> [42603.594231] [      C0] amd_filter_mce: filtering bogus hw error on Cezanne A0
> So the patch seems to work fine:
> 
> Tested-By: Bert Karwatzki <spasswolf@web.de>

Thanks a lot!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
