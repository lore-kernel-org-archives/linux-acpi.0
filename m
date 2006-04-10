From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [PATCH ACPI] memory leakages in driver/acpi/video.c
Date: Mon, 10 Apr 2006 10:23:26 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1190C97@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60032 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750895AbWDJCXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Apr 2006 22:23:44 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasily Averin <vvs@sw.ru>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, Kirill Korotaev <dev@sw.ru>, devel@openvz.org
Cc: Andrew Morton <akpm@osdl.org>


>acpi_video_bus_get_one_device() and other functions in 
>driver/acpi/video.c do
>not release allocated memory on remove and on the error path.
>
>Signed-off-by: Vasily Averin <vvs@sw.ru>
>

Acked!

--Luming
