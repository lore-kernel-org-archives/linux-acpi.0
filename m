From: "Pieter De Wit" <Pieter.DeWit@vodacom.co.za>
Subject: RE: Fan speeds on HP nc6400 and nc8430
Date: Mon, 29 Jan 2007 11:13:42 +0200
Message-ID: <C3FA62B1A90D7440B9B6C7C31895994F03663675@zadbn02100.vodacom.corp>
References: <45B100A0.40305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mfwj032.mfw.is.co.za ([196.35.77.38]:1962 "EHLO
	mfwj032.mfw.is.co.za" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282AbXA2JOy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jan 2007 04:14:54 -0500
Content-class: urn:content-classes:message
In-Reply-To: <45B100A0.40305@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi Guys,

I tried the suggestion below and it didn't seem to change anything - I
even set the same trip points to TZ1. The fans still seem to spin faste=
r
in Linux compared to Windows. Then the other issue is that I can't
switch a fan off once I force it on.

Thanks,

Pieter


Show:
cat /proc/acpi/thermal_zone/TZ0/trip_points

or change TZ0 to TZ1

=46or many HP notebooks first trip point is to low. To change manually,
for example:

echo "105:100:100:78:70:60:50" > /proc/acpi/thermal_zone/TZ0/trip_point=
s
echo 10  > /proc/acpi/thermal_zone/TZ0/polling_frequency

Then I have:
maciek@rutek:~$ cat /proc/acpi/thermal_zone/TZ0/trip_points
critical (S5):           105 C
active[0]:               78 C: devices=3D0xcf7aea40
active[1]:               70 C: devices=3D0xcf7ae9dc
active[2]:               60 C: devices=3D0xcf7ae98c
active[3]:               50 C: devices=3D0xcf7ae93c

maciek@rutek:~$ cat /proc/acpi/thermal_zone/TZ0/polling_frequency
polling frequency:       10 seconds

--
Maciej Rutecki <maciej.rutecki@gmail.com> http://www.unixy.pl LTG -
Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

=93This e-mail is sent on the Terms and Conditions that can be accessed=
 by Clicking on this link http://www.vodacom.co.za/legal/email.jsp "
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
