Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B73B0AF5
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505915; cv=none; b=dXddK/41ZwE3bvkG1iU2RayEu9WlFPW9iyKVbeJpaQQ867aGSN9N68vpdIC7Y23BbVejOB3X8aJjqSi7PbYpOuyvoarsuFgEKJrd7hVjfMdEa92EVL1lq6u/ELp44LttQyIrbM0CCX3t0/3MGLMsQluMfu5AyANPnymhKS01CeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505915; c=relaxed/simple;
	bh=nZYsBrhmQesky+duTw28oI6HX6hYlSNQo3RecstP7BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv517s74BYAzszKIkLj7A+VL1GXdMZ7k+2VsrU0KdsqtvuQJl157X70xF8Dfnt1Ct7ZuhtfU1D1pmNu6Tju066VVHJI7NYS9nR1SLxQdDGIqpB8r2oMQM5CvGpkxvcMRGOh0nMjJmLbbCEuaOGXxu/FsY+JANZ0ZsMVdEZProRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DJzfkiWG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DJzfkiWG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c7e8eea816so10287355ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782505913; x=1783110713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MQEizdZJqfwhrqcgsnjIRIwjSErEYCfch5iAelPHGlE=;
        b=DJzfkiWGNZMnhIdOqnHfbkNdap71L/WgezeN14Vcl66dZogmnBWByUh5z33cn9wsjb
         kzURXxvQXlVPdQgvJDawMg4osUV/qruG6aqqH8OaIXucNHVEFdxF3RjRtIXHLt/8/XKp
         JfQ15xkI8FWVYX8HbiBHySwuwdUgg/K5oEHUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782505913; x=1783110713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQEizdZJqfwhrqcgsnjIRIwjSErEYCfch5iAelPHGlE=;
        b=m9vlGdT9g0qk8x6fn9LKKiAUw5UPHUiIzQtfAxE4jcvSuTAuls2myKlBf9iryYmXhB
         BHEWqgcrfydSziIcsFRfRE+UpsXeOr8d+aJ7/TiP5jDc4ZVuiagYtvVulwcs0i419OSB
         uJ4Zhw4qCczT3ygO+sIVKUQqrjkf1vqAxrEuZ7S5ItNlafzVWA1uxRGb/+uZ3DcahfFw
         XzGNP1/+sumTwfOOeoQl4lRN2uoUJz8t09wTbsQTp0zhxed1cKt5rXXw4eZIDnt3Gr63
         bJgEAmzrv/3jUisNF0CiQLwIamRJxh0QWgWtGG518BDXDEFjQBMZ19P6we1NcQBRQ2gx
         OWxA==
X-Gm-Message-State: AOJu0YxBmQJw0vadwmq9w9fzPsDIBMJXlGSy9y94EnyCcOAbeWsE563c
	4HW557pmRehCE2VWCS1+0qPPeCfawlQpzbKgxL3JOqBPP1X0J7ofRw65A/0q+SsML1LAWkm/aXY
	OWHrS
X-Gm-Gg: AfdE7cnPDwqo8nZtKTUMwEMXqRcH7OgGTFzbn1Wgw5Gn+tDRdivO50KTzMBlRHidvhP
	0Yp88zZg89IRhawwNM2rg1ZH4AYWa/wUmCpyjadICwVv7ers/kkFK5VV3EkBjZyBftzlSI0koBP
	TDdSie71QXBfkJ60QPUG6jaYOqJVC5DGXWENe8HvcOtblz/kNHMwgbq/umrJHbdCHJEqo2Pkd0/
	IJQBwXKSCLzYKm4znCJCw6j+K181CVFa+Hn8399alnSBjxCRAcDQR6A5YOFKk8mvO9CssgP9Xo2
	tNKTIqSmc8PO/TWtXrVRdDHYOkWG+1x4V/YyfzhMOcGyqF+IK18ypA6U7Do0FMRbXLybO7I2mDc
	n6sVBaMmjxIa3F1Mn5PeENEkh6koV8NIW/4XuMVN7VyJwe1/6/xSx+J4Mp9nBl8ob2PzLJ45iSA
	1sQQ+IJU/2+4xuUeMGbSvSCU5IJQZ26VC/90l+LGFNtWMzhXYJBiMDwq2URHXPEUJVoQ==
X-Received: by 2002:a17:903:166e:b0:2c0:dc5c:9069 with SMTP id d9443c01a7336-2c7fce84079mr58329205ad.2.1782505913121;
        Fri, 26 Jun 2026 13:31:53 -0700 (PDT)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c980f15234sm8288915ad.39.2026.06.26.13.31.52
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 13:31:52 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8422f395a4aso851409b3a.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jun 2026 13:31:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:1daa:b0:81f:5acb:55fc with SMTP id
 d2e1a72fcca58-845b42dfcf0mr6772578b3a.10.1782505912059; Fri, 26 Jun 2026
 13:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
 <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
In-Reply-To: <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jun 2026 13:31:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZi-oiX3_eFCLVWRk-LDQF--NHtwks0GYaUsuLnNM8Qw@mail.gmail.com>
X-Gm-Features: AVVi8Cd80J3LDiO4w3Ru44VP1Wu1Xj8zp4FzZXuERUV9kLLmJhLujIVfzKlBvXY
Message-ID: <CAHk-=whZi-oiX3_eFCLVWRk-LDQF--NHtwks0GYaUsuLnNM8Qw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 13:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> How about just adding a trivial strncpy_pad() to
> <acpi/platform/acenv.h> or something. A place that already knows about
> the whole "I'm building the app side" now.

Actually, isn't this what tools/power/acpi/common/ are supposed to deal with?

IOW, maybe just add a "strncpy_pad()" implementation there?

(I'm not very cognizant of how this build is supposed to be done, soo..)

            Linus
