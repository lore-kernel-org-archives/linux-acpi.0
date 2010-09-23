From: Thawan Kooburat <kthawan@gmail.com>
Subject: Questions about ACPI and PCI interrupt routing
Date: Thu, 23 Sep 2010 12:06:30 -0500
Message-ID: <AANLkTinoAuRE5nmwpUo9gjc-qda6y08gEZxEUvOkN2GL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59181 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab0IWRGc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Sep 2010 13:06:32 -0400
Received: by ewy23 with SMTP id 23so529631ewy.19
        for <linux-acpi@vger.kernel.org>; Thu, 23 Sep 2010 10:06:31 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Short:
Is it possible to use static interrupt routing on a machine that
support configurable interrupt (via PCI Link Device)? So that kernel
will go to IOAPIC chip directly instead of using ACPI layer (such as
_CRS method) to manage the interrupt

Long:
I am trying to resume a kernel in a machine with different hardware
which results in many hardware miss match problem. Right now I am
looking into the interrupt issue. The machines I am testing support
different interrupt routing model (Dynamic and Static). I am not sure
if a machine that support dynamic routing will also support static
routing or not. So is it possible to force the kernel to use only
static model only? Bypassing ACPI layer has better chance of success
because I think that the resume kernel does not have a correct ACPI
handler to deal with the new device.

My understanding may be incorrect because I just read a portion of
ACPI spec and the kernel source that related to this issue.



-- 
Thawan Kooburat

Graduate Student
Department of Computer Science
UW-Madison
