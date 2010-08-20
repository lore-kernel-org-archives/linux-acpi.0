From: jean-philippe francois <jp.francois@cynove.com>
Subject: System time drifts when processor idle.
Date: Fri, 20 Aug 2010 10:55:07 +0200
Message-ID: <AANLkTi=ivkOHRYwLy5FDg3RnK18+opjGd9XsxC7yZqi7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36533 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0HTIzK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Aug 2010 04:55:10 -0400
Received: by vws3 with SMTP id 3so2821364vws.19
        for <linux-acpi@vger.kernel.org>; Fri, 20 Aug 2010 01:55:09 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Please correct me if I am sending this to the wrong list.

I would like to debug the following issue, which I suspect is related
to cpu losing track of time when going idle.

When I run the following script :

#!/bin/bash
# set hwclock to system clock to start
# the log file with the same time
hwclock -w
#start with a fresh logfile
touch clocktest.log
echo START > clocktest.log
while [[ true ]]
do
    systime=$(date)
    hwtime=$(hwclock -r)
    echo "$systime | $hwtime" >> clocktest.log
    sleep 20
done

Expected output :
On each line, the system time (left) and hardware time (right)
should be roughly the same. Time delta between each line should be
around 20 seconds

Observed output :
This is an edited version of the real logfile  so that it fits on one
line. the date was removed.
START
15:09:43 (UTC+0200) |  15:09:44 CEST -0.500555 secondes
15:10:04 (UTC+0200) |  15:10:05 CEST -1.001562 secondes
15:10:25 (UTC+0200) |  15:10:26 CEST -0.985944 secondes
15:10:46 (UTC+0200) |  15:15:46 CEST -0.032792 secondes <-- 5 minute lag !
15:11:06 (UTC+0200) |  15:16:07 CEST -0.985926 secondes
15:11:27 (UTC+0200) |  15:16:28 CEST -1.001539 secondes
15:11:48 (UTC+0200) |  15:16:49 CEST -0.985969 secondes
15:12:09 (UTC+0200) |  15:17:10 CEST -0.985977 secondes
15:12:30 (UTC+0200) |  15:17:31 CEST -1.001544 secondes
15:12:51 (UTC+0200) |  15:17:52 CEST -0.985920 secondes
15:13:12 (UTC+0200) |  15:18:13 CEST -0.985939 secondes
15:13:33 (UTC+0200) |  15:18:34 CEST -1.001581 secondes
15:13:54 (UTC+0200) |  15:18:55 CEST -0.985917 secondes
15:14:15 (UTC+0200) |  15:29:15 CEST -0.079685 secondes <-- add
another 10 minute
15:14:35 (UTC+0200) |  15:29:36 CEST -1.001568 secondes
15:14:56 (UTC+0200) |  15:29:57 CEST -0.985952 secondes

As you can see, after 20 minutes without touching the computer, the
system time is late by 15 minutes.
This was tested on ubuntu 10.04 with a 2.6.32  "vanilla" kernel where
"vanilla" means ubuntu packaged
upstream kernel  closest to the distribution shipped kernel.

How can I debug and possibly fix this issue ?
