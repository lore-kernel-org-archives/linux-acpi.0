From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [2.6 patch] drivers/acpi/video.c: fix a NULL pointer dereference
Date: Sun, 12 Mar 2006 22:33:59 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006597182@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:9881 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751275AbWCMDfG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Mar 2006 22:35:06 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

applied,
thanks,
-len


>-	if (!obj && (obj->type != ACPI_TYPE_PACKAGE)) {
>+	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
