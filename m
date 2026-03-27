Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183993D669C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604713; cv=none; b=TuKRreI9DhOXoCefDMUTaQem4hAklDEkeEybWqNbTGjzXehFSbVdnv8pygnaJW+3iMR0udifBJEaf0Qz1S2vt81fnGHUbUgotjulBxrYl8ZFKKPxmiV4O9svxnyCAH3vSleZAxLSiQ1TIIGgX78TOrBYXtg7tfEZYT7aDrXx8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604713; c=relaxed/simple;
	bh=7uR5ZfLw9g5I/+7SbxvKw/jw1IUzAD9quAniYX3R718=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXp5bVTt134gaV0QOUyzYO+d0to28b1xFDCcCd/jZO/6ly2fxNjkUMc8ORkU/+PK/EykeKHmdganPjcMjtFsEiE8zMZY4iBwL0JW4ejX0IjFkyOV0wQyMlPPv7/v67XY/rC+Sco+8sCyOSbQqAc+/lEobkeaWFzT+F+mHmFxzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USqeTMin; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USqeTMin"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso14604925e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774604710; x=1775209510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj+hauZNh7iMjr443ejLDbgySbpC+BhPH2ZS5nH/CB0=;
        b=USqeTMinJJlOwltPL1D0bgruDBnQRsM4a8Q5iCwjzPSFu8Rfm9jhLFt6PhJtTQ0H89
         kzYShApMMo4ujmA8ORnChPlE1ruXc+ETIaxQ3VmHmwE9VNwMYsQHhAAl2FFeQ4KAFkcM
         P73ASPPK9S7Cwxrtb15wrvHll1bW3EPTmNAR/rgB1hO3PBNhsfk8jUrpRSPs0tD89/Zy
         L1OnoWQAF8epQepdhQpU9KdUT801hri6p6QWLs4n6bmuB0hW/dNUwr3FY+JBvoDr8GTW
         yoFTCIA4rF0gKWlBm9G+gPQqoqrc5JaSK/Q7URcDBMeW62WIjv0TegCb/651WO3SswVt
         mUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774604710; x=1775209510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kj+hauZNh7iMjr443ejLDbgySbpC+BhPH2ZS5nH/CB0=;
        b=GFrm+swxyjwF668Rk9D403l15JlcAKXXlICe1yJLy11loHCUs/nTz1zCm9DaNPU1Kj
         AVy8GeauMNoiyaKcuyjI17r5wESvIRKu+LBI3zPOL2AMqe46YhjBe35VsxsaUIK41Dxj
         WTv/xT4pGLd6Od9R5tcQQGJ2vhDH38vstpZExAGUIsQgpOw6RHx/zITLCrrIZBmAJkMr
         iA5YoHYYfwMGIfyr5MA9WpmquoBby56l7ZjABVHgldB35sFaiq4sBtwhkVFv00yYYgUK
         yiVB9xJbNeBJ+QO8cHc74jk9voP4jHlLkBY+KTacbqku1xQ8446aFHP7ssGCXfMSWEyW
         8Kkw==
X-Forwarded-Encrypted: i=1; AJvYcCU9+Yf+p5t4H4KCPIyiFmBsAHICnUAw02GSVVnKonmgavXrazLHqIz44ZUz/RKnslGZo0ZZjCld+OEU@vger.kernel.org
X-Gm-Message-State: AOJu0YyL40Q1sujQndvkC2vKfrLgnWkxHpxmuFak3dnW/HaeHJVms0a6
	WJTyCm8FsLxjs43o7oMHbw0qBpNfJ4I0MbZCWF03dxlsbiSFqnOApHEqrUr6UFU1
X-Gm-Gg: ATEYQzxxmokL4yu+PG69zVmyM81VJopj4NyAE/C/O7/79GJMuvnBIvfN1atLPTpFEW4
	l5mms8UXKfpMzlrLzWXadsCvOtUifquaoLFw7w5jBfuiXgDkzt5xB3wNUl+QsMB1lMGSXadflF1
	6VJBxrjAiPY7t7Wt/Q4WWvPJmA/vgAi376s54b8JzseDltsuruZJRd488bjpMv0hc2FF4j+WRBe
	ahbWGueHkHyhKKhG3EWkTRC0fdVSrl7Tz3IPLJoWvCFVn0nbwpQ49yKgszE5tLFPzoanijlYm3x
	NHtea/HxhC2zyrzTU+ilK+mtlnovwxYxnDeak1a3wCvs9SL5qic1AZj999cmNjwUxqnRLFqWefs
	K9uYL37lk8Ryqco3EVRR8kXcAeBhhGnvLBNN/UVjDqwzmUmXdt8oEO60uSsJSO8pXDZsnLeZ/W9
	haVmghSEjzZG84n8Fb8HrgmEMWY3meSEmQ4KX3iWodlUrS0H7tiB/9Z37yJphj+UrececG83hvF
	dg=
X-Received: by 2002:a05:600c:6819:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-48727f238d9mr31232695e9.26.1774604710226;
        Fri, 27 Mar 2026 02:45:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872718dfdfsm12370055e9.30.2026.03.27.02.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:45:09 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:45:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] ACPICA: AML Parser: Remove spurious precision from
 format used to dump parse trees
Message-ID: <20260327094508.1801bdf3@pumpkin>
In-Reply-To: <acZNuoRmQ5BrfPPd@ashevche-desk.local>
References: <20260326201830.3938-1-david.laight.linux@gmail.com>
	<acZNuoRmQ5BrfPPd@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 11:28:26 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Mar 26, 2026 at 08:18:30PM +0000, david.laight.linux@gmail.com wrote:
> 
> > The debug code in acpi_ps_delete_parse_tree() uses ("%*.s", level * 4, " ")
> > to indent traces.
> > POSIX requires the empty precision be treated as zero, but the kernel treats
> > is as 'no precision specified'.
> > Change to ("%*s", level * 4, "") since there is additional whitespace and no
> > reason to indent by one space when level is zero.  
> 
> This is cross-platform code. Does the same applies to MS VC compiler, for
> example?
> 

Everything except the linux kernel will treat "%*.s" as "%*.0s".

Regardless of anything else specifying a 'precision' when printing
a constant string is entirely pointless - it limits the number of
characters copied from the string.

Basically "%*.s" is always a typo, either for "%.*s" or "%*s".

	David
