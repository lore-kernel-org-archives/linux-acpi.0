From: Pavel Troller <patrol@sinus.cz>
Subject: Re: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 13:29:25 +0100
Message-ID: <20070123122925.GA27150@tangens.sinus.cz>
References: <20070123104010.GB7135@fscked.org>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:51729 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964851AbXAWMgQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 07:36:16 -0500
Content-Disposition: inline
In-Reply-To: <20070123104010.GB7135@fscked.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Perry <mikepery@fscked.org>
Cc: linux-acpi@vger.kernel.org

> Throw this one in the running for strangest bug ever:
> 
> For some reason, on 2.6.17-2.6.19(+others?) the acpi_processor_idle
> loop enabled by CONFIG_ACPI_PROCESSOR is causing my laptop's speakers
> to buzz.. If the option is disabled or built as a module (or if I run
> both my CPUs' usage up to 100%), the speakers are silent.
> 
Hi!
  Your problem is related to hardware - poor filtering of power buses, causing
current peaks to penetrate to the sound circuitry (or possibly causing some
other hardware like a ferrite transformer) to emit sound.
  By entering deeper sleep states (especially C3), power consumption of the
CPU substantially reduces. By returning to C0, it increases again. These
events happen periodically, thus causing a continuous wave to be produced.
  When the system is not idle (working), the acpi CPU module is removed (so no
sleeping) or USB is busy (so no C3, because of high BM activity), there is no
reason for the sound.
                   With regards, Pavel Troller
