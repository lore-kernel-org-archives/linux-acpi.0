From: Mirco Jeske <m.jeske@web.de>
Subject: active[0] being ignored
Date: Wed, 21 Mar 2007 20:46:34 +0100
Message-ID: <46018B9A.7060106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:44375 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933825AbXCUTqF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Mar 2007 15:46:05 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 418E16CFA7CB
	for <linux-acpi@vger.kernel.org>; Wed, 21 Mar 2007 20:46:04 +0100 (CET)
Received: from [82.83.120.119] (helo=[192.168.1.6])
	by smtp08.web.de with asmtp (WEB.DE 4.107 #114)
	id 1HU6l1-0003ty-00
	for linux-acpi@vger.kernel.org; Wed, 21 Mar 2007 20:46:04 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,
I have an asus A3G with opensuse 10.2 running. My trip points are

critical (S5):           99 C
passive:                 60 C: tc1=2 tc2=10 tsp=100 devices=0xdffec504
active[0]:               75 C: devices=0xdffe157c

I do not have an active[1] point. My cooling_mode is active. Therefore I
would expect the fan to start cooling as soon as the temperature
reaches  the 75C mark. Instead, the fan runs even if the temperature is
like 45C. Sometimes the fan goes on and off several times within a short
period of time so it starts to be annoying.

Is there a way to force the fan to only run at 75C?

thx, Mirco

