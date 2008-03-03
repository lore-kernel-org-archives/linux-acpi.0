From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [patch] x86: phase out forced inlining
Date: Mon, 03 Mar 2008 07:58:39 -0800
Message-ID: <1204559919.3266.12.camel@brick>
References: <20080301161902.GN25835@cs181133002.pp.htv.fi>
	 <47C99FE1.8080206@gmail.com> <20080301183550.GC25835@cs181133002.pp.htv.fi>
	 <20080303085720.GD15943@elte.hu>
	 <20080303091314.GC4457@cs181133002.pp.htv.fi>
	 <20080303091714.GA18250@elte.hu>
	 <20080303093103.GA23651@uranus.ravnborg.org>
	 <20080303103933.GC21190@elte.hu>
	 <20080303113451.GF4457@cs181133002.pp.htv.fi>
	 <20080303114533.GA4183@elte.hu> <20080303121335.GA15381@elte.hu>
	 <20080303070117.0325e77a@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:38989 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810AbYCCP6l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Mar 2008 10:58:41 -0500
Received: by el-out-1112.google.com with SMTP id v27so121148ele.17
        for <linux-acpi@vger.kernel.org>; Mon, 03 Mar 2008 07:58:36 -0800 (PST)
In-Reply-To: <20080303070117.0325e77a@laptopd505.fenrus.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Alexey Starikovskiy <aystarik@gmail.com>, lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>


> eh.. we ALREADY HAD THIS.
> someone seems to have removed this wronly; not forcing inline should have been
> the default after the removal (in 2.6.25-rc)!
> 
> So lets fix it that way, rather than putting the config option back under a different name.

The removal was my patch.  I did notice that the config option had no
effect, I figured that was why it was on the removal schedule, as
it had been made the default.

My bad,

Harvey

