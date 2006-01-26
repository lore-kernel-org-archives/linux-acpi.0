From: "John H." <mistamaila@gmail.com>
Subject: Re: Suspend/resume waiting for a key ?
Date: Thu, 26 Jan 2006 07:09:31 -0600
Message-ID: <5b9417770601260509g7f054895of731a9668e993ae@mail.gmail.com>
References: <20060123060743.GA22878@tangens.sinus.cz>
	 <5b9417770601252100w5521ace9h178d16d459410373@mail.gmail.com>
	 <20060126112006.GA9469@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:37012 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751344AbWAZNJc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jan 2006 08:09:32 -0500
Received: by zproxy.gmail.com with SMTP id 14so353401nzn
        for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2006 05:09:31 -0800 (PST)
In-Reply-To: <20060126112006.GA9469@tangens.sinus.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>, "John H." <mistamaila@gmail.com>, linux-acpi@vger.kernel.org

oh, i have the equiv of a nx9005, which reboots on resume from suspend to ram.

On 1/26/06, Pavel Troller <patrol@sinus.cz> wrote:
> > is this a compaq 2110us or 2100us by chance?
> >
> Hi!
>   No, it is not. It's nx9010. However, I've got a new information from its
> owner and it looks that the system is broken in more ways, for example the
> system freezes in X until a key is pressed or the mouse moved and the time
> is losing permanently. So just now I suspect the dyntick patch, which I've
> compiled in to maximize battery life. As soon as I get access to it, I'll
> disable it and let's see what happens. It's interesting, that the system
> was able to compile its own kernel as well as perform all the installation
> tasks without a glitch.
>                          With regards, Pavel Troller
>
