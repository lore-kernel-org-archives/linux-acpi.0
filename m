From: 7eggert@gmx.de
Subject: [Bug 68591] - Please help debugging
Date: Sat, 18 Jan 2014 22:59:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1401182225170.776@be1.lrz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:45034 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751493AbaARW70 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Jan 2014 17:59:26 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id DF673D8501
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jan 2014 23:59:24 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id DC57D31A004
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jan 2014 23:59:24 +0100 (CET)
Received: from be1.7eggert.dyndns.org (95-91-230-144-dynip.superkabel.de [95.91.230.144])
	(Authenticated sender: x7eggert@arcor.de)
	by mail-in-09.arcor-online.net (Postfix) with ESMTPSA id CA6F61975C0
	for <linux-acpi@vger.kernel.org>; Sat, 18 Jan 2014 23:59:24 +0100 (CET)
Received: from 7eggert (helo=localhost)
	by be1.7eggert.dyndns.org with local-esmtp (Exim 4.80)
	(envelope-from <7eggert@gmx.de>)
	id 1W4erK-0000EE-3z
	for linux-acpi@vger.kernel.org; Sat, 18 Jan 2014 22:59:22 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I need some help debugging and possibly fixing this bug. E.g. "do 
bisecting in spite of the big version difference" or "use these debugging 
parameters".

https://bugzilla.kernel.org/show_bug.cgi?id=68591
"Regression: Asrock M3A UCC does not boot without acpi=off or pci=noacpi"

thanks in advance
	Bodo Eggert
