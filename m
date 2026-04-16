Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D63B7B91
	for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342610; cv=none; b=ImelBjoVQ0sTMpSNeuOQd5YWCE0vtDik+DaNHJQd+7LfiEEWD4SoIer9YG426jR7asXH0aDjHDqFHT/0Kd/sFRkL89ku1oSwDnB7WRRs6FN6/RCfp2m1B1Y6aGmMJodrxvd12YKu1g0iCwIt+MTkYd7uf4dnGf4R4ngTwnVDUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342610; c=relaxed/simple;
	bh=K/4afwQ5p31SSvbXjWdzi0L0oqupXfEEFTghGQ4JcSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/WT4z7UWPl5Q1qqoJ1FOVmxyg9rkph/NH8oiq3TItpJrVIf5wmqZ3OxN101Gt2HKYr7DyRymAO5n6dOeeV1QQ+PEj6NN21+Iwb5zcsZwrdO9cTDahRRflJ9BX+hIdWpXeWjtv/n05Bq5HRQHmda+Q7ly3TQst+dA63hHt/rV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMyIhcMB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMyIhcMB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso95897545e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 16 Apr 2026 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776342607; x=1776947407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD5n29vJmomxS6DITZYPjUM6os1Itf/93DfNIu2KPog=;
        b=SMyIhcMBhud7E9S0oZfY4dPtDZqiIEqLPYjB6s4KMU/0r83YLgF5ZbDmBOKyocj9ZY
         qrYE7AXH6tRIrCBZ2stUl3Qi0p1ekSMzV/bw635qeh1plkYWcNycJtCcJhUXvLmdYZkQ
         ak84/JBnez1KRfcmlMpgZ++CuFvu085GXxYYRhr73LFU4mA8rLyuOYJFvhMOOSuhDheC
         cVlzWB5L4UqeH/Dt9xlmzSUVQmUeJPE5kIcqSfdNeq+fT/ncidGLUeITziIc3LIGoSlb
         mIEymQGy7PCqcWSexrvq+2z77t5rI8LX0YHsKA3o8o949yKU9SPV8ckeT8kyG1heRNFK
         DfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342607; x=1776947407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wD5n29vJmomxS6DITZYPjUM6os1Itf/93DfNIu2KPog=;
        b=M6qU2gnWoyEG/+PkhiIcYb1KmQVJ0W6eq2R6WI3aVJ3JAgkx0wZAXxxno0Ek/l3eg7
         oMaZD+tZMwNYQro0D+RH+fTAooN0SrXDpb8DdPmJmlhOyI2qeu48TAxLcZj+02tqLsHa
         OSONVgyppqjCu1z6FZtSxJ5TjKZRu7jrbOAyjDx2wx3WuCwib5B5pOROEJcYWj3sQgUc
         tTa/2Wh3RPqFFzBFdRI9cjE/1NW955+GeIbLx3oQUmE+NHU9xx+Sybd8fCyPY7lnpSdP
         3B6AtuF/cvNJ7o8OPrDc+Ho12z3O2eD9pil8RKPHq52FuXaIqW/ajJSdTS0tMbRoi2lD
         7qmw==
X-Forwarded-Encrypted: i=1; AFNElJ/eDB1ZnNyfDl7pl9C7x8jkoVHB84zc4hXjKdOYIXvW69hLzyrfDvP+j+wtYh1e/nQvBgtCrhvIvpWz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7A85ulvInLEh4m+yOB5cOYszyljTIzzJ5cpffx9QTz2qOqPFX
	KqLaCLZqrUnnBkYhQJrY7mAFyPfqqdQS9XA62G1S4O+RTAj+cqdUyRoT
X-Gm-Gg: AeBDieuuk7ShlI+AUnXuCatFr6F3tu2xbBiB2KWXdbCc573kWdZle0yizZ4/LBVcCZc
	pofCqvlOh24sBBHfc1wsRJIJqUmKyydYNKFqSKvfnEDT6pTcmdma2nLH1vfm36SKV2+k+cRknlI
	4EctJD52+borYlsZuNv6PUIvHP8Hgu0yRe1JSZL8kKWS8a5RztpNeTJ6wylRNzY3vAlH15ROMUR
	raSde1uxhuEhf7HGIR0Vg7sNNpcaMigeg13Pg3OpFdSrMcP/VzgQVx3/L0AltFvGt1x8nED3cSU
	2JjrMZz7j/5vlKjt7b65RpyJqenUJkuMIV957ZAO4QbawHmBuNzwG8539b2CmajnmLN5OpAeNxt
	pjcK2nuJBqh0CBPqLx9Bpqrs6KukJLaZE7F3acda5TIsOogalMDtETYHUjcbvcL0AMSLdTDnkuC
	i4IR/SipRyS+qWHeprC23MbZFoMFpLqhzSJHF6kn6kzb1VaiGAksyCRA/Gq/uh1U1J
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr355637165e9.28.1776342606991;
        Thu, 16 Apr 2026 05:30:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9c668sm69981255e9.4.2026.04.16.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:30:06 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:30:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: chensong_2000@189.cn
Cc: rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, viresh.kumar@linaro.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, bmarzins@redhat.com,
 song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
 jason.wessel@windriver.com, danielt@kernel.org, dianders@chromium.org,
 horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, paulmck@kernel.org,
 frederic@kernel.org, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, atomlin@atomlin.com,
 jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
 joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list
 with double-linked list for reverse traversal
Message-ID: <20260416133004.07bd2886@pumpkin>
In-Reply-To: <20260415070137.17860-1-chensong_2000@189.cn>
References: <20260415070137.17860-1-chensong_2000@189.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 15:01:37 +0800
chensong_2000@189.cn wrote:

> From: Song Chen <chensong_2000@189.cn>
> 
> The current notifier chain implementation uses a single-linked list
> (struct notifier_block *next), which only supports forward traversal
> in priority order. This makes it difficult to handle cleanup/teardown
> scenarios that require notifiers to be called in reverse priority order.

If it is only cleanup/teardown then the list can be order-reversed
as part of that process at the same time as the list is deleted.

	David


