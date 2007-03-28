From: Mirco Jeske <m.jeske@web.de>
Subject: Re: active[0] being ignored
Date: Wed, 28 Mar 2007 07:21:45 +0200
Message-ID: <4609FB69.9020008@web.de>
References: <46018B9A.7060106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:39593 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933601AbXC1FV1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Mar 2007 01:21:27 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 028F26EF7E34
	for <linux-acpi@vger.kernel.org>; Wed, 28 Mar 2007 07:21:26 +0200 (CEST)
Received: from [82.83.94.226] (helo=[192.168.1.6])
	by smtp08.web.de with asmtp (WEB.DE 4.107 #114)
	id 1HWQb7-0006Rv-00
	for linux-acpi@vger.kernel.org; Wed, 28 Mar 2007 07:21:25 +0200
In-Reply-To: <46018B9A.7060106@web.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi again,
I read many articles about my A3G and found some windows users who were
be able to exactly control the point of activation for the fan.
Therefore I think it must be possible for linux users to do the same.
The activation of my fan has something to do with CPU usage, every time
the CPU is being charged the fan starts cooling. Even this this would
mean for just one single second. The fan goes on and of but the CPU's
usage never goes above 10% or so. Now I would like the fan to ignore CPU
usage and only listen to the temp points. I don't know how to do it.

Please, can anybody help me out.....?

Thank you so much,
Mirco

Mirco Jeske schrieb:
> Hi all,
> I have an asus A3G with opensuse 10.2 running. My trip points are
>
> critical (S5):           99 C
> passive:                 60 C: tc1=2 tc2=10 tsp=100 devices=0xdffec504
> active[0]:               75 C: devices=0xdffe157c
>
> I do not have an active[1] point. My cooling_mode is active. Therefore I
> would expect the fan to start cooling as soon as the temperature
> reaches  the 75C mark. Instead, the fan runs even if the temperature is
> like 45C. Sometimes the fan goes on and off several times within a short
> period of time so it starts to be annoying.
>
> Is there a way to force the fan to only run at 75C?
>
> thx, Mirco
>
>
>   
