Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347072;
	b=QriW/uzMAVlZdg/eElWrkWo3qVEOrCQUvrykYAVqjSA50vCfgpTI+nIv7CQ6I/6xNMzf
	 gflK2NjVQL/pP9OluLrDSeZDi4ZN+HlQ0ExRphD+X3AqYozuxOumiMjopWVcU5H3fJsO1
	 CVsf/ljWEvGEMyKEA484u4y6BWgYoiCBvLY5WcFev3KMLV5MSyDAisqH9UDis9d8SaYiG
	 KiOA37dw4f92Y3446rqiPxO9u/kl88es1xn42lfiDKAVh2y1SIZn76g/KTFf6nfSzsSA5
	 KHbxkZGMW01E4AWm6ayqOqjcWBgtZ6DKRphwLs7uSFWBX7H0mlqF8NNqub3IUqazPfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UeMFe59C+6CGb+6QO+mNSCypQcnt2mUVBf/74RZRjcg=;
	b=kztOkD3C1BGuROq+wSbSy3AbHt5FSASvRa3xL+tOJpHrq4jGmJFmzR+bjKp61n1Ff8E4
	 ElaoCmpS2ERnL3c/9rckUe8li0MdnLag0rYKV/6lb22QGoxGx/DdYEgvCYZWmzLi7gw68
	 lck8ieAK5jgODASljt/oBMPQgAqHSbJ1eZLnmQK0ChigA2/0lMDPRqMWNx8fKT1LFK6jM
	 n03rKO/rJ5S1SZa14qVQlnwHHsdhnv0Yp5G5PIdItQuLH4DA2mrU7puYs+/JnUN0TBwYh
	 v8swlAcoIDFYudSznf75c1QTxyPIh4RzGoQmjbCzv/kwMB8DofSIVvGrBMBxOpEQNPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fireburn.co.uk;
	spf=none smtp.mailfrom=fireburn.co.uk;
	dkim=pass header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=paugg4K5;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E7606A324
	for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 07:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=paugg4K5
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso171893f8f.0
        for <linux-acpi@vger.kernel.org>; Fri, 30 Oct 2026 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793347071; x=1793951871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UeMFe59C+6CGb+6QO+mNSCypQcnt2mUVBf/74RZRjcg=;
        b=paugg4K56y/LQwEnbFQts4oXymCk549ELgld7CxfmgqQWHcOnpLlPV1R/Di1qwNQ8w
         rE6DwPDHFYFS/UF7YpSMPKKk7y8efap1/zu8P/ShgHECQBHs5BbK/TvXDde4wwWXAy4D
         eyD7LsxqYl7nDlbnqoTtY7JcB1OiRI8XBNZ+1mLkCucRBuh64urbCdT1kzQ4621+5eAx
         XdrbqbsUR6xcva9NaZlceR+fEx+fD70DaGL7kUOkqs/ogNzvj5aOOoDYTUIBdt2bE67A
         1S54npxkVHvCbZueFIDOd3EbxZFXOqKZsmucmrPUKCd43J9aBq+FkL0fgndAU0bDODqD
         pGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793347071; x=1793951871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UeMFe59C+6CGb+6QO+mNSCypQcnt2mUVBf/74RZRjcg=;
        b=N0ineuCLjircLpAz6klW4+yQzLI7Gz8mlHgLK/mfHvvqJAvqqOXqnvMW9fwO9o7Xsp
         +s0oxPiS+5eCqNTG2G1OgIBjWPhCCPUgkdOKcHpi4m3pxY8pWq5TK5PYJzMGWvYKfYEM
         6dkXxr8m35fCiSoZeC0aqxzImS8nNWpAx/88pLAhLc7d025qTYxYHj3d5oxyN7JsRIt3
         EhjamdYyiyRUxXnw/j8Wfq9Kw/xZfie7vsQ0rZgidm8beLyKEd4qTAlOgkXPPSCkeR0a
         p3CSmt52aDmrs+7jSN8XN0avOc+AXNKSEpvel/LJ+DhvFMytfcAKakzWvN6Mfy6giIbo
         RYoA==
