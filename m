From: Sebastian Pohl <sebastianp@uni-koblenz.de>
Subject: Sony Vaio SZ61MN - no fanspeed control
Date: Wed, 30 Jul 2008 21:08:53 +0200
Message-ID: <4890BC45.2000807@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from deliver.uni-koblenz.de ([141.26.64.15]:27904 "EHLO
	deliver.uni-koblenz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbYG3TIz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 15:08:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by deliver.uni-koblenz.de (Postfix) with ESMTP id 788C778983C5
	for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2008 21:08:54 +0200 (CEST)
Received: from deliver.uni-koblenz.de ([127.0.0.1])
 by localhost (deliver.uni-koblenz.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22839-10 for <linux-acpi@vger.kernel.org>;
 Wed, 30 Jul 2008 21:08:52 +0200 (CEST)
Received: from [192.168.178.20] (dslb-084-063-015-006.pools.arcor-ip.net [84.63.15.6])
	by deliver.uni-koblenz.de (Postfix) with ESMTP id 469A8789830B
	for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2008 21:08:52 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi there!

In the process of havin multiple issues with acpi and drivers on my Sony 
laptop i stepped into another. The internal fan is always running at a 
fixed speed. If theres much CPU load it also speeds up. But i have no 
way to alter the speed. It always changes back to some sort of default 
value. Are there other ways to change the fanspeed than spicctrl with 
the sonypi module or direct echoing to the fan files made by the acpi 
stuff?

This could be dangerous for the hardware as it seems like it doesnt 
speed up to the highest level so the laptop gets very hot. Also it 
negatively affects the battery uptime.

Thanks!

regards

         sebastian
