From: Lucas Levrel <lucas.levrel@free.fr>
Subject: Help/info request (in re trip points)
Date: Fri, 22 Jul 2016 10:22:15 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.13.1607221012230.4463@coulomb.u-pec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gulliver.u-pec.fr ([193.48.143.11]:47928 "EHLO
	gulliver.u-pec.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbcGVItV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jul 2016 04:49:21 -0400
Received: from gulliver.u-pec.fr (localhost [127.0.0.1])
	by gulliver.u-pec.fr (Postfix) with ESMTP id 1606AC1D6E
	for <linux-acpi@vger.kernel.org>; Fri, 22 Jul 2016 10:22:16 +0200 (CEST)
Received: from [10.12.3.100] (unknown [10.12.3.100])
	by gulliver.u-pec.fr (Postfix) with ESMTP id EEA14C1D65
	for <linux-acpi@vger.kernel.org>; Fri, 22 Jul 2016 10:22:15 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi,

Is this the right place to request for help and/or information about 
thermal zones? If not, please point me to the right place.

I browsed through thermal.c but couldn't find an answer to my question 
(it goes without saying I'm not an expert), namely:
how are trip point temperatures set at boot, and how are they reset when 
crossed?

I'm aiming at changing the temperatures at which the fan starts and stops. 
The kernel parameter thermal.act=XXX did change the "fan on" temperature, 
but not the "fan off" one. I expected the hysteresis T(on)-T(off) to be 
constant, and thus I thought T(off) would raise as much as I raised T(on), 
but this is not the case.

Any help is greatly appreciated.

Lucas Levrel


