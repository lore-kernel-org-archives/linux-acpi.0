From: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@L-3Com.com>
Subject: Hibernate
Date: Wed, 12 Apr 2006 07:50:37 -0500
Message-ID: <7736DD1D5D6EDD4081B590872B56DCCC0C29F913@gvlexch01.gvl.is.l-3com.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpout1.l-3com.com ([128.170.207.211]:63860 "EHLO
	smtpout1.L-3com.com") by vger.kernel.org with ESMTP id S932171AbWDLMuw
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Apr 2006 08:50:52 -0400
Received: from gvlmailhub.gvl.is.l-3com.com (gvlmailhub.gvl.l-3com.com [138.254.134.153])
	by isDNS.is.l-3com.com  with ESMTP id k3CCh64v026940
	for <linux-acpi@vger.kernel.org>; Wed, 12 Apr 2006 07:43:06 -0500
Received: from gvlexch01.gvl.is.l-3com.com (gvlexch01.gvl.is.l-3com.com [138.254.134.121])
	by gvlmailhub.gvl.is.l-3com.com (8.11.6/8.11.6) with ESMTP id k3CCokl08804
	for <linux-acpi@vger.kernel.org>; Wed, 12 Apr 2006 07:50:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm trying to get hibernate to work on CentOS 4.  What I really want to do
is use hibernate to start-up the machine every time.  To do this I would
create an "image" to come out of hibernate with and set the machine to
always think it's coming out of hibernate, no matter how it was actually
shut down.  It would always use my "image", even if it was placed in
hibernate when it shut down.  Without rewriting other people's code does
anyone know of a way to do this?
 
Thank you,
Allan
