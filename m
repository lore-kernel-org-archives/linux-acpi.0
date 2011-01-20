From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: ACPI notify handler and reentrancy of WMI device.
Date: Thu, 20 Jan 2011 11:10:47 +0100
Message-ID: <AANLkTim3MUik=DQZMvqYexaPwXORaTQ=NdRgC9wZ3x1E@mail.gmail.com>
References: <AANLkTi=hBDt+Ej+hNcxxnw4ZjPZ930kR13DVjtt50zwD@mail.gmail.com>
	<AANLkTim0auvcUeDSO7QGSVbj0A+g88FSon7-qT6KzBHd@mail.gmail.com>
	<1295229942.28388.87.camel@minggr.sh.intel.com>
	<AANLkTinfP+-L2T4oggiTpMwE74V6kxgcrStHumYGiH23@mail.gmail.com>
	<1295517311.11852.7.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42005 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344Ab1ATKKs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jan 2011 05:10:48 -0500
In-Reply-To: <1295517311.11852.7.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>

> What does this method do?

It does ... *everything*, it's our only entry point in this driver.

-- 
Corentin Chary
http://xf.iksaif.net
