From: Pavel Troller <patrol@sinus.cz>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 11:14:48 +0100
Message-ID: <20060203101448.GA16010@tangens.sinus.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com> <1138958502.18273.1.camel@localhost.localdomain> <20060203093335.GA4403@tangens.sinus.cz> <1138959572.18273.18.camel@localhost.localdomain>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:36819 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1751158AbWBCKOw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 05:14:52 -0500
Content-Disposition: inline
In-Reply-To: <1138959572.18273.18.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-acpi@vger.kernel.org

> 
> Still I don't get it. Current linux acpi implementation suggests there
> are 8 C states. My laptop says the processor supports 4 C states, my
> other laptop says it has 3 C states. Do you mean the table always has 8
> C entries, and all of the unusable states are marked "unusable"? In that
> case I would understand.
The problem is that there are more methods to describe C states. C2 and C3
are always present in RSDT. The remaining ones should be presented over
DSDT. In this case, it is dynamic, so any number of states can be added,
or even modified at runtime.
                         With regards, Pavel Troller

