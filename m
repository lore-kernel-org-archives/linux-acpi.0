From: eaglex <eaglex@gmail.com>
Subject: Re: sony-laptop on AR series
Date: Sun, 27 Jan 2008 15:16:27 +0200
Message-ID: <17b35fe50801270516x41b287f2p150dcaf41130c8e@mail.gmail.com>
References: <17b35fe50801230233jda8e183qf380ec153c26020c@mail.gmail.com>
	 <20080126035059.GA24583@inferi.kami.home>
	 <17b35fe50801260746g3d593651h50a273913dcd1642@mail.gmail.com>
	 <20080127125001.GA335@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:43590 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbYA0NQ3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 08:16:29 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1324814fga.17
        for <linux-acpi@vger.kernel.org>; Sun, 27 Jan 2008 05:16:28 -0800 (PST)
In-Reply-To: <20080127125001.GA335@inferi.kami.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

> eh... this is known not to be working with sony-laptop. Even though the
> DSDT exposes the brightness methods the nvidia cards have their own way
> to handle dimming the screen.
> You can try with nvclock which works for *some* cards.

Thanks, I'll try nvclock.

> For now all sony-laptop can do is enable the Fn keys, I'll add your
> model to the DMI list asap.

Any chances of getting the rest of the controls working? (like turning
on bluetooth and so on)
