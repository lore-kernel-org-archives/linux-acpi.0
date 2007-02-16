From: "Andras Lorincz" <andras.lorincz@gmail.com>
Subject: Help with fan on fujitsu siemens
Date: Fri, 16 Feb 2007 09:46:42 +0200
Message-ID: <a21d779b0702152346l35b83cadw2d2b4e9f3939da7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.237]:57404 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbXBPHqo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 02:46:44 -0500
Received: by qb-out-0506.google.com with SMTP id z8so249274qbc
        for <linux-acpi@vger.kernel.org>; Thu, 15 Feb 2007 23:46:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The output of ls /proc/acpi/thermal_zone is:

THRM

the output of ls /proc/acpi/thermal_zone/THRM is:

cooling_mode  polling_frequency  state  temperature
trip_points

and the output of cat /proc/acpi/thermal_zone/*/* is:

cooling mode:   active
polling frequency:       30 seconds
state:                   ok
temperature:             49 C
critical (S5):           105 C
passive:                 79 C: tc1=3 tc2=1 tsp=80
devices=0xf7e9c720
active[0]:               65 C: devices=0xc17e4d9c
active[1]:               55 C: devices=0xc17e4d38

Some remarks:

 - the polling frequency is not set by default so I
run a script on startup which sets the polling
frequency to 30 secs
 - the state reported by
/proc/acpi/thermal_zone/THRM/state changes correctly
according to changing temperatures but it is not in
accordance with the real state of the cooler.
