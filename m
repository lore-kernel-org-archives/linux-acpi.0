From: Pavel Troller <patrol@sinus.cz>
Subject: Re: [patrol@sinus.cz: Problem suspending Clevo D650SU notebook in 2.6.18]
Date: Fri, 29 Sep 2006 14:35:58 +0200
Message-ID: <20060929123558.GA10107@tangens.sinus.cz>
References: <20060929053037.GA11335@tangens.sinus.cz> <200609291411.52636.rjw@sisk.pl>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:48011 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1161046AbWI2MhL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Sep 2006 08:37:11 -0400
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5.20060308/8.13.5) with ESMTP id k8TCb9IK010378
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2006 14:37:09 +0200
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5.20060308/8.13.5/Submit) id k8TCb90E010377
	for linux-acpi@vger.kernel.org; Fri, 29 Sep 2006 14:37:09 +0200
Content-Disposition: inline
In-Reply-To: <200609291411.52636.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>

> 
> Please try to unload the acpi_cpufreq module before the suspend.  If that
> helps, please add your system information to the bugzilla entry at
> http://bugzilla.kernel.org/show_bug.cgi?id=7188
> 
Hi!
   GREAT! It helped perfectly, now both STR as well as STD work as before.
   I will update bugzilla ASAP.
     With regards, Pavel Troller
