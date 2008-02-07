From: Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: suspend to ram problem
Date: Thu, 07 Feb 2008 21:12:06 +0100
Message-ID: <47AB6616.4040401@tlen.pl>
References: <47A5C399.7010405@free.fr> <47AA3763.7000106@free.fr> <20080206224308.GA1630@elf.ucw.cz> <200802070003.05543.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tur.go2.pl ([193.17.41.50]:58011 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934480AbYBGUOi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 15:14:38 -0500
Received: from poczta.o2.pl (mx12.go2.pl [193.17.41.142])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id DA6BA230F5C
	for <linux-acpi@vger.kernel.org>; Thu,  7 Feb 2008 21:14:34 +0100 (CET)
Received: from poczta.o2.pl (mx12 [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id 8A9103E8139
	for <linux-acpi@vger.kernel.org>; Thu,  7 Feb 2008 21:12:23 +0100 (CET)
Received: from [10.1.1.146] (i01m-62-35-173-211.d4.club-internet.fr [62.35.173.211])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP
	for <linux-acpi@vger.kernel.org>; Thu,  7 Feb 2008 21:12:22 +0100 (CET)
In-Reply-To: <200802070003.05543.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have read somewhere that the problem appeared at the beginning of 
2.6.24 development. I'm using pure 2.6.23 (sony vaio laptop) and I have 
experienced the problem of returning from suspend to ram as well. It 
always occurs when the battery is present in the slot and never without 
it. I did not have such problem with 2.6.19-rc3. I tried the 2.6.23-12 
and 2.6.24 but without any better.
If you need any details about my configuration write me please.
regards
cacy
