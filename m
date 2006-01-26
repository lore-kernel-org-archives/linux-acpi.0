From: Pavel Troller <patrol@sinus.cz>
Subject: Re: Suspend/resume waiting for a key ?
Date: Thu, 26 Jan 2006 12:20:06 +0100
Message-ID: <20060126112006.GA9469@tangens.sinus.cz>
References: <20060123060743.GA22878@tangens.sinus.cz> <5b9417770601252100w5521ace9h178d16d459410373@mail.gmail.com>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:27851 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S932299AbWAZLUL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jan 2006 06:20:11 -0500
Content-Disposition: inline
In-Reply-To: <5b9417770601252100w5521ace9h178d16d459410373@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "John H." <mistamaila@gmail.com>
Cc: linux-acpi@vger.kernel.org

> is this a compaq 2110us or 2100us by chance?
> 
Hi!
  No, it is not. It's nx9010. However, I've got a new information from its
owner and it looks that the system is broken in more ways, for example the
system freezes in X until a key is pressed or the mouse moved and the time
is losing permanently. So just now I suspect the dyntick patch, which I've
compiled in to maximize battery life. As soon as I get access to it, I'll
disable it and let's see what happens. It's interesting, that the system
was able to compile its own kernel as well as perform all the installation
tasks without a glitch.
                         With regards, Pavel Troller