X-Forwarded-Encrypted: i=1; AKwUvBxh4IYoDKpYQ/qAJsbxVaDyQ/2D5zFEoCWKQ47+CCpWDA6yKarz2OSLLCxkP1HohkV/SLHMxn/Zf0kW@vger.kernel.org
X-Gm-Message-State: AFq9FYIq+4FONCwQwZx/9G+t5z8PdnQ2M1Iq1+Ir/5oCn6dK5r8vOD7z
	OpT5iEYZN784cRPmwhLFyj3LWqhQ9BV/F+aZzpjFThVdZfZBMjwBQjEYlCKIpnexGA==
X-Gm-Gg: AYBFou3vFS480Xe3S0aFucbTBBQHK+5vXNW8z9yEDx5whyve+H5pHIhR0l2j4qs8lQ6
	YYCMIpTfzgAIHVXQepy48Hk161OAcNmpvOP3WalQHaKqeEVBDiflE0wlfOGDZx2mFQCTmiOX6Ow
	eCOXLGIOv/ekbB6sG9mRt2mOFmnToqUaYBErWs40neQWVZeOxHbei71KIAlgr+Iy/6h0WBv0Pm8
	wJLuYMKTEhDEUIrg3Ork64lONV/UU53HHodOXpjNH+SkZfb57qf+2/lp39HLZoyM5bHGqqHdSNH
	4Wsks0XiEVhrCuN1NUVagq+0zNvucKv7O12Pxbw2hq0jnJdlVeB579DF0jueZhiFPCrMWb9RAkB
	jD2J/5HQpOpZUETwbjYB/fVDF0w0UHKKytYyXMkZZX+OL+tRn4mzdfGp8bVTkLNhdLFaxtMDqA4
	zHIUHRumLiC0O5psu9YD2SZIG+hO5iEBn4qBbmD1jm3knx1rVK2NMv0eboCE5atl8bCf+jqjUCL
	LFNj6TwHa97HrJDmv4EnOTgKhWkdYN/I6FTxsvNTJOa7u73GWTmgcoCdOgIvpFgFj9BuM6+P0Ui
	6x1E21iM56OMxpeBiF8q8OupdJwZ0bUxt+hHoOxTx7DJNXZYqCOdEsom02zQ2xtBU7mkLxOfuXK
	P
X-Received: by 2002:a5d:588e:0:b0:48e:6bbb:c3f3 with SMTP id ffacd0b85a97d-48e6e2fd071mr3556678f8f.28.1793347070787;
        Fri, 30 Oct 2026 00:57:50 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8bd8esm1676007f8f.42.2026.10.30.00.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:57:50 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: Mario Limonciello <superm1@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS ROG Strix G513QY
Date: Fri, 30 Oct 2026 07:57:43 +0000
Message-ID: <20261030075743.356835-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <8072db9e-0df4-4fc5-b86a-cc50ac7934a9@kernel.org>
References: 
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026, Mario Limonciello wrote:
> Can you please get an acpidump and put it on a kernel bugzilla or drm
> bug?  This generally feels like an ACPI interpreter issue to me.

Done: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

It has the errors and the tables from /sys/firmware/acpi/tables, minus my
local override SSDT.  I haven't got acpidump or iasl installed so it's the
raw files in a tarball rather than a real acpidump, I can redo it if you
want the proper format

On the interpreter question: _L05 is only Notify (\_SB.PCI0.GPP0.VGA,
0x81), and \_SB.PCI0.GPP0.VGA doesn't exist on this board, the dGPU is
under GPP0.SWUS.SWDS.VGA_.  I don't know what the interpreter is meant to
do with a Notify to a path that doesn't resolve, which is why I put the
question in the bug.  Rafael, if there's a better place for it I'll move it

Mike
