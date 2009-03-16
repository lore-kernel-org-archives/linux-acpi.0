From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Subject: Backward compatibility to ACPI 2
Date: Mon, 16 Mar 2009 10:58:15 +0100
Message-ID: <49BE22B7.6020700@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:44831 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbZCPK26 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 06:28:58 -0400
Received: from cyclope.frec.bull.fr (cyclope.frec.bull.fr [129.183.4.9])
	by ecfrec.frec.bull.fr (Postfix) with ESMTP id 6DD8E6F5CE
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2009 10:58:15 +0100 (CET)
Received: from openx1.frec.bull.fr (openx1.frec.bull.fr [129.183.160.2])
	by cyclope.frec.bull.fr (Postfix) with ESMTP id 0507E2728D
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2009 10:58:14 +0100 (CET)
Received: from openx1.frec.bull.fr (localhost [127.0.0.1])
	by openx1.frec.bull.fr (Postfix) with ESMTP id 51E8C13A01
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2009 10:58:15 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Recent kernels, e.g. 2.6.29-rc7, assume ACPI 3 data structures
without verifying the revision of e.g. the SRAT.
Therefore machines with "old" SRAT cannot be configured correctly.
E.g. the Proximity Domain in the Memory Affinity Structure has got
different field length (1 vs. 4 bytes).

Have you got a plan to determine at run time the ACPI version?

Which was the last kernel supporting the ACPI 2?

Thanks,

Zoltan Menyhart



