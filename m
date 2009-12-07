From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCHv2 0/2] Introducing the Ambient Light Sensor (ALS) class
Date: Mon, 07 Dec 2009 15:02:34 +0000
Message-ID: <4B1D190A.1060300@cam.ac.uk>
References: <1259581514-15356-1-git-send-email-amit.kucheria@verdurent.com> <37786d4b0912070650g7ba7604bv63365a21f980501d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:57866 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbZLGPBn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 10:01:43 -0500
In-Reply-To: <37786d4b0912070650g7ba7604bv63365a21f980501d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, khali@linux-fr.org, alan@linux.intel.com, linux-acpi@vger.kernel.org, gregkh@suse.de, Andrew Morton <akpm@linux-foundation.org>

Amit Kucheria wrote:
> On Mon, Nov 30, 2009 at 1:45 PM, Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
>> Introduce a new class of devices to handle ambient light sensors. Currently
>> only one sysfs inteface, 'illuminance' is introduced. More will be added as
>> drivers are ported to use this new class.
>>
>> Amit Kucheria (1):
>>  als: add unique device-ids to the als device class
>>
>> Zhang Rui (1):
>>  introduce ALS sysfs class
>>
>>  Documentation/ABI/testing/sysfs-class-als |    9 ++
>>  MAINTAINERS                               |    6 ++
>>  drivers/Kconfig                           |    2 +
>>  drivers/Makefile                          |    1 +
>>  drivers/als/Kconfig                       |   10 +++
>>  drivers/als/Makefile                      |    5 +
>>  drivers/als/als_sys.c                     |  116 +++++++++++++++++++++++++++++
>>  include/linux/als_sys.h                   |   35 +++++++++
>>  8 files changed, 184 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-als
>>  create mode 100644 drivers/als/Kconfig
>>  create mode 100644 drivers/als/Makefile
>>  create mode 100644 drivers/als/als_sys.c
>>  create mode 100644 include/linux/als_sys.h
>>
> 
> (Bump)
> 
> Is there any blocker to adding this for 2.6.33? Which maintainer will
> pick up the ALS framework?
None that I know of.  Rui offered to maintain ALS, so I guess he could send
a pull request from suitable git tree directly or talk someone else into doing it.

Andrew might be willing?

> 
> Rui, do you have an updated patch for the ACPI ALS driver?
> 
> Regards,
> Amit
> 

