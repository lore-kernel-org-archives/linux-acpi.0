From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Fauberteau?= <frederic@fauberteau.org>
Subject: Samsung N150 Plus LID status changes half the time after S3 sleep
Date: Thu, 02 Oct 2014 03:20:33 +0200
Message-ID: <45f8bc46f1232541306998d5fff1383c@fauberteau.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zergling.triaxx.org ([62.210.76.52]:59126 "EHLO
	zergling.triaxx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbaJBB0e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 21:26:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zergling.triaxx.org (Postfix) with ESMTP id 97FE9C725E
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2014 03:20:10 +0200 (CEST)
Received: from zergling.triaxx.org ([127.0.0.1])
	by localhost (mail.triaxx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lTHm7zRX7BhH for <linux-acpi@vger.kernel.org>;
	Thu,  2 Oct 2014 03:20:10 +0200 (CEST)
Received: from mail.triaxx.org (unknown [192.168.0.3])
	by zergling.triaxx.org (Postfix) with ESMTP id E6FF3C723F
	for <linux-acpi@vger.kernel.org>; Thu,  2 Oct 2014 03:20:09 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

Since I recently install a 3.16.3 kernel on my netbook, I notice a 
strange behavior. When I open my screen, the netbook wakes up but the 
status of LID doesn't change, it remains to "state: closed". So after 
some seconds, it suspends again. Surprisingly, if a close my screen 
(when the netbook is suspend) and open it again, the state changes to 
open.

I notice the discussion about similar problem with 3.14. I already look 
at the resulting patch.

I'm not waiting for a turnkey solution but I would like to investigate 
the problem. Do you have any leads and some advices to start to debug 
that ?

Somes information:
# uname -r
3.16.3-1-ARCH
# dmidecode -s system-manufacurer
SAMSUNG ELECTRONICS CO., LTD
# dmidecode -s product-name
N150P

Best regards,
