Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA839F181
	for <linux-acpi@vger.kernel.org>; Tue, 21 Apr 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762328; cv=none; b=WqJTrVPbj7+8/VwYhYxceKEOFn/QuSSEkEbxZqtFjyxvmspGBkL72UHSERjThcjL3AaLhTgxrna2/h+SE06u4nMeYMnYGOLEsERK4uUs2QnIgepeTwgsLRleBPMb6GQK4onzEQjUFH6MTGIzTs9lT4BnaGO0QtvR5hTt9Gd95/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762328; c=relaxed/simple;
	bh=jNS11TxrGCzC/ayr6dWUKwMQYFcjJbkoMNjsM92foRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht0B4d+QI1/hHajtWBAA/scuasz2eMPJ8ZhyLNhMfsej9cjxqCpR9D0v5f0ZnVPTDLl91rWqVV1Jh1Vov6Cq76PG0FFYKuyhf0exKsytQ6v8kz8B8BKTnzaNQPL4amX2mxCPoJRcpwI3PwfT6cX6v2YojPfwpkq6wvnCfM8th7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xcc1CP1c; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xcc1CP1c"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-441209fb77eso177889f8f.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Apr 2026 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776762325; x=1777367125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq9QG9cvLvgk2UCX7BCWel9Xe8wLb+Jo7joT5Pt0764=;
        b=Xcc1CP1cnpjrdwUmB5v0J4Irq7DUhlBQD21ey2Ch8Kf6N2zXz11+vDy6TZgmIaAUJC
         +zoEz8FhqsnU8ZDeplIlW5qDu4M1jS604a2J+/T4WHykYlPpreT7WCgIS73DUOordZhU
         GSQpP79dJgdMCPtm+L0j6TbNe5PuLwUFNi+EpHD1QPWzLgzk5WJ2OJHQfvHv7r2ufHNM
         nX6nSDXwcL1hB+Q6aa5W7/7q/7STQTSZPxNsZMvv51vHikW+kMIXBLc6pQtRVKpk8XIr
         0PPbT4gMMmh5vdD5GsAgJgoWAemXJ+aXAnYSthNEwj6jZRtccCdx87/R/FK10xXMgnxj
         3nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762325; x=1777367125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq9QG9cvLvgk2UCX7BCWel9Xe8wLb+Jo7joT5Pt0764=;
        b=jaEvVXCAqZ8S0awrYoJypy1xel2oKHuMa3W9OPtTPju0IZt/4gfnigOHsye1D1p/9V
         yW5+2+mv5HETlAiv+LSNej8Wstw+XhnwHY5NXTYX1/ZDu2//+Au2JNHSP7D/3JmOV0vw
         a0aRJKbayqw587F5RNuFrzL1Xr9KlFSP2H2wBqn1pKydNBePK/u7W/dajr3iavewmsKo
         0O4xmZNbK/bfJ8FhlBfkzZzrC5O42JSEZHQ4gV+OW9Eog6IzoU2aML2ncD4C/xsnRyzl
         JZMEdG0+x3YwtezqIFXb099J+hz6LU8ZU6nLqje6e54AY84qjpm1j2WtDxoZlaD7da5s
         y+4w==
X-Forwarded-Encrypted: i=1; AFNElJ+P69Isk02MiEi809vdbbUQoyVm2i6k/QDmHDtFLf+mFDP0M3HSxyQ+WtERRic9qY3b5A3KwnQkar55@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6iSeD9HRy6jSKIg8yDAV6s8qmkbiVUfL1tT9xs3NH6DXOd+OS
	AVM3sfzEl0kg8v6tkxyrkshQ0HltOci7X/JysaBya2O546U6/1Lx83OH/sCoMoVXlhk=
