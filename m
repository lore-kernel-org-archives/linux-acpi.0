Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB8407CF6
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576787; cv=none; b=Z1zimRiT7mzo6HL7fD5oAd7C+Im/EMzJrZcyi9a9XmMj3XCY4/KsgXKT/wBW2S9pZX6FkZNg3nK49+qyk8CW/LgxPvebX1E1jaoT01xWtgVPo1jszKCnmpZoCZMMWsMLGO4fOuQ2AtHAHv7oLIwA7QObtavLX/tUG8ymNAomKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576787; c=relaxed/simple;
	bh=SHi0vfZG9DlqgM81Tro0NnUp4Kcm7o4Ob1I5pVCwaeM=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=PU6VoeCn12O2xcHlW/E1R8fAz3+9tMB1tYZC4HhifXij/nYNFoyFtYYj1qDtJbupsCCRsC+cqU9UP+1gAykXOxoYcRnDAqdRqgZ0PlvpMLP3I0e0AL7mBAYi6wiP5apuDk5OzfC29YYDJ4klw2aPLB8ZlryWs3IcwiCmqgANZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ep8S3pfJ; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ep8S3pfJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1786576774; x=1786835974;
	bh=SHi0vfZG9DlqgM81Tro0NnUp4Kcm7o4Ob1I5pVCwaeM=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ep8S3pfJVbdeBlVodFpYu5VVNXZ6r6mfGnDPmoe6alI95fXzWAqvW0gZxWM4ltDJs
	 ZhkwqGHFxLQ5ZGchksnL1kiNYflxU6uq+sPbQ7dzAOqoGlC4Xo82hkXm+AHyWsTfK9
	 bEBHCbsXpFUs5sMTowph6RvmWKnWc6jIQZG532DNQqD1QVGTJ+KWiPMB+2dclgV11d
	 1Rd/rP+ZRY9FPVKtXNquQ2edixc2LWr74K/GvG5QfyFs9/I56l2zpE3FHeEr1L9QtC
	 G6vVNFpSW5vovq/sN4F74GLnnXNrNpKst0TMrBG6bH6Z3jVwSQPuk6ihN0knTvEeRs
	 gfrWIr1E8ykEw==
Date: Wed, 12 Aug 2026 23:19:32 +0000
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From: kot-valera123 <kot-valera123@proton.me>
Subject: [Bug] Lenovo LOQ 15ARP9: _BCM evaluation failed (-22), backlight control broken
Message-ID: <USoV6ptGAnEY7Z-MNKt0ZGGM50xuUn9UQvSpHVkpm-37jYxeqJIe03nHeEO-yDfbq-N9QyhnwX69J0Q1eo9C6isUQ2Horg0j0_-_gH-NpXo=@proton.me>
Feedback-ID: 214147674:user:proton
X-Pm-Message-ID: 3fee4eb416f6b4e5a020529038cd78fca3e37b43
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, I am writing to report a backlight control issue on a Lenovo LOQ 15A=
RP9 laptop (AMD Ryzen + NVIDIA GPU using the open-source nouveau driver). D=
isplay brightness adjustment is completely non-functional. During boot, the=
 kernel outputs the following error: [ 5.209088] nouveau 0000:01:00.0: drm:=
 [DRM/0000000b:kmsOutp] [BL_GET level:0] (ret:-22) After discussing this wi=
th Karol Herbst (nouveau maintainer), it was pointed out that this is an AC=
PI subsystem/firmware issue rather than a driver bug. I have created a deta=
iled bug report on Bugzilla containing all necessary debugging details (ful=
l dmesg logs and acpidump): https://bugzilla.kernel.org/show_bug.cgi?id=3D2=
21859 Please let me know if any additional tests or information are needed =
to help resolve this.