X-Gm-Gg: AeBDiev36BMeLb9IEa6Z7sCO+g0glngZaeZjKsZ0/5vvhlczlxM85D0d5DJiE2Ssm4K
	A5Fe7pbUxJXwEmizqY3bGY4Kqt4G/qXlzAj0tzSn2zOXfB7yI6Mp9Z3l1KUAsriSE2AiFAhC6kv
	8LmOYf/L0t+pKj64VEmzxN3St1D7Q7UO2RwSwFtUtj9VehWIUhH6VTZPgrnjZt/iZ6lP25Tkdm2
	oViaeQ78VtgE/qmxLiL/Lt4UtpjJ7/JeKEcWOlhr+uuUl6dA33ADN4rifz9SSXa8o//+ulx6OpN
	M+ipfjeoIcWBN49d7akUt8+wkSfDhNDL6ZY2ahUIIPUlXV03W5oyLD4HSnfpUoRzcdxZVOVjkxo
	os+h92dqDvX1RknEVJVpx4KuJs2HJzaygNIAfU1QPQsOqpul6wSrkDCfU7T9phxM5VAUg7FOsUi
	CZNodThoIeRLQdWz3J39gxknZ3J1o4xokX/vDRvcgxjM6RcNaUGBM=
X-Received: by 2002:a5d:5c81:0:b0:43d:729e:f23a with SMTP id ffacd0b85a97d-43fe408dab9mr19081632f8f.22.1776762324596;
        Tue, 21 Apr 2026 02:05:24 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm39945351f8f.6.2026.04.21.02.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:05:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:05:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: chensong_2000@189.cn, rafael@kernel.org, lenb@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
	linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
	dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com, rostedt@goodmis.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list with
 double-linked list for reverse traversal
Message-ID: <aec90caYZDHDAHgw@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
 <20260420144429.57b45f2beece690bceea96ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420144429.57b45f2beece690bceea96ec@kernel.org>

On Mon 2026-04-20 14:44:29, Masami Hiramatsu wrote:
> Hi Song,
> 
> On Wed, 15 Apr 2026 15:01:37 +0800
> chensong_2000@189.cn wrote:
> 
> > From: Song Chen <chensong_2000@189.cn>
> > 
> > The current notifier chain implementation uses a single-linked list
> > (struct notifier_block *next), which only supports forward traversal
> > in priority order. This makes it difficult to handle cleanup/teardown
> > scenarios that require notifiers to be called in reverse priority order.
> 
> What about introducing a new notification callback API that allows you
> to describe dependencies between callback functions?
> 
> For example, when registering a callback, you could register a string
> as an ID and specify whether to call it before or after that ID,
> or you could register a comparison function that is called when adding
> to a list. (I prefer @name and @depends fields so that it can be easily
> maintained.)

This looks too complex. It would make sense only
when this API has more users.

Also this won't be enough for the ftrace/livepatch callbacks.
They need to be ordered against against each other. But they
also need to be called before/after all other callbacks.
For example, when the module is loaded:

   + 1st frace
   + 2nd livepatch
   + then other notifiers

See the commit c1bf08ac26e92122 ("ftrace: Be first to run code
modification on modules").

> This would allow for better dependency building when adding to the list.
 
> > 
> > A concrete example is the ordering dependency between ftrace and
> > livepatch during module load/unload. see the detail here [1].
> 
> If this only concerns notification callback issues with the ftrace
> and livepatch modules, it's far more robust to simply call the
> necessary processing directly when the modules load and unload,
> rather than registering notification callbacks externally.
> 
> There are fprobe, kprobe and its trace-events, all of them are using
> ftrace as its fundation layer. In this case, I always needs to
> consider callback order when a module is unloaded.
> 
> If ftrace is working as a part of module callbacks, it will conflict
> with fprobe/kprobe module callback. Of course we can reorder it with
> modifying its priority. But this is ugly, because when we introduce
> a new other feature which depends on another layer, we need to
> reorder the callback's priority number on the list.
> 
> Based on the above, I don't think this can be resolved simply by
> changing the list of notification callbacks to a bidirectional list.

I agree. I would keep it as is (hardcoded).

Best Regards,
Petr
